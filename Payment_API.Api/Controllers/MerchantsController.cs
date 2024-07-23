using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Features.Commands;
using System.Net;
using MediatR;
using Payment_API.Application.Features.Merchant.Commands;
using Payment_API.Application.Interface;
using Payment_API.Api.Services;
using Payment_API.Persistence.Persist;

namespace Payment_API.Api.Controllers
{
    /// <summary>
    ///  Api for CRUD Merchant
    /// </summary>
    
    [Route("api/merchants")]
    [ApiController]
    public class MerchantsController : ControllerBase
    {
        private readonly IMediator _mediator;
        private readonly IConnectionService _connectionService;
        private readonly ISqlService _sqlService;

        public MerchantsController(IMediator mediator, 
            IConnectionService connectionService, 
            ISqlService sqlService)
        {
            _mediator = mediator;
            _connectionService = connectionService;
            _sqlService = sqlService;
        }
        /// <summary>
        /// Get merchant base on creteria
        /// </summary>
        /// <param name="criteria"></param>
        /// <returns></returns>
        [HttpGet]
        [ProducesResponseType(typeof(BaseResultWithData<List<MerchantDtos>>), 200)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> Get(string? criteria = "")
        {
            try
            {
                var getMerchant = new GetMerchant();
                var response = getMerchant.Handle(criteria ?? "", _connectionService, _sqlService);
                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        /// <summary>
        ///  Get Merchants paging
        /// </summary>
        /// <param name="pagingQuery"></param>
        /// <returns></returns>
        [HttpGet("/with-paging")]
        [ProducesResponseType(typeof(BaseResultWithData<BasePagingData<MerchantDtos>>), 200)]
        public IActionResult GetPaging([FromQuery]BasePagingQuery pagingQuery)
        {
            var response = new BaseResultWithData<BasePagingData<MerchantDtos>>();
            return Ok(response);
        }
        /// <summary>
        /// Get one merchant by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(BaseResultWithData<MerchantDtos>), 200)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public IActionResult GetOne([FromRoute]string id)
        {
            var response = new BaseResultWithData<MerchantDtos>();
            return Ok(response);
        }
        /// <summary>
        /// Create merchant
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        /// <remarks>
        /// 
        ///     POST
        ///     {
        ///         "MerchantName" : "Website bán hàng",
        ///         "MerchantWebLink" : "https://webbanhang.com",
        ///         "MerchantIpnUrl" : "https://webbanhang/ipn.com",
        ///         "MerchantReturnUrl" : "https://webbanhang.com/payment/return"
        ///     }
        /// 
        /// </remarks>
        [HttpPost]
        [ProducesResponseType(typeof(BaseResultWithData<MerchantDtos>), (int)HttpStatusCode.Created)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> Create([FromBody] CreateMerchant request)
        {
            var response = new BaseResultWithData<MerchantDtos>();
            response = await _mediator.Send(request);
            return Ok(response);
        }
        /// <summary>
        /// Update Merchan by id
        /// </summary>
        /// <param name="request"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPut("{id}")]
        [ProducesResponseType(typeof(BaseResult), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public IActionResult Update([FromBody]UpdateMerchant request, [FromRoute]string id)
        {
            var response = new BaseResult();
            return Ok(response);
        }
        /// <summary>
        /// Set Active Merchant by id
        /// </summary>
        /// <param name="request"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPut("set-active/{id}")]
        [ProducesResponseType(typeof(BaseResult), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public IActionResult SetActive([FromBody] SetActiceMerchant request, [FromRoute] string id)
        {
            var response = new BaseResult();
            return Ok(response);
        }
        /// <summary>
        /// Delete merchant by Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete("{id}")]
        [ProducesResponseType(typeof(BaseResult), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public IActionResult Delete([FromRoute]string id)
        {
            var response = new BaseResult();
            return Ok(response);
        }
    }
}
