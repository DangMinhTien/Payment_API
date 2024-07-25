using Payment_API.Application.Base.Models;
using Payment_API.Application.Constants;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Interface;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Payment_API.Application.Features.PaymentDestination.Dtos;
using Payment_API.Ultils.Extensions;

namespace Payment_API.Application.Features.Queries
{
    public class GetPaymentDestinations
    {
        public async Task<BaseResultWithData<List<PaymentDestinationDtos>>> Handle(string criteria,
            IConnectionService _connectionService, ISqlService _sqlService)
        {
            var result = new BaseResultWithData<List<PaymentDestinationDtos>>();
            try
            {
                string connectionString = _connectionService.Database ?? string.Empty;
                var criteriaParam = new SqlParameter("@Criteria", criteria);
                var parameters = new SqlParameter[]
                {
                    criteriaParam
                };
                (DataTable dataTable, string sqlError) = _sqlService.FillDataTable(connectionString,
                    PaymentDestinationContants.SelectWithCriteriaSprocName, parameters);
                if (dataTable.Rows.Count > 0)
                {
                    var resultData = dataTable.AsListObject<PaymentDestinationDtos>();
                    result.Set(true, MessageContants.Ok, resultData ?? new List<PaymentDestinationDtos>());
                }
                else
                {
                    result.Set(false, MessageContants.Error);
                    result.Errors.Add(new BaseError()
                    {
                        Code = "Sql",
                        Message = sqlError
                    });
                }
            }
            catch (Exception ex)
            {
                result.Set(false, MessageContants.Error);
                result.Errors.Add(new BaseError()
                {
                    Code = MessageContants.Exception,
                    Message = ex.Message,
                });
            }
            return result;
        }
    }
}
