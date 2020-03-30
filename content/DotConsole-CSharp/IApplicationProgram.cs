#if (addConfig)
using Microsoft.Extensions.Configuration;
#endif
using Microsoft.Extensions.DependencyInjection;
using System;

namespace Dot.Console
{
    interface IApplicationProgram
    {
#if (addConfig)
        IConfiguration CreateConfiguration();
#endif
        void InitializeApplication(ProgramOptions options);
        void FinalizeApplication();
        void ConfigureServices(IServiceCollection serviceCollection);
        void UnhandledException(Exception ex);
    }
}
