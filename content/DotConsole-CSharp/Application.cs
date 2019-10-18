using System;
using System.Reflection;
using Microsoft.Extensions.CommandLineUtils;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace Dot.Console
{

    interface IApplication
    {
        IConfiguration CreateConfiguration();
        void InitializeApplication();
        void FinalizeApplication();
        void ConfigureApplication(CommandLineApplication application);
        void ConfigureServices(IServiceCollection serviceCollection);
        int HandleException(Exception ex);
    }

    internal class Application
    {
        public static IConfiguration Configuration { get; private set; }
        public static IServiceProvider Services { get; private set; }
        public static string Version { get; private set; }


        static Application()
        {
            Version = Assembly.GetEntryAssembly()
                .GetCustomAttribute<AssemblyInformationalVersionAttribute>()
                .InformationalVersion;
        }

        public static int Run<TProgram>(string[] args, Action<CommandLineApplication> callback = null) where TProgram : IApplication, new()
        {
            var program = new TProgram();

            try
            {
                var serviceCollection = new ServiceCollection();
                var application = new CommandLineApplication(true)
                {
                    ShortVersionGetter = () => { return Version; }
                };

                program.ConfigureApplication(application);

                application.OnExecute(() =>
                {
                    try
                    {
                        callback?.Invoke(application);
                        program.InitializeApplication();
                        Configuration = program.CreateConfiguration();
                        program.ConfigureServices(serviceCollection);
                        Services = serviceCollection.BuildServiceProvider();
                        
                        return Services.GetService<IProgramService>().Run();
                    }
                    catch (Exception ex)
                    {
                        ILogger<Application> logger = Services?.GetService<ILogger<Application>>();

                        if (logger == null)
                            return program.HandleException(ex);

                        logger.LogCritical(ex, ex.Message);

                        return -1;
                    }
                    finally 
                    {
                        program.FinalizeApplication();
                    }
                });

                return application.Execute(args);
            }
            catch (Exception ex)
            {
                return program.HandleException(ex);
            }
        }
    }
}
