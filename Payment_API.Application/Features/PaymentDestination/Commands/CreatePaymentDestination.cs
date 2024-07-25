using Mapster;
using MediatR;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Constants;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Features.PaymentDestination.Dtos;
using Payment_API.Application.Interface;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Commands
{
    public class CreatePaymentDestination : IRequest<BaseResultWithData<PaymentDestinationDtos>>
    {
        public string? Id { get; set; } = string.Empty;
        public string? DesLogo { get; set; } = string.Empty;
        public string? DesShortName { get; set; } = string.Empty;
        public string? DesName { get; set; } = string.Empty;
        public bool? IsActive { get; set; } = false;
        public string? InsertUser { get; set; } = string.Empty;
    }
    public class CreatePaymentDestinationHandler : IRequestHandler<CreatePaymentDestination, BaseResultWithData<PaymentDestinationDtos>>
    {
        private readonly ICurrentUserService _currentUserService;
        private readonly ISqlService _sqlService;
        private readonly IConnectionService _connectionService;

        public CreatePaymentDestinationHandler(ICurrentUserService currentUserService,
            ISqlService sqlService,
            IConnectionService connectionService)
        {
            _currentUserService = currentUserService;
            _sqlService = sqlService;
            _connectionService = connectionService;
        }
        public Task<BaseResultWithData<PaymentDestinationDtos>> Handle(
            CreatePaymentDestination request, CancellationToken cancellationToken)
        {
            var result = new BaseResultWithData<PaymentDestinationDtos>();
            try
            {
                string connectionString = _connectionService.Database ?? string.Empty;
                var outputIdParam = _sqlService.CreateOutputParameter("@InsertedId", SqlDbType.NVarChar, 50);
                var parameters = new SqlParameter[]
                {
                    new SqlParameter("@Id", request.Id ?? string.Empty),
                    new SqlParameter("@DesLogo", request.DesLogo ?? string.Empty),
                    new SqlParameter("@DesShortName", request.DesShortName ?? string.Empty),
                    new SqlParameter("@DesName", request.DesName ?? string.Empty),
                    new SqlParameter("@IsActive", request.IsActive ?? false),
                    new SqlParameter("@InsertUser", _currentUserService.UserId ?? string.Empty),
                    outputIdParam
                };
                (int affectedRows, string sqlError) = _sqlService.ExcuteNonQuery(connectionString,
                    PaymentDestinationContants.InsertSprocName, parameters);
                if (affectedRows == 1)
                {
                    var resultData = request.Adapt<PaymentDestinationDtos>();
                    resultData.Id = outputIdParam.Value?.ToString() ?? string.Empty;
                    result.Set(true, MessageContants.Ok, resultData);
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
            return Task.FromResult(result);
        }
    }
}
