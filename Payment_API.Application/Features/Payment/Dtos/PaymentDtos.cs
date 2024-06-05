﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Dtos
{
    public class PaymentDtos
    {
        public string Id { get; set; } = null!;
        public string? PaymentContent { get; set; } = string.Empty;
        public string? PaymentCurrency { get; set; } = string.Empty;
        public string? PaymentRefId { get; set; } = string.Empty;
        public decimal? RequiredAmount { get; set; }
        public DateTime? PaymentDate { get; set; }
        public DateTime? ExprireDate { get; set; }
        public string? PaymentLanguage { get; set; } = string.Empty;
        public string? MerchantId { get; set; } = string.Empty;
        public string? PaymentDestinationId { get; set; } = string.Empty;
        public decimal? PaidAmount { get; set; }
    }
}
