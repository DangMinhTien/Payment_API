using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Commands
{
    public class SetActiceMerchant
    {
        public string Id { get; set; } = null!;
        public bool IsActive { get; set; }
    }
}
