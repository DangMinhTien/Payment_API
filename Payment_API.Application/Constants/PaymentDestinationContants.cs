using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Constants
{
    public class PaymentDestinationContants
    {
        public static string SelectWithCriteriaSprocName => "sproc_PaymentDestinationSelectByCriteria";
        public static string InsertSprocName => "sproc_PaymentDestinationInsert";
    }
}
