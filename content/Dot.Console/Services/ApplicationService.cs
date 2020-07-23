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
            switch (_options.CurrentOptions)
            {
                case IRunOptions runOptions:
                    if (runOptions.Verbose)                        
                        _logger.LogInformation("Running {Name} {Version} {Description}", Application.Name, Application.Version, _settings.Description ?? string.Empty);
                    return 0;
            }
#else
            switch (_options.CurrentOptions)
            {
                case IRunOptions _:                        
                    _logger.LogInformation("Running {Name} {Version} {Description}", Application.Name, Application.Version, _settings.Description ?? string.Empty);
                    return 0;
            }
#endif
            return 1;
        }
    }
}
