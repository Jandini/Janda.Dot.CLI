using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;

namespace Dot.Console
{
    interface IApplicationProgram
    {
        IConfiguration CreateConfiguration();
        void InitializeApplication(ProgramOptions options);
        void FinalizeApplication();
        void ConfigureServices(IServiceCollection serviceCollection);
        void UnhandledException(Exception ex);
    }
}
