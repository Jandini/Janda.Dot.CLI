    
<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    public class ApplicationSettings : IApplicationSettings
    {
        public string Description { get; set; }
    }
}
