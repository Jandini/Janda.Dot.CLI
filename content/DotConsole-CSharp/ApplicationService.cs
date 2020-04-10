using Microsoft.Extensions.Logging;

namespace Dot.Console
{
    public class ApplicationService : IApplicationService
    {
        private readonly ILogger<ApplicationService> _logger;
        private readonly IApplicationOptions _options;

        public ApplicationService(ILogger<ApplicationService> logger, IApplicationOptions options)
        {
            _logger = logger;
            _options = options;
        }

        public int Run()
        {            
#if (addArgs)
            if (_options.Verbose)
            {
                _logger.LogInformation("Hello World");
            }
#else
            _logger.LogInformation("Hello World");
#endif
            return 0;
        }
    }
}
