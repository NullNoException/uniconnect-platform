using MediatR;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Universities.DTOs;
using UniConnect.Application.Universities.Queries.GetUniversityById;
using UniConnect.Application.Universities.Queries.SearchUniversities;

namespace UniConnect.API.Areas.Customer.Controllers;

[Area("Customer")]
[Route("api/universities")]
public class UniversitiesController : ApiControllerBase
{
    private readonly IMediator _mediator;

    public UniversitiesController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Get university by ID (Public view - only active universities)
    /// </summary>
    /// <param name="id">University ID</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>University details</returns>
    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(UniversityDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<UniversityDto>> GetUniversityById(
        Guid id,
        CancellationToken cancellationToken)
    {
        var query = new GetUniversityByIdQuery(id);
        var result = await _mediator.Send(query, cancellationToken);
        return Ok(result);
    }

    /// <summary>
    /// Search universities (Public search - only active universities)
    /// </summary>
    /// <param name="request">Search request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Search results</returns>
    [HttpPost("search")]
    [ProducesResponseType(typeof(UniversitySearchResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<UniversitySearchResponse>> SearchUniversities(
        [FromBody] UniversitySearchRequest request,
        CancellationToken cancellationToken)
    {
        var query = new SearchUniversitiesQuery(request);
        var result = await _mediator.Send(query, cancellationToken);
        return Ok(result);
    }

    /// <summary>
    /// Search universities with GET parameters (for simple queries)
    /// </summary>
    /// <param name="name">University name (partial match)</param>
    /// <param name="countryId">Country ID filter</param>
    /// <param name="type">University type filter</param>
    /// <param name="page">Page number</param>
    /// <param name="pageSize">Page size</param>
    /// <param name="sortBy">Sort field</param>
    /// <param name="sortOrder">Sort order (asc/desc)</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Search results</returns>
    [HttpGet("search")]
    [ProducesResponseType(typeof(UniversitySearchResponse), StatusCodes.Status200OK)]
    public async Task<ActionResult<UniversitySearchResponse>> SearchUniversitiesGet(
        [FromQuery] string? name = null,
        [FromQuery] Guid? countryId = null,
        [FromQuery] string? type = null,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 20,
        [FromQuery] string sortBy = "Name",
        [FromQuery] string sortOrder = "asc",
        CancellationToken cancellationToken = default)
    {
        var searchRequest = new UniversitySearchRequest
        {
            Name = name,
            CountryId = countryId,
            Type = type,
            Page = page,
            PageSize = pageSize,
            SortBy = sortBy,
            SortOrder = sortOrder
        };

        var query = new SearchUniversitiesQuery(searchRequest);
        var result = await _mediator.Send(query, cancellationToken);
        return Ok(result);
    }

    /// <summary>
    /// Get university programs
    /// </summary>
    /// <param name="id">University ID</param>
    /// <param name="page">Page number</param>
    /// <param name="pageSize">Page size</param>
    /// <param name="levelId">Academic level filter</param>
    /// <param name="majorId">Major filter</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>University programs</returns>
    [HttpGet("{id:guid}/programs")]
    [ProducesResponseType(typeof(List<AcademicProgramDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<List<AcademicProgramDto>>> GetUniversityPrograms(
        Guid id,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 50,
        [FromQuery] Guid? levelId = null,
        [FromQuery] Guid? majorId = null,
        CancellationToken cancellationToken = default)
    {
        // This would be implemented as a separate query handler
        // For now, we can use the university details and filter programs
        var universityQuery = new GetUniversityByIdQuery(id);
        var university = await _mediator.Send(universityQuery, cancellationToken);

        if (university?.Programs == null)
        {
            return NotFound();
        }

        var programs = university.Programs.AsEnumerable();

        if (levelId.HasValue)
        {
            // Note: This filtering would ideally be done at the database level
            // through a dedicated GetUniversityProgramsQuery
            programs = programs.Where(p => p.AcademicLevelName != null);
        }

        if (majorId.HasValue)
        {
            programs = programs.Where(p => p.MajorName != null);
        }

        var paginatedPrograms = programs
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToList();

        return Ok(paginatedPrograms);
    }
}
