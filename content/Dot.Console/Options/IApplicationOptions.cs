<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    public interface IApplicationOptions
    {
        object CurrentOptions { get; set; }
        T Cast<T>();
    }
}
