<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    public interface IApplicationOptions
    {
        IRuntimeOptions RuntimeOptions { get; set; }
    }
}
