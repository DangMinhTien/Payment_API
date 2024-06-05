using MediatR;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Constants;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Interface;
using Payment_API.Ultils.Extensions;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Queries
{
    public class GetPayment : IRequest<BaseResultWithData<PaymentDtos>>
    {
        public string Id { get; set; } = string.Empty;

    }
    public class GetPaymentHandler : IRequestHandler<GetPayment, BaseResultWithData<PaymentDtos>>
    {
        private readonly ICurrentUserService _currentUserService;
        private readonly ISqlService _sqlService;
        private readonly IConnectionService _connectionService;

        public GetPaymentHandler(ICurrentUserService currentUserService,
            ISqlService sqlService,
            IConnectionService connectionService)
        {
            _currentUserService = currentUserService;
            _sqlService = sqlService;
            _connectionService = connectionService;
        }
        public Task<BaseResultWithData<PaymentDtos>> Handle(GetPayment request, 
            CancellationToken cancellationToken)
        {
            var result = new BaseResultWithData<PaymentDtos>();
            try
            {
                string connectionString = _connectionService.Database ?? string.Empty;
                var parameters = new SqlParameter[]
                {
                    new SqlParameter("@Id", request.Id),
                };
                (var data, string sqlError) = _sqlService.FillDataTable(connectionString,
                    PaymentContants.SelectByIdSprocName, parameters);
                var payment = data.AsListObject<PaymentDtos>()?.SingleOrDefault();
                if(payment != null)
                {
                    result.Set(true, MessageContants.Ok, payment);
                }
                else
                {
                    result.Set(false, MessageContants.NotFound);
                }
            }
            catch(Exception ex)
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
