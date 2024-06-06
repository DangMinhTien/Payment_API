using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Dtos
{
    public class PaymentReturnDtos
    {
        public string? PaymentId { get; set; }
        /// <summary>
        /// 00: success
        /// 99: unknown
        /// 10: error
        /// </summary>
        public string? PaymentStatus { get; set; }
        public string? PaymentMessage { get; set; }
        /// <summary>
        /// Format: yyyyMMddHHmmss
        /// </summary>
        public string? PaymentDate { get; set; }
        public string? PaymentRefId { get; set; }
        public decimal? Amount { get; set; }
        public string? Signature { get; set; }
    }
}
