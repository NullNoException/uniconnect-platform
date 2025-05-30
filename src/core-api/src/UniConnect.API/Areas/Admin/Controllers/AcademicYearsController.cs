using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.AcademicCalendars.Commands.CreateAcademicYear;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.AcademicCalendars.Queries.GetAcademicYearsByCalendarId;
using UniConnect.Application.Common.Models;

namespace UniConnect.API.Areas.Admin.Controllers;

[Authorize(Roles = "Admin")]
[Area("Admin")]
[Route("api/v1/admin/academic-years")]
public class AcademicYearsController : ApiControllerBase
{
    private readonly IMediator _mediator;

    public AcademicYearsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Create a new academic year
    /// </summary>
    /// <param name="request">Academic year creation request</param>
    /// <returns>Created academic year</returns>
    [HttpPost]
    [ProducesResponseType(typeof(AcademicYearDto), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<AcademicYearDto>> CreateAcademicYear(
        [FromBody] CreateAcademicYearRequest request,
        CancellationToken cancellationToken)
    {
        var command = new CreateAcademicYearCommand(request);
        var result = await _mediator.Send(command, cancellationToken);

        return CreatedAtAction(nameof(GetAcademicYearsByCalendarId),
            new { calendarId = result.AcademicCalendarId }, result);
    }

    /// <summary>
    /// Get academic years by calendar ID
    /// </summary>
    /// <param name="calendarId">Academic calendar ID</param>
    /// <param name="request">Query parameters</param>
    /// <returns>List of academic years</returns>
    [HttpGet("by-calendar/{calendarId}")]
    [ProducesResponseType(typeof(PaginatedList<AcademicYearDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<PaginatedList<AcademicYearDto>>> GetAcademicYearsByCalendarId(
        Guid calendarId,
        [FromQuery] GetAcademicYearsByCalendarIdRequest request,
        CancellationToken cancellationToken)
    {
        var query = new GetAcademicYearsByCalendarIdQuery(calendarId, request);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }
}
