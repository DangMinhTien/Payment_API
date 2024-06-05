using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Domain.Entities
{
    public class BaseAuditableEntity
    {
        public string? CreatedBy { get; set; } = string.Empty;
        public DateTime? CreatedAt { get; set; }
        public string? LastUpdatedBy {  get; set; } = string.Empty;
        public DateTime? LastUpdatedAt { get; set; }
    }
}
