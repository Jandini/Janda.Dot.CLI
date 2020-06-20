using Microsoft.Extensions.DependencyInjection;

<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Library
<!--#endif -->
{
    public static class ClassServiceExtensions
    {
        public static IServiceCollection AddClassService(this IServiceCollection services)
        {
            return services.AddTransient<IClassService, ClassService>();
        }
    }
}
