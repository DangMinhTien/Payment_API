using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Features.Commands;
using Payment_API.Application.Features.Dtos;
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
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="mediator"></param>
        public PaymentsController(IMediator mediator)
        {
            _mediator = mediator;
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
        [HttpGet("vnpay-return")]
        public async Task<IActionResult> VnPayReturn([FromQuery]VnPayPayResponse response)
        {
            string returnUrl = string.Empty;
            var returnModel = new PaymentReturnDtos();

            if(returnUrl.EndsWith("/"))
                returnUrl = returnUrl.Remove(returnUrl.Length - 1, 1);
            return Redirect($"{returnUrl}?{returnModel.ToQueryString()}");
        }
    }
}
