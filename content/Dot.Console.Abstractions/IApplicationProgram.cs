using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;

namespace _NameSpace_
{
    public interface IApplicationProgram
    {
        IConfiguration CreateConfiguration();
        void ConfigureLogging(ILoggingBuilder loggingBuilder);
        void ConfigureServices(IServiceCollection serviceCollection);
    }
}
