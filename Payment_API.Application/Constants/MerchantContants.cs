using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Constants
{
    public class MerchantContants
    {
        public static string InsertSprocName => "sproc_MerchantInsert";
        public static string UpdateSprocName => "sproc_merchantUpdate";
        public static string UpdateActiveSprocName => "sproc_merchantUpdateActive";
        public static string DeleteSprocName => "sproc_merchantDelete";
        public static string SelectWithCriteriaSprocName => "sproc_MerchantSelectByCriteria";
        public static string SelectByIdSprocName => "sproc_MerchantSelectById";
        public static string SelectPagingSprocName => "sproc_MerchantSelectByCriteriaPaging";
    }
}
