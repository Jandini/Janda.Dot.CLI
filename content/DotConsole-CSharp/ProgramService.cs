using Microsoft.Extensions.Logging;

namespace Dot.Console
{
    public class ProgramService : IProgramService
    {
        private readonly ILogger<ProgramService> _logger;
        private readonly IProgramOptions _options;

        public ProgramService(ILogger<ProgramService> logger, IProgramOptions options)
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
