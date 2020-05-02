using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
#if (addConfig)
using Microsoft.Extensions.Configuration;
#endif

namespace Dot.Console
{
    public interface IApplicationProgram
    {
#if (addConfig)
        IConfiguration CreateConfiguration();
#endif        
        void ConfigureLogging(ILoggingBuilder loggingBuilder);
        void ConfigureServices(IServiceCollection serviceCollection);
    }
}
