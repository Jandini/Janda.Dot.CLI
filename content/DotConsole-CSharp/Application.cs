using System;
using System.Reflection;
#if (addConfig)
using Microsoft.Extensions.Configuration;
#endif
using Microsoft.Extensions.DependencyInjection;
using CommandLine;

namespace Dot.Console
{

    internal class Application
    {
#if (addConfig)
        public static IConfiguration Configuration { get; private set; }
#endif
        public static IServiceProvider Services { get; private set; }
        public static string Version { get; private set; }
        public static string Name { get; private set; }


        static Application()
        {
            Name = AppDomain.CurrentDomain.FriendlyName;
            Version = Assembly.GetEntryAssembly()
                .GetCustomAttribute<AssemblyInformationalVersionAttribute>()
                .InformationalVersion;
        }

        public static int Run<TProgram>(string[] args) where TProgram : IApplicationProgram, new()
        {
            var applicationProgram = new TProgram();
            int returnCode = 0; 

            try
            {              
                Parser.Default.ParseArguments<ProgramOptions>(args).WithParsed(options =>
                {
                    var serviceCollection = new ServiceCollection();

                    try
                    {
                        applicationProgram.InitializeApplication(options);
#if (addConfig)
                        Configuration = applicationProgram.CreateConfiguration();
#endif
                        applicationProgram.ConfigureServices(serviceCollection);
  
                        serviceCollection.AddSingleton<IProgramOptions>(options);

                        returnCode = (Services = serviceCollection.BuildServiceProvider())
                            .GetService<IProgramService>()
                            .Run();
                    }
                    catch (Exception ex)
                    {
                        applicationProgram.UnhandledException(ex);
                    }
                    finally
                    {
                        applicationProgram.FinalizeApplication();
                    }
                });               
            }
            catch (Exception ex)
            {
                applicationProgram.UnhandledException(ex);
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
