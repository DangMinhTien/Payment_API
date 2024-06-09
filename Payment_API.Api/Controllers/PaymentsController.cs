using Mapster;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Features.Commands;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Features.Payment.Commands;
using Payment_API.Service.VnPay.Config;
using Payment_API.Service.VnPay.Response;
using Payment_API.Ultils.Extensions;
using System.Net;

namespace Payment_API.Api.Controllers
{
    /// <summary>
    /// Payment api endpoint
    /// </summary>
    [Route("api/payment")]
    [ApiController]
    public class PaymentsController : ControllerBase
    {
        private readonly IMediator _mediator;
        private readonly VnPayConfig _vnPayConfig;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="mediator"></param>
        /// <param name="vnPayConfig"></param>
        public PaymentsController(IMediator mediator,
            IOptions<VnPayConfig> vnPayConfig)
        {
            _mediator = mediator;
            _vnPayConfig = vnPayConfig.Value;
        }
        /// <summary>
        /// Create payment to get link
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost]
        [ProducesResponseType(typeof(BaseResultWithData<PaymentLinkDtos>), (int)HttpStatusCode.Created)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> Create([FromBody] CreatePayment request)
        {
            var response = new BaseResultWithData<PaymentLinkDtos>();
            response = await _mediator.Send(request);
            return Ok(response);
        }
        /// <summary>
        /// Process return payment vnpay
        /// </summary>
        /// <param name="response"></param>
        /// <returns></returns>
        [HttpGet("vnpay-return")]
        public async Task<IActionResult> VnPayReturn([FromQuery]VnPayPayResponse response)
        {
            string returnUrl = string.Empty;
            var returnModel = new PaymentReturnDtos();
            var processResult = await _mediator.Send(response.Adapt<ProcessVnPayPaymentReturn>());
            if (processResult.Success)
            {
                returnModel = processResult.Data.Item1 as PaymentReturnDtos;
                returnUrl = processResult.Data.Item2 as string;
            }
            if(returnUrl.EndsWith("/"))
                returnUrl = returnUrl.Remove(returnUrl.Length - 1, 1);
            return Redirect($"{returnUrl}?{returnModel.ToQueryString()}");
        }
        /// <summary>
        /// Process return payment momo
        /// </summary>
        /// <param name="response"></param>
        /// <returns></returns>
        [HttpGet("momo-return")]
        public async Task<IActionResult> MomoReturn([FromQuery] ProcessMomoPaymentReturn response)
        {
            string returnUrl = string.Empty;
            var returnModel = new PaymentReturnDtos();
            var processResult = await _mediator.Send(response.Adapt<ProcessMomoPaymentReturn>());
            if (processResult.Success)
            {
                returnModel = processResult.Data.Item1 as PaymentReturnDtos;
                returnUrl = processResult.Data.Item2 as string;
            }
            if (returnUrl.EndsWith("/"))
                returnUrl = returnUrl.Remove(returnUrl.Length - 1, 1);
            return Redirect($"{returnUrl}?{returnModel.ToQueryString()}");
        }
    }
}
