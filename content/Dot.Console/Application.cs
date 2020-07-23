using System;
using System.Reflection;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;

<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    internal class Application
    {
        public static IServiceProvider Services { get; private set; }
        public static IApplicationOptions Options { get; private set; }
        public static IConfiguration Configuration { get; private set; }
        public static string Version { get; private set; }
        public static string Name { get; private set; }


        static Application()
        {
            Name = AppDomain.CurrentDomain.FriendlyName;
            Version = Assembly.GetEntryAssembly()
                .GetCustomAttribute<AssemblyInformationalVersionAttribute>()
                .InformationalVersion;
        }

        public static int Run<TProgram>(Func<Func<object, int>, int> parseArgs) where TProgram : IProgram, new()
        {
            try
            {
                var program = new TProgram();

                return parseArgs(options =>
                {
                    Options = new ApplicationOptions()
                    {
                        RunOptions = options as IRunOptions
                    };

                    var services = new ServiceCollection();
                    var settings = new ApplicationSettings();

                
                    Configuration = program.CreateConfiguration();
                    Configuration.Bind(Name, settings);

                    services
                        .AddLogging(configure => program.ConfigureLogging(configure))
                        .AddSingleton(Options)
                        .AddSingleton<IApplicationSettings>(settings);

                    program.ConfigureServices(services);

                    return (Services = services.BuildServiceProvider())
                        .GetService<IApplicationService>()
                        .Run();                
                });
            }
            catch (Exception ex)
            {
                var logger = GetService<ILogger<Application>>();

                if (logger != null)
                    logger.LogCritical(ex, ex.Message);
                else
                    Console.WriteLine($"{ex.Message}\n{ex.StackTrace}");

                return ex.HResult;
            }
        }

        public static T GetService<T>()
        {
            return Services != null
                ? Services.GetService<T>()
                : default;
        }
    }
}
