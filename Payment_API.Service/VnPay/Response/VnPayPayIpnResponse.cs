using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Service.VnPay.Response
{
    public class VnPayPayIpnResponse
    {
        public VnPayPayIpnResponse()
        {
            
        }
        public VnPayPayIpnResponse(string rspCode, string message)
        {
            RspCode = rspCode;
            Message = message;
        }
        public void Set(string rspCode, string message)
        {
            RspCode = rspCode;
            Message = message;
        }
        public string RspCode { get; set; } = string.Empty;
        public string Message { get; set; } = string.Empty;
    }
}
