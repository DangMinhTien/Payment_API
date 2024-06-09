using MediatR;
using Microsoft.Extensions.Options;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Constants;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Interface;
using Payment_API.Service.Momo.Config;
using Payment_API.Service.Momo.Request;
using Payment_API.Service.VnPay.Response;
using Payment_API.Ultils.Extensions;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Payment.Commands
{
    public class ProcessMomoPaymentReturn : MomoOneTimePaymentResultRequest,
        IRequest<BaseResultWithData<(PaymentReturnDtos, string)>>
    {
    }
    public class ProcessMomoPaymentReturnHandler :
        IRequestHandler<ProcessMomoPaymentReturn, BaseResultWithData<(PaymentReturnDtos, string)>>
    {
        private readonly IConnectionService _connectionService;
        private readonly ISqlService _sqlService;
        private readonly MomoConfig _momoConfig;

        public ProcessMomoPaymentReturnHandler(IConnectionService connectionService,
            ISqlService sqlService,
            IOptions<MomoConfig> momoConfig)
        {
            _connectionService = connectionService;
            _sqlService = sqlService;
            _momoConfig = momoConfig.Value;
        }
        public Task<BaseResultWithData<(PaymentReturnDtos, string)>> Handle(ProcessMomoPaymentReturn request, CancellationToken cancellationToken)
        {
            string returnUrl = string.Empty;
            var result = new BaseResultWithData<(PaymentReturnDtos, string)>();
            try
            {
                var resultData = new PaymentReturnDtos();
                var isValidSignature = request.IsValidSignature(_momoConfig.AccessKey, 
                    _momoConfig.SecretKey);
                if(isValidSignature)
                {
                    string connectionString = _connectionService.Database ?? string.Empty;
                    var parameters = new SqlParameter[]
                    {
                            new SqlParameter("@PaymentId", request.orderId),
                    };
                    (var data, string sqlError) = _sqlService.FillDataTable(connectionString,
                        PaymentContants.SelectByIdSprocName, parameters);
                    var payment = data.AsListObject<PaymentDtos>()?.SingleOrDefault();
                    if(payment != null)
                    {
                        parameters = new SqlParameter[]
                        {
                            new SqlParameter("@Id", payment.MerchantId),
                        };
                        (data, sqlError) = _sqlService.FillDataTable(connectionString,
                            MerchantContants.SelectByIdSprocName, parameters);
                        var merchant = data.AsListObject<MerchantDtos>()?.SingleOrDefault();
                        returnUrl = merchant?.MerchantReturnUrl ?? string.Empty;
                        if (request.resultCode == 0)
                        {
                            resultData.PaymentStatus = "00";
                            resultData.PaymentId = payment.Id;
                            ///TODO: Make signature
                            resultData.Signature = Guid.NewGuid().ToString();
                        }
                        else
                        {
                            resultData.PaymentStatus = "10";
                            resultData.PaymentMessage = "Payment process failed";
                        }

                        result.Success = true;
                        result.Message = MessageContants.Ok;
                        result.Data = (resultData, returnUrl);
                    }
                    else
                    {
                        resultData.PaymentStatus = "11";
                        resultData.PaymentMessage = "Can't find payment at payment service";
                    }
                }
                else
                {
                    resultData.PaymentStatus = "99";
                    resultData.PaymentMessage = "Invalid signature in response";
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
