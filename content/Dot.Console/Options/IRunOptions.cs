<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    public interface IRunOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
