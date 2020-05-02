using Microsoft.Extensions.Logging;

namespace Dot.Console
{
    public class Service : IApplicationService
    {
        private readonly ILogger<Service> _logger;
        private readonly IApplicationOptions _options;

        public Service(ILogger<Service> logger, IApplicationOptions options)
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
