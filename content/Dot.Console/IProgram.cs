using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;

<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    public interface IProgram
    {
        IConfiguration CreateConfiguration();
        void ConfigureLogging(ILoggingBuilder loggingBuilder);
        void ConfigureServices(IServiceCollection serviceCollection);
    }
}
