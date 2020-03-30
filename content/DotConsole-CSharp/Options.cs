using CommandLine;

namespace Dot.Console
{
    internal class Options : IApplicationOptions
    {
#if (addArgs)
        [Option('v', "verbose", Required = false, HelpText = "Set output to verbose messages.")]
        public bool Verbose { get; set; }

#endif
        [Option("logdir", Required = false, HelpText = "Set log directory and enable log to files")]
        public string LogDir { get; set; }
    }
}
