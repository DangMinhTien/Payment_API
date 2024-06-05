using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Domain.Entities
{
    public class PaymentTransaction
    {
        public string Id { get; set; } = null!;
        public string? TranMessage { get; set; } = string.Empty;
        public string? TranPayLoad { get; set; } = string.Empty;
        public string? TranStatus { get; set; } = string.Empty;
        public decimal? TranAmount { get; set; }
        public DateTime? DateTime { get; set; }
        public string? PaymentId { get; set; } = string.Empty;
        public string? TranRefId { get; set; } = string.Empty;
    }
}
