using Microsoft.Extensions.Logging;

namespace Dot.Console
{
    public class ApplicationService : IApplicationService
    {
        private readonly ILogger<ApplicationService> _logger;
        private readonly IApplicationOptions _options;
        private readonly IApplicationSettings _settings;

        public ApplicationService(ILogger<ApplicationService> logger, IApplicationOptions options, IApplicationSettings settings)
        {
            _logger = logger;
            _options = options;
            _settings = settings;
        }

        public int Run()
        {
#if (addArgs)
            if (_options.Verbose)
            {
		_logger.LogInformation("Running {0} {1} {2}", Application.Name, Application.Version, _settings.Description);
            }
#else
            _logger.LogInformation("Running {0} {1} {2}", Application.Name, Application.Version, _settings.Description);
#endif
            return 0;
        }
    }
}
