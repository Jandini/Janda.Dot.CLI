using CommandLine;

<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    [Verb("run", isDefault: true, HelpText = "Run application")]
    internal class RunOptions : LoggingOptions, IRunOptions
    {
#if (addArgs)
        [Option('v', "verbose", Required = false, HelpText = "Set output to verbose messages.")]
        public bool Verbose { get; set; }

#endif
    }
}
