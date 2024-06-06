using MediatR;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
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
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Commands
{
    public class ProcessVnPayPaymentIpn : VnPayPayResponse,
        IRequest<BaseResultWithData<VnPayPayIpnResponse>>
    {
    }
    public class ProcessVnPayPaymentIpnHandler :
        IRequestHandler<ProcessVnPayPaymentIpn, BaseResultWithData<VnPayPayIpnResponse>>
    {
        private readonly IConnectionService _connectionService;
        private readonly ISqlService _sqlService;
        private readonly VnPayConfig _vnPayConfig;
        private readonly ICurrentUserService _currentUserService;

        public ProcessVnPayPaymentIpnHandler(IConnectionService connectionService,
            ISqlService sqlService,
            IOptions<VnPayConfig> vnPayConfig,
            ICurrentUserService currentUserService)
        {
            _connectionService = connectionService;
            _sqlService = sqlService;
            _vnPayConfig = vnPayConfig.Value;
            _currentUserService = currentUserService;
        }
        public Task<BaseResultWithData<VnPayPayIpnResponse>> Handle(ProcessVnPayPaymentIpn request, 
            CancellationToken cancellationToken)
        {
            var result = new BaseResultWithData<VnPayPayIpnResponse>();
            var resultData = new VnPayPayIpnResponse();
            try
            {
                var isValidSignature = request.IsValidSignature(_vnPayConfig.HashSecret);
                if(isValidSignature)
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
                        if(payment.RequiredAmount == (request.vnp_Amount / 100))
                        {
                            if(payment.PaymentStatus == "0")
                            {
                                string message = "";
                                string status = "";

                                if (request.vnp_ResponseCode == "00" &&
                                   request.vnp_TransactionStatus == "00")
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
                                parameters = new SqlParameter[]
                                {
                                    new SqlParameter("@Id", DateTime.Now.Ticks.ToString()),
                                    new SqlParameter("@TranMessage", message),
                                    new SqlParameter("@TranPayload", JsonConvert.SerializeObject(request)),
                                    new SqlParameter("@TranStatus", status),
                                    new SqlParameter("@TranAmount", request.vnp_Amount),
                                    new SqlParameter("@TranDate", DateTime.Now),
                                    new SqlParameter("@PaymentId", request.vnp_TxnRef),
                                    new SqlParameter("@InsertUser", _currentUserService.UserId ?? string.Empty),
                                };
                                (var affectedRows, sqlError) = _sqlService.ExcuteNonQuery(connectionString,
                                    PaymentTransactionContants.InsertSprocName, parameters);


                                /// Confirm success
                                if(affectedRows >= 1)
                                {
                                    resultData.Set("00", "Confirm success");
                                }
                                else
                                {
                                    resultData.Set("99", "Input required Data");
                                }
                            }
                            else
                            {
                                resultData.Set("02", "Order already confirmed");
                            }
                        }
                        else
                        {
                            resultData.Set("04", "Invalid amount");
                        }
                    }
                    else
                    {
                        resultData.Set("01", "Order not found");
                    }
                }
                else
                {
                    resultData.Set("97", "Invalid Signature");
                }
            }
            catch (Exception ex)
            {
                resultData.Set("99", "Input required Data");
            }
            result.Data = resultData;
            return Task.FromResult(result);
        }
    }
}
