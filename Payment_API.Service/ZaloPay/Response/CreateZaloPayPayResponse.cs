using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Service.ZaloPay.Response
{
    public class CreateZaloPayPayResponse
    {
        public int returnCode { get; set; }
        public string returnMessage { get; set; } = string.Empty;
        public string orderUrl { get; set; } = string.Empty;
    }
}
