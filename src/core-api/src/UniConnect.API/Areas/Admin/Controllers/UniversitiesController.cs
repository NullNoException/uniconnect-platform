using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Universities.Commands.CreateUniversity;
using UniConnect.Application.Universities.Commands.DeleteUniversity;
using UniConnect.Application.Universities.Commands.UpdateUniversity;
using UniConnect.Application.Universities.Commands.VerifyUniversity;
using UniConnect.Application.Universities.DTOs;
using UniConnect.Application.Universities.Queries.GetAllUniversities;
using UniConnect.Application.Universities.Queries.GetUniversityById;
using UniConnect.Application.Universities.Queries.SearchUniversities;

namespace UniConnect.API.Areas.Admin.Controllers;

[Area("Admin")]
[Route("api/admin/universities")]
[Authorize(Roles = "Admin")]
public class UniversitiesController : ApiControllerBase
{
    private readonly IMediator _mediator;

    public UniversitiesController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Create a new university
    /// </summary>
    /// <param name="request">University creation request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Created university</returns>
    [HttpPost]
    [ProducesResponseType(typeof(UniversityDto), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<UniversityDto>> CreateUniversity(
        [FromBody] CreateUniversityRequest request,
        CancellationToken cancellationToken)
    {
        var command = new CreateUniversityCommand(request);
        var result = await _mediator.Send(command, cancellationToken);
        return CreatedAtAction(nameof(GetUniversityById), new { id = result.Id }, result);
    }

    /// <summary>
    /// Get university by ID (Admin view with all details)
    /// </summary>
    /// <param name="id">University ID</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>University details</returns>
    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(UniversityDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<UniversityDto>> GetUniversityById(
        Guid id,
        CancellationToken cancellationToken)
    {
        var query = new GetUniversityByIdQuery(id);
        var result = await _mediator.Send(query, cancellationToken);
        return Ok(result);
    }

    /// <summary>
    /// Update university
    /// </summary>
    /// <param name="id">University ID</param>
    /// <param name="request">Update request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Updated university</returns>
    [HttpPut("{id:guid}")]
    [ProducesResponseType(typeof(UniversityDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<UniversityDto>> UpdateUniversity(
        Guid id,
        [FromBody] UpdateUniversityRequest request,
        CancellationToken cancellationToken)
    {
        var command = new UpdateUniversityCommand(request);
        var result = await _mediator.Send(command, cancellationToken);
        return Ok(result);
    }

    /// <summary>
    /// Delete university (soft delete)
    /// </summary>
    /// <param name="id">University ID</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>No content</returns>
    [HttpDelete("{id:guid}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<IActionResult> DeleteUniversity(
        Guid id,
        CancellationToken cancellationToken)
    {
        var command = new DeleteUniversityCommand(id);
        await _mediator.Send(command, cancellationToken);
        return NoContent();
    }

    /// <summary>
    /// Verify university
    /// </summary>
    /// <param name="id">University ID</param>
    /// <param name="request">Verification request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Updated university</returns>
    [HttpPost("{id:guid}/verify")]
    [ProducesResponseType(typeof(UniversityDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<UniversityDto>> VerifyUniversity(
        Guid id,
        [FromBody] VerifyUniversityRequest request,
        CancellationToken cancellationToken)
    {
        var verificationRequest = new UniversityVerificationRequest
        {
            UniversityId = id,
            Status = request.IsApproved ? Domain.Enums.UniversityStatus.Verified : Domain.Enums.UniversityStatus.Rejected,
            Comments = request.VerificationNotes
        };

        var command = new VerifyUniversityCommand(verificationRequest);
        var result = await _mediator.Send(command, cancellationToken);
        return Ok(result);
    }

    /// <summary>
    /// Get all universities with admin filtering options
    /// </summary>
    /// <param name="page">Page number</param>
    /// <param name="pageSize">Page size</param>
    /// <param name="includeDeleted">Include deleted universities</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Paginated university list</returns>
    [HttpGet]
    [ProducesResponseType(typeof(UniversitySearchResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<UniversitySearchResponse>> GetAllUniversities(
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 20,
        [FromQuery] bool includeDeleted = false,
        CancellationToken cancellationToken = default)
    {
        var query = new GetAllUniversitiesQuery(page, pageSize, includeDeleted);
        var result = await _mediator.Send(query, cancellationToken);
        return Ok(result);
    }

    /// <summary>
    /// Search universities with advanced filtering
    /// </summary>
    /// <param name="request">Search request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Search results</returns>
    [HttpPost("search")]
    [ProducesResponseType(typeof(UniversitySearchResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<UniversitySearchResponse>> SearchUniversities(
        [FromBody] UniversitySearchRequest request,
        CancellationToken cancellationToken)
    {
        var query = new SearchUniversitiesQuery(request);
        var result = await _mediator.Send(query, cancellationToken);
        return Ok(result);
    }
}

public record VerifyUniversityRequest(
    bool IsApproved,
    string? VerificationNotes = null
);
