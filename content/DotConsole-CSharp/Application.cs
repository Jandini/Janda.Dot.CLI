using System;
using System.Reflection;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
#if (addConfig)
using Microsoft.Extensions.Configuration;
#endif

namespace Dot.Console
{
    internal class Application
    {
        public static IServiceProvider Services { get; private set; }
        public static IApplicationOptions Options { get; private set; }
#if (addConfig)
        public static IConfiguration Configuration { get; private set; }
#endif
        public static string Version { get; private set; }
        public static string Name { get; private set; }


        static Application()
        {
            Name = AppDomain.CurrentDomain.FriendlyName;
            Version = Assembly.GetEntryAssembly()
                .GetCustomAttribute<AssemblyInformationalVersionAttribute>()
                .InformationalVersion;
        }

        public static int Run<TProgram, TOptions>(Action<Action<TOptions>> parseArgs)
            where TProgram : IApplicationProgram, new()
            where TOptions : IApplicationOptions
        {
            var applicationProgram = new TProgram();
            int returnCode = 0;

            parseArgs(options =>
            {
                Options = options;

                var serviceCollection = new ServiceCollection();

                try
                {
#if (addConfig)
                    Configuration = applicationProgram.CreateConfiguration();
#endif
                    serviceCollection.AddLogging(configure => applicationProgram.ConfigureLogging(configure));
                    serviceCollection.AddSingleton<IApplicationOptions>(options);

                    applicationProgram.ConfigureServices(serviceCollection);

                    returnCode = (Services = serviceCollection.BuildServiceProvider())
                        .GetService<IApplicationService>()
                        .Run();
                }
                catch (Exception ex)
                {
                    GetService<ILogger<Application>>()?.LogCritical(ex, ex.Message);
                    throw;
                }
            });

            return returnCode;
        }

        public static T GetService<T>()
        {
            return Services != null
                ? Services.GetService<T>()
                : default;
        }
    }
}
