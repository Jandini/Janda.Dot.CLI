<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    internal class ApplicationOptions : IApplicationOptions
    {
        public IRunOptions RunOptions { get; set; }
    }
}
