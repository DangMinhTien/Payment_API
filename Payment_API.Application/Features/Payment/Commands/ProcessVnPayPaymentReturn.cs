using MediatR;
using Microsoft.Extensions.Options;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Constants;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Interface;
using Payment_API.Service.VnPay.Config;
using Payment_API.Service.VnPay.Response;
using Payment_API.Ultils.Extensions;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Commands
{
    public class ProcessVnPayPaymentReturn : VnPayPayResponse,
        IRequest<BaseResultWithData<(PaymentReturnDtos, string)>>
    {

    }
    public class ProcessVnPayPaymentReturnHandler :
        IRequestHandler<ProcessVnPayPaymentReturn, BaseResultWithData<(PaymentReturnDtos, string)>>
    {
        private readonly IConnectionService _connectionService;
        private readonly ICurrentUserService _currentUserService;
        private readonly ISqlService _sqlService;
        private readonly VnPayConfig _vnPayConfig;

        public ProcessVnPayPaymentReturnHandler(IConnectionService connectionService,
            ICurrentUserService currentUserService,
            ISqlService sqlService,
            IOptions<VnPayConfig> vnPayConfig)
        {
            _connectionService = connectionService;
            _currentUserService = currentUserService;
            _sqlService = sqlService;
            _vnPayConfig = vnPayConfig.Value;
        }
        public Task<BaseResultWithData<(PaymentReturnDtos, string)>> Handle(ProcessVnPayPaymentReturn request, 
            CancellationToken cancellationToken)
        {
            var returnUrl = string.Empty;
            var result = new BaseResultWithData<(PaymentReturnDtos, string)>();
            try
            {
                var resultData = new PaymentReturnDtos();
                var isValidSignature = request.IsValidSignature(_vnPayConfig.HashSecret);
                if (isValidSignature)
                {
                    if(request.vnp_ResponseCode == "00")
                    {
                        string connectionString = _connectionService.Database ?? string.Empty;
                        var parameters = new SqlParameter[]
                        {
                            new SqlParameter("@PaymentId", request.vnp_TxnRef),
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

                            resultData.PaymentStatus = "00";
                            resultData.PaymentId = payment.Id;
                            resultData.Signature = Guid.NewGuid().ToString();
                        }
                        else
                        {
                            resultData.PaymentStatus = "11";
                            resultData.PaymentMessage = "Can't find payment";
                        }
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
                    resultData.PaymentStatus = "99";
                    resultData.PaymentMessage = "Invalid signature in response";
                }
                result.Success = true;
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
