using Microsoft.Extensions.Logging;

namespace Dot.Console
{

    public class ProgramService : IProgramService
    {
        private readonly ILogger<ProgramService> _logger;

        public ProgramService(ILogger<ProgramService> logger)
        {
            _logger = logger;
        }

        public int Run()
        {            
            _logger.LogInformation("Hello World");
            return 0;
        }
    }
}
