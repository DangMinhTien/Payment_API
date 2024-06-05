using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Domain.Entities
{
    public class PaymentNotification
    {
        public string Id { get; set; } = null!;
        public string? PaymentRefId { get; set; } = string.Empty;
        public DateTime? NotiDate { get; set; }
        public string? NotiContent { get; set; } = string.Empty;
        public decimal? NotiAmount { get; set; }
        public string? NotiMessage { get; set; } = string.Empty;
        public string? NotiSignature { get; set; } = string.Empty;
        public string? PaymentId {  get; set; } = string.Empty;
        public string? MerchantId { get; set; } = string.Empty;
        public string? NotiNotiStatus { get; set; } = string.Empty;
        public DateTime? NotiResDate { get; set; }
        public string? NotiResMessage {  get; set; } = string.Empty;
        public string? NotiResHttpCode { get; set; } = string.Empty;
    }
}
