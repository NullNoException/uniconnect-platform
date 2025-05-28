using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using DomainServiceProvider = UniConnect.Domain.Entities.ServiceProvider;

namespace UniConnect.API.Controllers;

public class SearchController : ApiControllerBase
{
    private readonly ISearchService _searchService;
    private readonly ILogger<SearchController> _logger;

    public SearchController(ISearchService searchService, ILogger<SearchController> logger)
    {
        _searchService = searchService;
        _logger = logger;
    }

    /// <summary>
    /// Search across services
    /// </summary>
    /// <param name="query">Search query term</param>
    /// <param name="page">Page number (1-based)</param>
    /// <param name="pageSize">Number of items per page</param>
    /// <returns>List of services matching the search query</returns>
    [HttpGet("services")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<IEnumerable<Service>>> SearchServices(
        [FromQuery] string query,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Searching services with query: {Query}, Page: {Page}, PageSize: {PageSize}",
            query, page, pageSize);

        var results = await _searchService.SearchAsync<Service>(query, page, pageSize);
        return Ok(results);
    }

    /// <summary>
    /// Search across service providers
    /// </summary>
    /// <param name="query">Search query term</param>
    /// <param name="page">Page number (1-based)</param>
    /// <param name="pageSize">Number of items per page</param>
    /// <returns>List of service providers matching the search query</returns>
    [HttpGet("providers")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<IEnumerable<DomainServiceProvider>>> SearchProviders(
        [FromQuery] string query,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Searching service providers with query: {Query}, Page: {Page}, PageSize: {PageSize}",
            query, page, pageSize);

        var results = await _searchService.SearchAsync<DomainServiceProvider>(query, page, pageSize);
        return Ok(results);
    }

    /// <summary>
    /// Search across universities
    /// </summary>
    /// <param name="query">Search query term</param>
    /// <param name="page">Page number (1-based)</param>
    /// <param name="pageSize">Number of items per page</param>
    /// <returns>List of universities matching the search query</returns>
    [HttpGet("universities")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<IEnumerable<University>>> SearchUniversities(
        [FromQuery] string query,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Searching universities with query: {Query}, Page: {Page}, PageSize: {PageSize}",
            query, page, pageSize);

        var results = await _searchService.SearchAsync<University>(query, page, pageSize);
        return Ok(results);
    }

    /// <summary>
    /// Search across all types of entities
    /// </summary>
    /// <param name="query">Search query term</param>
    /// <param name="page">Page number (1-based)</param>
    /// <param name="pageSize">Number of items per page</param>
    /// <returns>List of search results from different entity types</returns>
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<GlobalSearchResults>> SearchAll(
        [FromQuery] string query,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Performing global search with query: {Query}, Page: {Page}, PageSize: {PageSize}",
            query, page, pageSize);

        var servicesTask = _searchService.SearchAsync<Service>(query, page, pageSize);
        var providersTask = _searchService.SearchAsync<DomainServiceProvider>(query, page, pageSize);
        var universitiesTask = _searchService.SearchAsync<University>(query, page, pageSize);

        await Task.WhenAll(servicesTask, providersTask, universitiesTask);

        var results = new GlobalSearchResults
        {
            Services = servicesTask.Result.ToList(),
            ServiceProviders = providersTask.Result.ToList(),
            Universities = universitiesTask.Result.ToList()
        };

        return Ok(results);
    }
}

public class GlobalSearchResults
{
    public List<Service> Services { get; set; } = new List<Service>();
    public List<DomainServiceProvider> ServiceProviders { get; set; } = new List<DomainServiceProvider>();
    public List<University> Universities { get; set; } = new List<University>();
}
