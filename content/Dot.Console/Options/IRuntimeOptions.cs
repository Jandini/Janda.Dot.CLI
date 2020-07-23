<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    public interface IRuntimeOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
