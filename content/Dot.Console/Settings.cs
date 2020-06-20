    
<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Console
<!--#endif -->
{
    public class Settings : IApplicationSettings
    {
        public string Description { get; set; }
    }
}
