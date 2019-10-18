using Microsoft.Extensions.Logging;

namespace Dot.Library
{
    public class ClassService : IClassService
    {
        private readonly ILogger<ClassService> _logger;

        public ClassService(ILogger<ClassService> logger)
        {
            _logger = logger;
        }

        public void DoSomething()
        {
            _logger.LogInformation("Do somehting");
        }
    }
}
