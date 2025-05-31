using MediatR;
using Microsoft.AspNetCore.Mvc;
using UniConnect.Application.Providers.Commands.RegisterProvider;
using UniConnect.Application.Providers.Commands.VerifyProvider;
using UniConnect.Application.Providers.Commands.StaffAccountManagement;
using UniConnect.Application.Providers.Commands.ServiceManagement;
using UniConnect.Application.Providers.Commands.ApplicationManagement;
using UniConnect.Application.Providers.Commands.FinancialManagement;
using UniConnect.Application.Providers.Queries.ServiceManagement;
using UniConnect.Application.Providers.Queries.ApplicationManagement;
using UniConnect.Application.Providers.Queries.FinancialManagement;
using UniConnect.Application.Providers.Queries.StaffAccountManagement;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Application.Services.DTOs;

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

    /// <summary>
    /// Creates a new staff account for a provider.
    /// </summary>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPost("staff")]
    [ProducesResponseType(typeof(ProviderStaffDto), 201)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> CreateStaff([FromBody] CreateProviderStaffCommand command)
    {
        try
        {
            var result = await _mediator.Send(command);
            return CreatedAtAction(nameof(CreateStaff), new { id = result.Id }, result);
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

    /// <summary>
    /// Creates a new service listing for a provider.
    /// </summary>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPost("services")]
    [ProducesResponseType(typeof(ServiceDto), 201)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> CreateServiceListing([FromBody] CreateServiceListingCommand command)
    {
        try
        {
            var result = await _mediator.Send(command);
            return CreatedAtAction(nameof(CreateServiceListing), new { id = result.Id }, result);
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

    /// <summary>
    /// Updates an existing service listing for a provider.
    /// </summary>
    /// <param name="serviceId"></param>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPut("services/{serviceId:guid}")]
    [ProducesResponseType(typeof(ServiceDto), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> UpdateServiceListing(Guid serviceId, [FromBody] UpdateServiceListingCommand command)
    {
        try
        {
            // Ensure the serviceId from route matches the command
            var updatedCommand = command with { ServiceId = serviceId };
            var result = await _mediator.Send(updatedCommand);
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

    /// <summary>
    /// Gets all service listings for a provider.
    /// </summary>
    /// <param name="providerId"></param>
    /// <param name="isActive"></param>
    /// <param name="categoryId"></param>
    /// <returns></returns>
    [HttpGet("{providerId:guid}/services")]
    [ProducesResponseType(typeof(List<ServiceDto>), 200)]
    [ProducesResponseType(400)]
    public async Task<IActionResult> GetProviderServices(
        Guid providerId,
        [FromQuery] bool? isActive = null,
        [FromQuery] Guid? categoryId = null)
    {
        try
        {
            var query = new GetProviderServicesQuery
            {
                ProviderId = providerId,
                IsActive = isActive,
                CategoryId = categoryId
            };
            var result = await _mediator.Send(query);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    /// <summary>
    /// Gets all applications/service requests for a provider.
    /// </summary>
    /// <param name="providerId"></param>
    /// <param name="status"></param>
    /// <param name="dateFrom"></param>
    /// <param name="dateTo"></param>
    /// <param name="pageNumber"></param>
    /// <param name="pageSize"></param>
    /// <returns></returns>
    [HttpGet("{providerId:guid}/applications")]
    [ProducesResponseType(typeof(List<ServiceRequestDto>), 200)]
    [ProducesResponseType(400)]
    public async Task<IActionResult> GetProviderApplications(
        Guid providerId,
        [FromQuery] string? status = null,
        [FromQuery] DateTime? dateFrom = null,
        [FromQuery] DateTime? dateTo = null,
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10)
    {
        try
        {
            var query = new GetProviderApplicationsQuery
            {
                ProviderId = providerId,
                Status = status,
                DateFrom = dateFrom,
                DateTo = dateTo,
                PageNumber = pageNumber,
                PageSize = pageSize
            };
            var result = await _mediator.Send(query);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    /// <summary>
    /// Processes an application by updating its status.
    /// </summary>
    /// <param name="applicationId"></param>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPut("applications/{applicationId:guid}/process")]
    [ProducesResponseType(typeof(ServiceRequestDto), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> ProcessApplication(Guid applicationId, [FromBody] ProcessApplicationCommand command)
    {
        try
        {
            // Ensure the applicationId from route matches the command
            var updatedCommand = command with { ApplicationId = applicationId };
            var result = await _mediator.Send(updatedCommand);
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

    /// <summary>
    /// Requests revision for an application with specific feedback.
    /// </summary>
    /// <param name="applicationId"></param>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPost("applications/{applicationId:guid}/request-revision")]
    [ProducesResponseType(typeof(ServiceRequestDto), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> RequestApplicationRevision(Guid applicationId, [FromBody] RequestApplicationRevisionCommand command)
    {
        try
        {
            // Ensure the applicationId from route matches the command
            var updatedCommand = command with { ApplicationId = applicationId };
            var result = await _mediator.Send(updatedCommand);
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

    // Financial Management Endpoints

    /// <summary>
    /// Gets provider earnings overview and financial data.
    /// </summary>
    /// <param name="providerId"></param>
    /// <param name="dateFrom"></param>
    /// <param name="dateTo"></param>
    /// <param name="includeProjections"></param>
    /// <returns></returns>
    [HttpGet("{providerId:guid}/earnings")]
    [ProducesResponseType(typeof(ProviderEarningsDto), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> GetProviderEarnings(
        Guid providerId,
        [FromQuery] DateTime? dateFrom = null,
        [FromQuery] DateTime? dateTo = null,
        [FromQuery] bool includeProjections = false)
    {
        try
        {
            var query = new GetProviderEarningsQuery
            {
                ProviderId = providerId,
                DateFrom = dateFrom,
                DateTo = dateTo,
                IncludeProjections = includeProjections
            };
            var result = await _mediator.Send(query);
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

    /// <summary>
    /// Manages provider payment methods (create, update, delete, set default).
    /// </summary>
    /// <param name="providerId"></param>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPost("{providerId:guid}/payment-methods")]
    [ProducesResponseType(typeof(PaymentMethodDto), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> ManagePaymentMethod(Guid providerId, [FromBody] ManagePaymentMethodCommand command)
    {
        try
        {
            // Ensure the providerId from route matches the command
            var updatedCommand = command with { ProviderId = providerId };
            var result = await _mediator.Send(updatedCommand);
            return Ok(result);
        }
        catch (InvalidOperationException ex)
        {
            return NotFound(new { message = ex.Message });
        }
        catch (ArgumentException ex)
        {
            return BadRequest(new { message = ex.Message });
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    /// <summary>
    /// Receives and acknowledges escrow payment release.
    /// </summary>
    /// <param name="providerId"></param>
    /// <param name="transactionId"></param>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPost("{providerId:guid}/transactions/{transactionId:guid}/receive-escrow")]
    [ProducesResponseType(typeof(EscrowReleaseDto), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> ReceiveEscrowRelease(
        Guid providerId,
        Guid transactionId,
        [FromBody] ReceiveEscrowReleaseCommand command)
    {
        try
        {
            // Ensure the IDs from route match the command
            var updatedCommand = command with
            {
                ProviderId = providerId,
                TransactionId = transactionId
            };
            var result = await _mediator.Send(updatedCommand);
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

    /// <summary>
    /// Gets all staff members for a provider.
    /// </summary>
    /// <param name="providerId"></param>
    /// <param name="isActive"></param>
    /// <param name="role"></param>
    /// <param name="department"></param>
    /// <returns></returns>
    [HttpGet("{providerId:guid}/staff")]
    [ProducesResponseType(typeof(List<ProviderStaffDto>), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> GetProviderStaff(
        Guid providerId,
        [FromQuery] bool? isActive = null,
        [FromQuery] string? role = null,
        [FromQuery] string? department = null)
    {
        try
        {
            var query = new GetProviderStaffQuery
            {
                ProviderId = providerId,
                IsActive = isActive,
                Role = role,
                Department = department
            };
            var result = await _mediator.Send(query);
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

    /// <summary>
    /// Updates an existing staff member.
    /// </summary>
    /// <param name="providerId"></param>
    /// <param name="staffId"></param>
    /// <param name="command"></param>
    /// <returns></returns>
    [HttpPut("{providerId:guid}/staff/{staffId:guid}")]
    [ProducesResponseType(typeof(ProviderStaffDto), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> UpdateProviderStaff(
        Guid providerId,
        Guid staffId,
        [FromBody] UpdateProviderStaffCommand command)
    {
        try
        {
            // Ensure the IDs from route match the command
            var updatedCommand = command with
            {
                ProviderId = providerId,
                StaffId = staffId
            };
            var result = await _mediator.Send(updatedCommand);
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
