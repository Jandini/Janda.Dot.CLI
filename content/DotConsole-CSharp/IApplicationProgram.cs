#if (addConfig)
using Microsoft.Extensions.Configuration;
#endif
using Microsoft.Extensions.DependencyInjection;
using System;

namespace Dot.Console
{
    public interface IApplicationProgram
    {
#if (addConfig)
        IConfiguration CreateConfiguration();
#endif
        void InitializeApplication();
        void FinalizeApplication();
        void ConfigureServices(IServiceCollection serviceCollection);
        int UnhandledException(Exception ex);
    }
}
