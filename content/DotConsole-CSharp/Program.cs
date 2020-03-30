using System;
using System.IO;
#if (addConfig)
using Microsoft.Extensions.Configuration;
#endif
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using CommandLine;
using Serilog;

namespace Dot.Console
{
    class Program : IApplicationProgram
    {        
        static int Main(string[] args)
        {
              return Application.Run<Program, Options>(options => Parser.Default.ParseArguments<Options>(args)
                .WithParsed(options));
        }

        #region IApplicationProgram

        public void ConfigureServices(IServiceCollection serviceCollection)
        {
            serviceCollection
#if (addConfig)
                .AddLogging(ConfigureLogging)
#else
                .AddLogging(logging => logging.AddSerilog())
#endif
                .AddSingleton<IApplicationService, ApplicationService>();
        }

        public void InitializeApplication()
        {
            CreateLogger();
        }

        public void FinalizeApplication()
        {
            Log.CloseAndFlush();
        }

#if (addConfig)
        public IConfiguration CreateConfiguration()
        {
            return new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", true, true)
                .AddJsonFile($"appsettings.{Environment.GetEnvironmentVariable("NETCORE_ENVIRONMENT") ?? "Production"}.json", optional: true)
                .Build();
        }
#endif

        private void CreateLogger()
        {
            var loggerConfiguration = new LoggerConfiguration()
                .WriteTo.ColoredConsole();

            var options = Application.Options as Options;

            if (!string.IsNullOrEmpty(options?.LogDir))
                loggerConfiguration.WriteTo.File(
                    path: $"{options.LogDir}\\{Path.ChangeExtension(Application.Name, "log")}",
                    rollingInterval: RollingInterval.Day);

            Log.Logger = loggerConfiguration.CreateLogger();
        }

#if (addConfig)
        private void ConfigureLogging(ILoggingBuilder logging)
        {
            logging.AddConfiguration(Application.Configuration)
                .AddSerilog(dispose: true);
        }
#endif

        public int UnhandledException(Exception ex)
        {
            ILogger<Application> logger;

            (logger = Application.GetService<ILogger<Application>>())
                ?.LogCritical(ex, ex.Message);

            if (logger == null)
                Console.WriteLine($"{ex.Message}\n{ex.StackTrace}");

            return -1;
        }

        #endregion
    }
}
