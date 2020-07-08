<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    public interface IApplicationOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
