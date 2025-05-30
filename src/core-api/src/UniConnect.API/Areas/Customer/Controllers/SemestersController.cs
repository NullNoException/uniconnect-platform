using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.AcademicCalendars.Queries.GetSemesterById;
using UniConnect.Application.AcademicCalendars.Queries.GetSemesters;
using UniConnect.Application.AcademicCalendars.Queries.GetSemestersByAcademicYearId;
using UniConnect.Application.Common.Models;

namespace UniConnect.API.Areas.Customer.Controllers;

[Area("Customer")]
[Authorize]
[Route("api/v1/customer/[controller]")]
public class SemestersController : ApiControllerBase
{
    private readonly IMediator _mediator;

    public SemestersController(IMediator mediator)
    {
        _mediator = mediator;
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
    public async Task<ActionResult<PaginatedList<SemesterDto>>> GetSemesters(
        [FromQuery] GetSemestersRequest request,
        CancellationToken cancellationToken)
    {
        // For security, only allow viewing active or upcoming semesters for customers
        if (request.Status == Domain.Enums.SemesterStatus.Archived)
        {
            return BadRequest("Customers cannot view archived semesters");
        }

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
    public async Task<ActionResult<List<SemesterDto>>> GetSemestersByAcademicYear(
        Guid academicYearId,
        CancellationToken cancellationToken)
    {
        var query = new GetSemestersByAcademicYearIdQuery(academicYearId);
        var result = await _mediator.Send(query, cancellationToken);

        // Filter out archived semesters for customers
        result = result.Where(s => s.Status != Domain.Enums.SemesterStatus.Archived).ToList();

        return Ok(result);
    }

    /// <summary>
    /// Get current active semesters
    /// </summary>
    /// <returns>List of active semesters</returns>
    [HttpGet("current")]
    [ProducesResponseType(typeof(List<SemesterDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<List<SemesterDto>>> GetCurrentSemesters(CancellationToken cancellationToken)
    {
        var request = new GetSemestersRequest
        {
            Status = Domain.Enums.SemesterStatus.Active,
            Current = true,
            PageSize = 100 // Larger page size as we expect to return all current semesters
        };

        var query = new GetSemestersQuery(request);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result.Items);
    }
}
