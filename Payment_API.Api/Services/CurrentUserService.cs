using Payment_API.Application.Interface;
using System.Security.Claims;

namespace Payment_API.Api.Services
{
    public class CurrentUserService : ICurrentUserService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public CurrentUserService(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }
        public string? UserId => 
            _httpContextAccessor.HttpContext?.User.FindFirstValue(ClaimTypes.NameIdentifier);

        public string? IpAddress =>
            _httpContextAccessor?.HttpContext?.Connection?.LocalIpAddress?.ToString();
    }
}
