<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Console
<!--#endif -->
{
    public interface IApplicationSettings
    {
        string Description { get; }
    }
}
