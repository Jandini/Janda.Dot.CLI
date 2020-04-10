using System;
using System.Reflection;
#if (addConfig)
using Microsoft.Extensions.Configuration;
#endif
using Microsoft.Extensions.DependencyInjection;


namespace Dot.Console
{

    internal class Application
    {
#if (addConfig)
        public static IConfiguration Configuration { get; private set; }
#endif
        public static IServiceProvider Services { get; private set; }
        public static IApplicationOptions Options { get; private set; }
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
            where TProgram: IApplicationProgram, new() 
            where TOptions: IApplicationOptions
        {
            var applicationProgram = new TProgram();
            int returnCode = 0; 

            try
            {              
                parseArgs(options =>
                {
                    Options = options;

                    var serviceCollection = new ServiceCollection();
                    serviceCollection.AddSingleton<IApplicationOptions>(options);

                    try
                    {
                        applicationProgram.InitializeApplication();
#if (addConfig)
                        Configuration = applicationProgram.CreateConfiguration();
#endif
                        applicationProgram.ConfigureServices(serviceCollection);
  
                        returnCode = (Services = serviceCollection.BuildServiceProvider())
                            .GetService<IApplicationService>()
                            .Run();

                    }
                    catch (Exception ex)
                    {
                        returnCode = applicationProgram.UnhandledException(ex);
                    }
                    finally
                    {
                        applicationProgram.FinalizeApplication();
                    }
                });               
            }
            catch (Exception ex)
            {
                returnCode = applicationProgram.UnhandledException(ex);
            }
          
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
