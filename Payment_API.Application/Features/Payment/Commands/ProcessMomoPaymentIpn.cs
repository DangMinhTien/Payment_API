using MediatR;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Constants;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Interface;
using Payment_API.Service.Momo.Config;
using Payment_API.Service.Momo.Request;
using Payment_API.Ultils.Extensions;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Payment.Commands
{
    public class ProcessMomoPaymentIpn : MomoOneTimePaymentResultRequest,
        IRequest<BaseResult>
    {

    }
    public class ProcessMomoPaymentIpnHandler :
        IRequestHandler<ProcessMomoPaymentIpn, BaseResult>
    {
        private readonly IConnectionService _connectionService;
        private readonly ISqlService _sqlService;
        private readonly MomoConfig _momoConfig;
        private readonly ICurrentUserService _currentUserService;

        public ProcessMomoPaymentIpnHandler(IConnectionService connectionService,
            ISqlService sqlService,
            IOptions<MomoConfig> momoConfig,
            ICurrentUserService currentUserService)
        {
            _connectionService = connectionService;
            _sqlService = sqlService;
            _momoConfig = momoConfig.Value;
            _currentUserService = currentUserService;
        }
        public Task<BaseResult> Handle(ProcessMomoPaymentIpn request, CancellationToken cancellationToken)
        {
            var result = new BaseResult();

            try
            {
                var isValidSignature = request.IsValidSignature(_momoConfig.AccessKey, _momoConfig.SecretKey);

                if (isValidSignature)
                {
                    /// Get payment request
                    string connectionString = _connectionService.Database ?? string.Empty;
                    var paramters = new SqlParameter[]
                    {
                        new SqlParameter("@PaymentId", request.orderId),
                    };
                    (var data, string sqlError) = _sqlService.FillDataTable(connectionString,
                        PaymentContants.SelectByIdSprocName, paramters);
                    var payment = data.AsListObject<PaymentDtos>()?.SingleOrDefault();

                    if (payment != null)
                    {
                        if (payment.RequiredAmount == request.amount)
                        {
                            if (payment.PaymentStatus != "0")
                            {
                                string message = "";
                                string status = "";

                                if (request.resultCode == 0)
                                {
                                    status = "0";
                                    message = "Tran success";
                                }
                                else
                                {
                                    status = "-1";
                                    message = "Tran error";
                                }

                                /// Update database
                                paramters = new SqlParameter[]
                                {
                                    new SqlParameter("@Id", DateTime.Now.Ticks.ToString()),
                                    new SqlParameter("@TranMessage", message),
                                    new SqlParameter("@TranPayload", JsonConvert.SerializeObject(request)),
                                    new SqlParameter("@TranStatus", status),
                                    new SqlParameter("@TranAmount", request.amount),
                                    new SqlParameter("@TranDate", DateTime.Now),
                                    new SqlParameter("@PaymentId", request.orderId),
                                    new SqlParameter("@InsertUser", _currentUserService.UserId ?? string.Empty),
                                };
                                (var affectedRows, sqlError) = _sqlService.ExcuteNonQuery(connectionString,
                                    PaymentTransactionContants.InsertSprocName, paramters);

                                /// Confirm success
                                if (affectedRows >= 1)
                                {
                                    result.Set(true, "Confirm success");
                                }
                                else
                                {
                                    result.Set(false, "Input required data");
                                }
                            }
                            else
                            {
                                result.Set(false, "Payment already confirmed");
                            }
                        }
                        else
                        {
                            result.Set(false, "Invalid amount");
                        }
                    }
                    else
                    {
                        result.Set(false, "Payment not found");
                    }
                }
                else
                {
                    result.Set(false, "Invalid signature");
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

            return Task.FromResult(result);
        }
    }
}
