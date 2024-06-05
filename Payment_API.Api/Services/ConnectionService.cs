using Microsoft.Extensions.Configuration;
using Payment_API.Application.Interface;

namespace Payment_API.Api.Services
{
    public class ConnectionService : IConnectionService
    {
        private readonly IConfiguration _configuration;

        public ConnectionService(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        public string? Database => 
            _configuration.GetConnectionString("Payment_API");
    }
}
