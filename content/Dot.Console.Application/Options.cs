using CommandLine;
using Microsoft.Extensions.Logging;

namespace Dot.Console
{
    internal class Options : IApplicationOptions
    {
#if (addArgs)
        [Option('v', "verbose", Required = false, HelpText = "Set output to verbose messages.")]
        public bool Verbose { get; set; }

#endif
        [Option("logdir", Hidden = true, Required = false)]
        public string LogDir { get; set; }

        [Option("loglevel", Hidden = true, Default = LogLevel.Information)]
        public LogLevel LogLevel { get; set; }
    }
}
