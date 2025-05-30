using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.AcademicCalendars.Commands.CreateSemester;
using UniConnect.Application.AcademicCalendars.Commands.UpdateSemesterDeadlines;
using UniConnect.Application.AcademicCalendars.Commands.UpdateSemesterPrograms;
using UniConnect.Application.AcademicCalendars.Commands.UpdateSemesterStatus;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.AcademicCalendars.Queries.ExportSemesters;
using UniConnect.Application.AcademicCalendars.Queries.GetSemesterById;
using UniConnect.Application.AcademicCalendars.Queries.GetSemesters;
using UniConnect.Application.AcademicCalendars.Queries.GetSemestersByAcademicYearId;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Models;
using UniConnect.Domain.Enums;

namespace UniConnect.API.Areas.Admin.Controllers;

[Area("Admin")]
[Authorize(Roles = "Admin")]
[Route("api/v1/admin/[controller]")]
public class SemestersController : ApiControllerBase
{
    private readonly IMediator _mediator;
    private readonly ISemesterStatusService _semesterStatusService;

    public SemestersController(IMediator mediator, ISemesterStatusService semesterStatusService)
    {
        _mediator = mediator;
        _semesterStatusService = semesterStatusService;
    }

    /// <summary>
    /// Create a new semester
    /// </summary>
    /// <param name="request">Semester creation request</param>
    /// <returns>Created semester</returns>
    [HttpPost]
    [ProducesResponseType(typeof(SemesterDto), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<SemesterDto>> CreateSemester(
        [FromBody] CreateSemesterRequest request,
        CancellationToken cancellationToken)
    {
        var command = new CreateSemesterCommand(request);
        var result = await _mediator.Send(command, cancellationToken);

        return CreatedAtAction(nameof(GetSemesterById), new { id = result.Id }, result);
    }

    /// <summary>
    /// Update semester status
    /// </summary>
    /// <param name="id">Semester ID</param>
    /// <param name="status">New status</param>
    /// <returns>Updated semester</returns>
    [HttpPatch("{id}/status")]
    [ProducesResponseType(typeof(SemesterDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<SemesterDto>> UpdateSemesterStatus(
        Guid id,
        [FromBody] SemesterStatus status,
        CancellationToken cancellationToken)
    {
        var command = new UpdateSemesterStatusCommand(id, status);
        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Get a semester by ID
    /// </summary>
    /// <param name="id">Semester ID</param>
    /// <returns>Semester details</returns>
    [HttpGet("{id}")]
    [ProducesResponseType(typeof(SemesterDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<SemesterDto>> GetSemesterById(
        Guid id,
        CancellationToken cancellationToken)
    {
        var query = new GetSemesterByIdQuery(id);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Get semesters with filtering options
    /// </summary>
    /// <param name="request">Filter parameters</param>
    /// <returns>List of semesters</returns>
    [HttpGet]
    [ProducesResponseType(typeof(PaginatedList<SemesterDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<PaginatedList<SemesterDto>>> GetSemesters(
        [FromQuery] GetSemestersRequest request,
        CancellationToken cancellationToken)
    {
        var query = new GetSemestersQuery(request);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Get all semesters for an academic year
    /// </summary>
    /// <param name="academicYearId">Academic year ID</param>
    /// <returns>List of semesters</returns>
    [HttpGet("by-academic-year/{academicYearId}")]
    [ProducesResponseType(typeof(List<SemesterDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<List<SemesterDto>>> GetSemestersByAcademicYear(
        Guid academicYearId,
        CancellationToken cancellationToken)
    {
        var query = new GetSemestersByAcademicYearIdQuery(academicYearId);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Manually trigger update of semester statuses based on current date
    /// </summary>
    /// <returns>Success message</returns>
    [HttpPost("update-statuses")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult> UpdateSemesterStatuses(CancellationToken cancellationToken)
    {
        await _semesterStatusService.UpdateSemesterStatusesAsync(cancellationToken);
        return Ok(new { message = "Semester statuses updated successfully" });
    }

    /// <summary>
    /// Update deadlines for a semester
    /// </summary>
    /// <param name="request">Deadline update request</param>
    /// <returns>Updated deadlines</returns>
    [HttpPut("deadlines")]
    [ProducesResponseType(typeof(List<DeadlineDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<List<DeadlineDto>>> UpdateSemesterDeadlines(
        [FromBody] UpdateSemesterDeadlinesRequest request,
        CancellationToken cancellationToken)
    {
        var command = new UpdateSemesterDeadlinesCommand(request);
        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Update programs associated with a semester
    /// </summary>
    /// <param name="request">Program update request</param>
    /// <returns>Updated semester programs</returns>
    [HttpPut("programs")]
    [ProducesResponseType(typeof(List<SemesterProgramDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<List<SemesterProgramDto>>> UpdateSemesterPrograms(
        [FromBody] UpdateSemesterProgramsRequest request,
        CancellationToken cancellationToken)
    {
        var command = new UpdateSemesterProgramsCommand(request);
        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Export semesters to Excel
    /// </summary>
    /// <param name="academicYearId">Optional academic year ID filter</param>
    /// <param name="academicCalendarId">Optional academic calendar ID filter</param>
    /// <returns>Excel file</returns>
    [HttpGet("export")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<IActionResult> ExportSemesters(
        [FromQuery] Guid? academicYearId = null,
        [FromQuery] Guid? academicCalendarId = null,
        CancellationToken cancellationToken = default)
    {
        var query = new ExportSemestersQuery(academicYearId, academicCalendarId);
        var result = await _mediator.Send(query, cancellationToken);

        return File(result.Content, result.ContentType, result.FileName);
    }
}
