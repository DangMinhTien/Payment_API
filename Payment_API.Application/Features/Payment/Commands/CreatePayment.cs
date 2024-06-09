using Mapster;
using MediatR;
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
using Payment_API.Service.VnPay.Request;
using Microsoft.Extensions.Options;
using Payment_API.Service.VnPay.Config;
using Payment_API.Service.Momo.Config;
using Payment_API.Service.Momo.Request;
using Payment_API.Service.ZaloPay.Config;
using Payment_API.Service.ZaloPay.Request;
using Payment_API.Ultils.Extensions;

namespace Payment_API.Application.Features.Commands
{
    public class CreatePayment : IRequest<BaseResultWithData<PaymentLinkDtos>>
    {
        public string? PaymentContent { get; set; } = string.Empty;
        public string? PaymentCurrency { get; set; } = string.Empty;
        public string? PaymentRefId { get; set; } = string.Empty;
        public decimal? RequiredAmount { get; set; }
        public DateTime? PaymentDate { get; set; } = DateTime.Now;
        public DateTime? ExprireDate { get; set; } = DateTime.Now.AddMinutes(15);
        public string? PaymentLanguage { get; set; } = string.Empty;
        public string? Signature { get; set; } = string.Empty;
        public string? MerchantId { get; set; } = string.Empty;
        public string? PaymentDestinationId { get; set; } = string.Empty;
       
    }
    public class CreatePaymentHandler : IRequestHandler<CreatePayment, BaseResultWithData<PaymentLinkDtos>>
    {
        private readonly ICurrentUserService _currentUserService;
        private readonly IConnectionService _connectionService;
        private readonly ISqlService _sqlService;
        private readonly VnPayConfig _vnpayConfig;
        private readonly MomoConfig _momoConfig;
        private readonly ZaloPayConfig _zaloPayConfig;

        public CreatePaymentHandler(ICurrentUserService currentUserService,
            IConnectionService connectionService,
            ISqlService sqlService,
            IOptions<VnPayConfig> vnpayConfig,
            IOptions<MomoConfig> momoConfig,
            IOptions<ZaloPayConfig> zaloPayConfig)
        {
            _currentUserService = currentUserService;
            _connectionService = connectionService;
            _sqlService = sqlService;
            _vnpayConfig = vnpayConfig.Value;
            _momoConfig = momoConfig.Value;
            _zaloPayConfig = zaloPayConfig.Value;
        }
        public Task<BaseResultWithData<PaymentLinkDtos>> Handle(CreatePayment request, CancellationToken cancellationToken)
        {
            var result = new BaseResultWithData<PaymentLinkDtos>();
            try
            {
                string connectionString = _connectionService.Database ?? string.Empty;
                var outputIdParam = _sqlService.CreateOutputParameter("@InsertedId", SqlDbType.NVarChar, 50);
                var parameters = new SqlParameter[]
                {
                    new SqlParameter("@Id", Guid.NewGuid().ToString()),
                    new SqlParameter("@PaymentContent", request.PaymentContent ?? string.Empty),
                    new SqlParameter("@PaymentCurrency", request.PaymentCurrency ?? string.Empty),
                    new SqlParameter("@PaymentRefId", request.PaymentRefId ?? string.Empty),
                    new SqlParameter("@RequiredAmount", request.RequiredAmount ?? 0),
                    new SqlParameter("@PaymentDate", DateTime.Now),
                    new SqlParameter("@PaymentLanguage", request.PaymentLanguage ?? string.Empty),
                    new SqlParameter("@Signature", request.Signature ?? string.Empty),
                    new SqlParameter("@MerchantId", request.MerchantId ?? string.Empty),
                    new SqlParameter("@PaymentDestinationId", request.PaymentDestinationId ?? string.Empty),
                    new SqlParameter("@InsertUser", _currentUserService.UserId ?? string.Empty),
                    outputIdParam
                };
                (int affectedRows, string sqlError) = _sqlService.ExcuteNonQuery(connectionString,
                    PaymentContants.InsertSprocName, parameters);
                if (affectedRows > 1)
                {
                    var paymentUrl = string.Empty;
                    switch (request.PaymentDestinationId)
                    {
                        case "VNPAY":
                            var vnpayPayRequest = new VnPayPayRequest(_vnpayConfig.Version,
                                _vnpayConfig.TmnCode, DateTime.Now, _currentUserService.IpAddress ?? string.Empty, request.RequiredAmount ?? 0, request.PaymentCurrency ?? string.Empty,
                                "other", request.PaymentContent ?? string.Empty, _vnpayConfig.ReturnUrl, outputIdParam!.Value?.ToString() ?? string.Empty);
                            paymentUrl = vnpayPayRequest.GetLink(_vnpayConfig.PaymentUrl, _vnpayConfig.HashSecret);
                            break;
                        case "MOMO":
                            var momoOneTimePayRequest = new MomoOneTimePaymentRequest(_momoConfig.PartnerCode,
                                outputIdParam!.Value?.ToString() ?? string.Empty, (long)request.RequiredAmount!, outputIdParam!.Value?.ToString() ?? string.Empty,
                                request.PaymentContent ?? string.Empty, _momoConfig.ReturnUrl, _momoConfig.IpnUrl, "captureWallet",
                                string.Empty);
                            momoOneTimePayRequest.MakeSignature(_momoConfig.AccessKey, _momoConfig.SecretKey);
                            (bool createMomoLinkResult, string? createMessage) = momoOneTimePayRequest.GetLink(_momoConfig.PaymentUrl);
                            if (createMomoLinkResult)
                            {
                                paymentUrl = createMessage;
                            }
                            else
                            {
                                result.Message = createMessage;
                            }
                            break;
                        case "ZALOPAY":
                            var zalopayPayRequest = new CreateZaloPayPayRequest(_zaloPayConfig.AppId, _zaloPayConfig.AppUser,
                                DateTime.Now.GetTimeStamp(), (long)request.RequiredAmount!, DateTime.Now.ToString("yymmdd") + "_" + outputIdParam!.Value?.ToString() ?? string.Empty,
                                "zalopayapp", request.PaymentContent ?? string.Empty);
                            zalopayPayRequest.MakeSignature(_zaloPayConfig.Key1);
                            (bool createZaloPayLinkResult, string? createZaloPayMessage) = zalopayPayRequest.GetLink(_zaloPayConfig.PaymentUrl);
                            if (createZaloPayLinkResult)
                            {
                                paymentUrl = createZaloPayMessage;
                            }
                            else
                            {
                                result.Message = createZaloPayMessage;
                            }
                            break;
                        default:
                            break;
                    }
                    result.Set(true, MessageContants.Ok, new PaymentLinkDtos
                    {
                        PaymentId = outputIdParam.Value?.ToString() ?? string.Empty,
                        PaymentUrl = paymentUrl,
                    });
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
                result.Errors.Add(new BaseError
                {
                    Code = MessageContants.Exception,
                    Message = ex.Message,
                });
            }
            return Task.FromResult(result);
        }
    }
}
