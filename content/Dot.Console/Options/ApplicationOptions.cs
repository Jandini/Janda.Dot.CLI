<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    internal class ApplicationOptions : IApplicationOptions
    {
        public object CurrentOptions { get; set; }
        public T Cast<T>()
        {
            return (T)CurrentOptions;
        }
    }
}
