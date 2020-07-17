    
<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
{
    public class Settings : IApplicationSettings
    {
        public string Description { get; set; }
    }
}
