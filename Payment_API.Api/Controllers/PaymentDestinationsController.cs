using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Payment_API.Api.Services;
using Payment_API.Application.Base.Models;
using Payment_API.Application.Features.Commands;
using Payment_API.Application.Features.Dtos;
using Payment_API.Application.Features.PaymentDestination.Dtos;
using Payment_API.Application.Features.Queries;
using Payment_API.Application.Interface;
using Payment_API.Persistence.Persist;
using System.Net;

namespace Payment_API.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentDestinationsController : ControllerBase
    {
        private readonly IMediator _mediator;
        private readonly IConnectionService _connectionService;
        private readonly ISqlService _sqlService;

        public PaymentDestinationsController(IMediator mediator,
            IConnectionService connectionService,
            ISqlService sqlService)
        {
            _mediator = mediator;
            _connectionService = connectionService;
            _sqlService = sqlService;
        }
        [HttpGet]
        [ProducesResponseType(typeof(BaseResultWithData<List<PaymentDestinationDtos>>), 200)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> Get(string? criteria = "")
        {
            try
            {
                var getPaymentDestinations = new GetPaymentDestinations();
                var response = getPaymentDestinations.Handle(criteria ?? "", _connectionService, _sqlService);
                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        [ProducesResponseType(typeof(BaseResultWithData<PaymentDestinationDtos>), (int)HttpStatusCode.Created)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> Create([FromBody] CreatePaymentDestination request)
        {
            try
            {
                var response = new BaseResultWithData<PaymentDestinationDtos>();
                response = await _mediator.Send(request);
                return Ok(response);
            }
            catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
