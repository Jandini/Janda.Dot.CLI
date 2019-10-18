using Microsoft.Extensions.DependencyInjection;

namespace Dot.Library
{
    public static class ClassServiceExtensions
    {
        public static IServiceCollection AddClassService(this IServiceCollection services)
        {
            return services.AddTransient<IClassService, ClassService>();
        }
    }
}
