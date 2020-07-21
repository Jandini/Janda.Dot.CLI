using System.IO;
using System.Reflection;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.FileProviders;
using CommandLine;
using Serilog;
using Serilog.Sinks.SystemConsole.Themes;

<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    class Program : IProgram
    {
        static int Main(string[] args)
        {
            return Application.Run<Program, Options>(options => Parser.Default.ParseArguments<Options>(args).WithParsed(options));
        }

        public void ConfigureServices(IServiceCollection serviceCollection)
        {
            serviceCollection
                .AddSingleton<IApplicationService, ApplicationService>();
        }

        public IConfiguration CreateConfiguration()
        {
            const string APP_SETTINGS_FILE_NAME = "appsettings.json";
            
            using var appSettingsStream = new EmbeddedFileProvider(Assembly.GetEntryAssembly(), typeof(Program).Namespace)
                .GetFileInfo(APP_SETTINGS_FILE_NAME).CreateReadStream();

            return new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonStream(appSettingsStream)
                .AddJsonFile(APP_SETTINGS_FILE_NAME, true)
                .Build();
        }

        public void ConfigureLogging(ILoggingBuilder loggingBuilder)
        {
            var loggerConfiguration = new LoggerConfiguration()
                .ReadFrom.Configuration(Application.Configuration);

            var applicationOptions = Application.Options as Options;

            if (!string.IsNullOrEmpty(applicationOptions?.LogDir))
                loggerConfiguration.WriteTo.File(
                    path: Path.Combine(applicationOptions.LogDir, Path.ChangeExtension(Application.Name, "log")),
                    rollingInterval: RollingInterval.Day);

            loggingBuilder.AddSerilog(
                loggerConfiguration.CreateLogger(),
                dispose: true);
        }
    }
}