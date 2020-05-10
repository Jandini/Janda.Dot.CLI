using System.IO;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using CommandLine;
using Serilog;

namespace Dot.Console
{
    class Program : IApplicationProgram
    {
        static int Main(string[] args)
        {
            return Application.Run<Program, Options>(options => Parser.Default.ParseArguments<Options>(args).WithParsed(options));
        }

        #region IApplicationProgram

        public void ConfigureServices(IServiceCollection serviceCollection)
        {
            serviceCollection
                .AddSingleton<IApplicationService, Service>();
        }

        public IConfiguration CreateConfiguration()
        {
            return new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", true, true)
                .AddJsonFile($"appsettings.{Environment.GetEnvironmentVariable("NETCORE_ENVIRONMENT") ?? "Production"}.json", optional: true)
                .Build();
        }

        public void ConfigureLogging(ILoggingBuilder loggingBuilder)
        {
            var loggerConfiguration = new LoggerConfiguration()
                .WriteTo.ColoredConsole();

            var applicationOptions = Application.Options as Options;

            if (!string.IsNullOrEmpty(applicationOptions?.LogDir))
                loggerConfiguration.WriteTo.File(
                    path: Path.Combine(applicationOptions.LogDir, Path.ChangeExtension(Application.Name, "log")),
                    rollingInterval: RollingInterval.Day);

            Log.Logger = loggerConfiguration.CreateLogger();

            loggingBuilder
                .AddConfiguration(Application.Configuration)
                .AddSerilog(dispose: true);
        }

        #endregion
    }
}