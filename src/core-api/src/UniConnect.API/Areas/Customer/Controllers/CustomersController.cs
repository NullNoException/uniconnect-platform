using MediatR;
using Microsoft.AspNetCore.Mvc;
using UniConnect.Application.Users.Commands.RegisterCustomer;
using UniConnect.Application.Users.Commands.CompleteCustomerProfile;

namespace UniConnect.API.Areas.Customer.Controllers;

[ApiController]
[Route("api/v1/customers")]
public class CustomersController : ControllerBase
{
    private readonly IMediator _mediator;
    public CustomersController(IMediator mediator) => _mediator = mediator;

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterCustomerCommand command)
    {
        var userId = await _mediator.Send(command);
        return CreatedAtAction(nameof(GetProfile), new { id = userId }, new { userId });
    }

    [HttpGet("{id}/profile")]
    public IActionResult GetProfile(Guid id)
    {
        // TODO: Implement profile query
        return Ok();
    }

    [HttpPost("{id}/profile/complete")]
    public async Task<IActionResult> CompleteProfile(Guid id, [FromBody] CompleteCustomerProfileCommand command)
    {
        if (id != command.UserId)
            return BadRequest("UserId mismatch");
        await _mediator.Send(command);
        return NoContent();
    }

    // Add endpoints for settings, etc.
}
