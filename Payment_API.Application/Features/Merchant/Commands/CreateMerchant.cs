using Mapster;
using MediatR;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Constants;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Interface;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Features.Commands
{
    public class CreateMerchant : IRequest<BaseResultWithData<MerchantDtos>>
    {
        public string? MerchantName { get; set; } = string.Empty;
        public string? MerchantWebLink { get; set; } = string.Empty;
        public string? MerchantIpnUrl { get; set; } = string.Empty;
        public string? MerchantReturnUrl { get; set; } = string.Empty;

    }
    public class CreateMerchantHandler : IRequestHandler<CreateMerchant, BaseResultWithData<MerchantDtos>>
    {
        private readonly ICurrentUserService _currentUserService;
        private readonly ISqlService _sqlService;
        private readonly IConnectionService _connectionService;

        public CreateMerchantHandler(ICurrentUserService currentUserService,
            ISqlService sqlService,
            IConnectionService connectionService)
        {
            _currentUserService = currentUserService;
            _sqlService = sqlService;
            _connectionService = connectionService;
        }
        public Task<BaseResultWithData<MerchantDtos>> Handle(
            CreateMerchant request, CancellationToken cancellationToken)
        {
            var result = new BaseResultWithData<MerchantDtos>();
            try
            {
                string connectionString = _connectionService.Database ?? string.Empty;
                var outputIdParam = _sqlService.CreateOutputParameter("@InsertedId", SqlDbType.NVarChar, 50);
                var parameters = new SqlParameter[] 
                { 
                    new SqlParameter("@MerchantName", request.MerchantName ?? string.Empty),
                    new SqlParameter("@MerchantWebLink", request.MerchantWebLink ?? string.Empty),
                    new SqlParameter("@MerchantIpnUrl", request.MerchantIpnUrl ?? string.Empty),
                    new SqlParameter("@MerchantReturnUrl", request.MerchantReturnUrl ?? string.Empty),
                    new SqlParameter("@InsertUser", _currentUserService.UserId ?? string.Empty),
                    outputIdParam
                };
                (int affectedRows, string sqlError) = _sqlService.ExcuteNonQuery(connectionString,
                    MerchantContants.InsertSprocName, parameters);
                if(affectedRows == 1)
                {
                    var resultData = request.Adapt<MerchantDtos>();
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
