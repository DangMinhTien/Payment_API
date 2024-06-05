using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Domain.Entities
{
    public class PaymentDestination : BaseAuditableEntity
    {
        public string Id { get; set; } = null!;
        public string? DesName { get; set; } = string.Empty;
        public string? DesShortName { get; set; } = string.Empty;
        public string? ParentId { get; set; } = string.Empty;
        public string? DesLogo {  get; set; } = string.Empty;
        public int? DesSortIndex { get; set; }
        public bool? IsActive { get; set; }
    }
}
