using CommandLine;
using Microsoft.Extensions.Logging;

<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    internal class LoggingOptions
    {
        [Option("logdir", Hidden = true, Required = false)]
        public string LogDir { get; set; }

        [Option("loglevel", Hidden = true, Default = LogLevel.Information)]
        public LogLevel LogLevel { get; set; }
    }
}
