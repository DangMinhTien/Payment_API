using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Domain.Entities
{
    public class Merchant : BaseAuditableEntity
    {
        public string Id { get; set; } = null!;
        public string? MerchantName { get; set; } = string.Empty;
        public string? MerchantWebLink { get; set;} = string.Empty;
        public string? MerchantIpnUrl { get; set;} = string.Empty;
        public string? MerchantReturnUrl { get; set; } = string.Empty;
        public string? SecretKey { get; set; } = string.Empty;
        public bool? IsActive { get; set; }
    }
}
