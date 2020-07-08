using Microsoft.Extensions.Logging;

<!--#if (nameSpace != "")-->
namespace Dot.Namespace
<!--#else -->
namespace Dot.Appname
<!--#endif -->
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
		_logger.LogInformation("Running {Name} {Version} {Description}", Application.Name, Application.Version, _settings.Description ?? string.Empty);
            }
#else
            _logger.LogInformation("Running {Name} {Version} {Description}", Application.Name, Application.Version, _settings.Description ?? string.Empty);
#endif
            return 0;
        }
    }
}
