using Microsoft.Extensions.CommandLineUtils;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Serilog;
using System;
using System.IO;

namespace Dot.Console
{
    class Program : IApplication
    {
#if (addArgs)
        public static CommandOption Option { get; private set; }
        public static CommandOption Parameter { get; private set; }
        public static CommandArgument Argument { get; private set; }
#endif
        static int Main(string[] args)
        {
#if (addArgs)
            return Application.Run<Program>(args, (app) =>
            {
                if (string.IsNullOrEmpty(Argument.Value))
                {
                    app.ShowHelp();
                    throw new Exception("The argument is requred.");
                }

                app.ShowRootCommandFullNameAndVersion();
            });
#else
            return Application.Run<Program>(args, (app)=>app.ShowRootCommandFullNameAndVersion());
#endif
        }

        public int HandleException(Exception ex)
        {
            Console.WriteLine(ex.Message);
            return -1;
        }

        public void ConfigureApplication(CommandLineApplication application)
        {
            application.FullName = "Dot.Console";        
#if (addArgs)
            application.HelpOption("-h|--help");
            Option = application.Option("-o|--option", "Application option", CommandOptionType.NoValue);
            Parameter = application.Option("-p|--parameter", "Application parameter", CommandOptionType.SingleValue);
            Argument = application.Argument("-a|--argument", "Application argument", true);
#endif
        }

        public void InitializeApplication()
        {
            const string consoleOutput = "[{Timestamp:HH:mm:ss} {Level:u4}] {Message:jl}{NewLine}{Exception}";
            const string fileOutput = "{Timestamp:yyyy-MM-dd HH:mm:ss.fff zzz} [{Level:u3}] {Message:lj}{NewLine}{Exception}";

            Log.Logger = new LoggerConfiguration()
                .MinimumLevel.Debug()
                .WriteTo.ColoredConsole(outputTemplate: consoleOutput)
                .WriteTo.File(@"logs\" + Path.ChangeExtension(
                    AppDomain.CurrentDomain.FriendlyName, "log"), 
                    outputTemplate: fileOutput, 
                    rollingInterval: RollingInterval.Day)
                .CreateLogger();
        }

        public void FinalizeApplication()
        {
            Log.CloseAndFlush();
        }

        public IConfiguration CreateConfiguration()
        {
            return new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", true, true)
                .AddJsonFile($"appsettings.{Environment.GetEnvironmentVariable("NETCORE_ENVIRONMENT") ?? "Production"}.json", optional: true)
                .Build();
        }

        private void ConfigureLogging(ILoggingBuilder logging)
        {
            logging.AddConfiguration(Application.Configuration)
                .AddSerilog(dispose: true);
        }

        public void ConfigureServices(IServiceCollection serviceCollection)
        {
            serviceCollection
                .AddLogging(ConfigureLogging)
                .AddSingleton<IProgramService, ProgramService>();
        }
    }
}
