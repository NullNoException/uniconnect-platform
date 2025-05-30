using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.AcademicCalendars.Queries.GetAcademicCalendarById;
using UniConnect.Application.AcademicCalendars.Queries.GetAcademicCalendars;
using UniConnect.Application.AcademicCalendars.Queries.GetAcademicYearsByCalendarId;
using UniConnect.Application.Common.Models;

namespace UniConnect.API.Areas.Customer.Controllers;

[Authorize]
[Area("Customer")]
[Route("api/v1/customer/academic-calendars")]
public class AcademicCalendarsController : ApiControllerBase
{
    private readonly IMediator _mediator;

    public AcademicCalendarsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Get academic calendar by ID
    /// </summary>
    /// <param name="id">Academic calendar ID</param>
    /// <returns>Academic calendar details</returns>
    [HttpGet("{id}")]
    [ProducesResponseType(typeof(AcademicCalendarDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<AcademicCalendarDto>> GetAcademicCalendarById(
        Guid id,
        CancellationToken cancellationToken)
    {
        var query = new GetAcademicCalendarByIdQuery(id);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Get academic calendars for a university
    /// </summary>
    /// <param name="request">Query parameters</param>
    /// <returns>Paginated list of academic calendars</returns>
    [HttpGet]
    [ProducesResponseType(typeof(PaginatedList<AcademicCalendarDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<PaginatedList<AcademicCalendarDto>>> GetAcademicCalendars(
        [FromQuery] GetAcademicCalendarsRequest request,
        CancellationToken cancellationToken)
    {
        // Only return active calendars for customers
        if (!request.IsActive.HasValue)
        {
            request.IsActive = true;
        }

        var query = new GetAcademicCalendarsQuery(request);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Get academic years by calendar ID
    /// </summary>
    /// <param name="calendarId">Academic calendar ID</param>
    /// <param name="request">Query parameters</param>
    /// <returns>List of academic years</returns>
    [HttpGet("{calendarId}/academic-years")]
    [ProducesResponseType(typeof(PaginatedList<AcademicYearDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<PaginatedList<AcademicYearDto>>> GetAcademicYearsByCalendarId(
        Guid calendarId,
        [FromQuery] GetAcademicYearsByCalendarIdRequest request,
        CancellationToken cancellationToken)
    {
        // Only return active academic years for customers
        if (!request.IsActive.HasValue)
        {
            request.IsActive = true;
        }

        var query = new GetAcademicYearsByCalendarIdQuery(calendarId, request);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }
}
