<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Console
<!--#endif -->
{
    public interface IApplicationOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
