using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.AcademicCalendars.Commands.CreateAcademicCalendar;
using UniConnect.Application.AcademicCalendars.Commands.DeleteAcademicCalendar;
using UniConnect.Application.AcademicCalendars.Commands.ImportAcademicCalendars;
using UniConnect.Application.AcademicCalendars.Commands.UpdateAcademicCalendar;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.AcademicCalendars.Queries.ExportAcademicCalendars;
using UniConnect.Application.AcademicCalendars.Queries.GetAcademicCalendarById;
using UniConnect.Application.AcademicCalendars.Queries.GetAcademicCalendars;
using UniConnect.Application.Common.Models;

namespace UniConnect.API.Areas.Admin.Controllers;

[Authorize(Roles = "Admin")]
[Area("Admin")]
[Route("api/admin/academic-calendars")]
public class AcademicCalendarsController : ApiControllerBase
{
    private readonly IMediator _mediator;

    public AcademicCalendarsController(IMediator mediator)
    {
        _mediator = mediator;
    }
    /// <summary>
    /// Create a new academic calendar
    /// </summary>
    /// <param name="request">Academic calendar creation request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Created academic calendar</returns>
    [HttpPost]
    [ProducesResponseType(typeof(AcademicCalendarDto), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<AcademicCalendarDto>> CreateAcademicCalendar(
        [FromBody] CreateAcademicCalendarRequest request,
        CancellationToken cancellationToken)
    {
        var command = new CreateAcademicCalendarCommand(request);
        var result = await _mediator.Send(command, cancellationToken);

        return CreatedAtAction(nameof(GetAcademicCalendarById), new { id = result.Id }, result);
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
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<AcademicCalendarDto>> GetAcademicCalendarById(
        Guid id,
        CancellationToken cancellationToken)
    {
        var query = new GetAcademicCalendarByIdQuery(id);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Get academic calendars with pagination and filtering
    /// </summary>
    /// <param name="request">Query parameters</param>
    /// <returns>Paginated list of academic calendars</returns>
    [HttpGet]
    [ProducesResponseType(typeof(PaginatedList<AcademicCalendarDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<PaginatedList<AcademicCalendarDto>>> GetAcademicCalendars(
        [FromQuery] GetAcademicCalendarsRequest request,
        CancellationToken cancellationToken)
    {
        var query = new GetAcademicCalendarsQuery(request);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Update an academic calendar
    /// </summary>
    /// <param name="id">Academic calendar ID</param>
    /// <param name="request">Update request</param>
    /// <returns>Updated academic calendar</returns>
    [HttpPut("{id}")]
    [ProducesResponseType(typeof(AcademicCalendarDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<AcademicCalendarDto>> UpdateAcademicCalendar(
        Guid id,
        [FromBody] UpdateAcademicCalendarRequest request,
        CancellationToken cancellationToken)
    {
        var command = new UpdateAcademicCalendarCommand(id, request);
        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Delete an academic calendar
    /// </summary>
    /// <param name="id">Academic calendar ID</param>
    /// <returns>Success status</returns>
    [HttpDelete("{id}")]
    [ProducesResponseType(typeof(bool), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<bool>> DeleteAcademicCalendar(
        Guid id,
        CancellationToken cancellationToken)
    {
        var command = new DeleteAcademicCalendarCommand(id);
        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Import academic calendars from Excel file
    /// </summary>
    /// <param name="universityId">University ID</param>
    /// <returns>Import results</returns>
    [HttpPost("{universityId}/import")]
    [ProducesResponseType(typeof(ImportResult), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<ImportResult>> ImportAcademicCalendars(
        Guid universityId,
        IFormFile file,
        CancellationToken cancellationToken)
    {
        if (file == null || file.Length == 0)
        {
            return BadRequest("No file uploaded or file is empty");
        }

        if (!file.FileName.EndsWith(".xlsx", StringComparison.OrdinalIgnoreCase))
        {
            return BadRequest("Only .xlsx files are supported");
        }

        using (var memoryStream = new MemoryStream())
        {
            await file.CopyToAsync(memoryStream, cancellationToken);

            var request = new ImportAcademicCalendarsRequest
            {
                UniversityId = universityId,
                FileContent = memoryStream.ToArray()
            };

            var command = new ImportAcademicCalendarsCommand(request);
            var result = await _mediator.Send(command, cancellationToken);

            return Ok(result);
        }
    }

    /// <summary>
    /// Export academic calendars to Excel file
    /// </summary>
    /// <param name="universityId">University ID</param>
    /// <returns>Excel file</returns>
    [HttpGet("{universityId}/export")]
    [ProducesResponseType(typeof(FileResult), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<IActionResult> ExportAcademicCalendars(
        Guid universityId,
        CancellationToken cancellationToken)
    {
        var query = new ExportAcademicCalendarsQuery(universityId);
        var result = await _mediator.Send(query, cancellationToken);

        return File(
            result,
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            $"Academic_Calendars_{universityId}_{DateTime.UtcNow:yyyyMMdd_HHmmss}.xlsx");
    }
}
