﻿#if (addConfig)
using Microsoft.Extensions.Configuration;
#endif
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Serilog;
using System;
using System.IO;

namespace Janda.Chime.Converter
{
    class Program : IApplicationProgram
    {        
        static int Main(string[] args)
        {
            return Application.Run<Program>(args);
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
                .AddSingleton<IProgramService, ProgramService>();
        }

        public void InitializeApplication(ProgramOptions options)
        {
            CreateLogger(options);
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

        private void CreateLogger(ProgramOptions options)
        {
            var loggerConfiguration = new LoggerConfiguration()
                .WriteTo.ColoredConsole();

            if (!string.IsNullOrEmpty(options.LogDir))
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

        public void UnhandledException(Exception ex)
        {
            var logger = Application.GetService<ILogger<Application>>();

            if (logger != null)
                logger.LogCritical(ex, ex.Message);
            else
                Console.WriteLine(ex.Message);
        }

        #endregion
    }
}
