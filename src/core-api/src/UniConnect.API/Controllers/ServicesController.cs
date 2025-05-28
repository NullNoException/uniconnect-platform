using MediatR;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Services.Commands;
using UniConnect.Application.Services.Queries;

namespace UniConnect.API.Controllers;

public class ServicesController : ApiControllerBase
{
    private readonly IMediator _mediator;
    private readonly ILogger<ServicesController> _logger;

    public ServicesController(
        IMediator mediator,
        ILogger<ServicesController> logger)
    {
        _mediator = mediator;
        _logger = logger;
    }

    /// <summary>
    /// Creates a new service.
    /// </summary>
    /// <param name="command">The service creation command.</param>
    /// <returns>The ID of the created service.</returns>
    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<IActionResult> Create([FromBody] CreateServiceCommand command)
    {
        var serviceId = await _mediator.Send(command);
        _logger.LogInformation("Service {ServiceId} created", serviceId);
        return CreatedAtAction(nameof(GetById), new { id = serviceId }, serviceId);
    }

    /// <summary>
    /// Gets a service by its ID.
    /// </summary>
    /// <param name="id">The service ID.</param>
    /// <returns>The service details.</returns>
    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetById(Guid id)
    {
        var query = new GetServiceByIdQuery(id);
        var result = await _mediator.Send(query);

        if (result == null)
        {
            return NotFound();
        }

        return Ok(result);
    }

    /// <summary>
    /// Gets a paginated list of services.
    /// </summary>
    /// <param name="query">Query parameters for pagination and filtering.</param>
    /// <returns>Paginated list of services.</returns>
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> GetAll([FromQuery] GetServicesWithPaginationQuery query)
    {
        var result = await _mediator.Send(query);
        return Ok(result);
    }

    /// <summary>
    /// Gets services by provider ID.
    /// </summary>
    /// <param name="providerId">The service provider ID.</param>
    /// <returns>List of services offered by the specified provider.</returns>
    [HttpGet("provider/{providerId}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> GetByProviderId(Guid providerId)
    {
        var query = new GetServicesByProviderQuery(providerId);
        var result = await _mediator.Send(query);
        return Ok(result);
    }

    /// <summary>
    /// Gets services by category ID.
    /// </summary>
    /// <param name="categoryId">The service category ID.</param>
    /// <returns>List of services in the specified category.</returns>
    [HttpGet("category/{categoryId}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> GetByCategoryId(Guid categoryId)
    {
        var query = new GetServicesByCategoryQuery(categoryId);
        var result = await _mediator.Send(query);
        return Ok(result);
    }
}
