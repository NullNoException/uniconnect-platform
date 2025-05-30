using MediatR;
using Microsoft.AspNetCore.Mvc;
using UniConnect.Application.Providers.Commands.RegisterProvider;
using UniConnect.Application.Providers.Commands.VerifyProvider;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.API.Areas.Provider.Controllers;

[ApiController]
[Route("api/v1/provider/[controller]")]
public class ProvidersController : ControllerBase
{
    private readonly IMediator _mediator;
    public ProvidersController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Registers a new provider account.
    /// </summary>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPost("register")]
    [ProducesResponseType(typeof(ProviderDto), 201)]
    [ProducesResponseType(400)]
    [ProducesResponseType(409)]
    public async Task<IActionResult> Register([FromBody] RegisterProviderCommand command)
    {
        try
        {
            var result = await _mediator.Send(command);
            return CreatedAtAction(nameof(Register), new { id = result.Id }, result);
        }
        catch (InvalidOperationException ex)
        {
            return Conflict(new { message = ex.Message });
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    /// <summary>
    /// Verifies a provider (approve or reject).
    /// </summary>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPost("verify")]
    [ProducesResponseType(typeof(ProviderDto), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> Verify([FromBody] VerifyProviderCommand command)
    {
        try
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }
        catch (InvalidOperationException ex)
        {
            return NotFound(new { message = ex.Message });
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }
}
