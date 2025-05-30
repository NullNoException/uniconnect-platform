using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Models;
using UniConnect.Domain.Entities;
using UniConnect.Infrastructure.Search.Models;
using DomainServiceProvider = UniConnect.Domain.Entities.ServiceProvider;

namespace UniConnect.API.Controllers;

[Route("api/search")]
public class SearchController : ApiControllerBase
{
    private readonly ISearchService _searchService;
    private readonly ILogger<SearchController> _logger;

    public SearchController(
        ISearchService searchService,
        ILogger<SearchController> logger)
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
    public async Task<ActionResult<SearchResult<ServiceSearchDocument>>> SearchServices(
        [FromQuery] string query = "",
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Searching services with query: {Query}, Page: {Page}, PageSize: {PageSize}",
            query, page, pageSize);

        var request = new SearchRequest
        {
            Query = query,
            Offset = (page - 1) * pageSize,
            Limit = pageSize
        };

        var results = await _searchService.SearchAsync<ServiceSearchDocument>(request);
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
    public async Task<ActionResult<SearchResult<ServiceProviderSearchDocument>>> SearchProviders(
        [FromQuery] string query = "",
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Searching service providers with query: {Query}, Page: {Page}, PageSize: {PageSize}",
            query, page, pageSize);

        var request = new SearchRequest
        {
            Query = query,
            Offset = (page - 1) * pageSize,
            Limit = pageSize
        };

        var results = await _searchService.SearchAsync<ServiceProviderSearchDocument>(request);
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
    public async Task<ActionResult<SearchResult<UniversitySearchDocument>>> SearchUniversities(
        [FromQuery] string query = "",
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Searching universities with query: {Query}, Page: {Page}, PageSize: {PageSize}",
            query, page, pageSize);

        var request = new SearchRequest
        {
            Query = query,
            Offset = (page - 1) * pageSize,
            Limit = pageSize
        };

        var results = await _searchService.SearchAsync<UniversitySearchDocument>(request);
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
        [FromQuery] string query = "",
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Performing global search with query: {Query}, Page: {Page}, PageSize: {PageSize}",
            query, page, pageSize);

        var request = new SearchRequest
        {
            Query = query,
            Offset = (page - 1) * pageSize,
            Limit = pageSize
        };

        var servicesTask = _searchService.SearchAsync<ServiceSearchDocument>(request);
        var providersTask = _searchService.SearchAsync<ServiceProviderSearchDocument>(request);
        var universitiesTask = _searchService.SearchAsync<UniversitySearchDocument>(request);

        await Task.WhenAll(servicesTask, providersTask, universitiesTask);

        var results = new GlobalSearchResults
        {
            Services = servicesTask.Result,
            ServiceProviders = providersTask.Result,
            Universities = universitiesTask.Result
        };

        return Ok(results);
    }

    /// <summary>
    /// Advanced search with faceted filtering, sorting, and multi-language support
    /// </summary>
    /// <param name="request">Advanced search request with filters and options</param>
    /// <returns>Advanced search results with facets and suggestions</returns>
    [HttpPost("advanced")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<SearchResult<ServiceSearchDocument>>> AdvancedSearchServices(
        [FromBody] SearchRequest request)
    {
        _logger.LogInformation("Performing advanced search with query: {Query}", request.Query);

        var results = await _searchService.SearchAsync<ServiceSearchDocument>(request);
        return Ok(results);
    }

    /// <summary>
    /// Search with language-specific results
    /// </summary>
    /// <param name="query">Search query</param>
    /// <param name="language">Language code (en, ar, fr, es, de)</param>
    /// <param name="offset">Result offset</param>
    /// <param name="limit">Result limit</param>
    /// <returns>Language-specific search results</returns>
    [HttpGet("language/{language}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<SearchResult<ServiceSearchDocument>>> SearchByLanguage(
        [FromQuery] string query,
        [FromRoute] string language,
        [FromQuery] int offset = 0,
        [FromQuery] int limit = 20)
    {
        _logger.LogInformation("Searching with language filter: {Language}, Query: {Query}", language, query);

        var request = new SearchRequest
        {
            Query = query,
            Offset = offset,
            Limit = limit
        };

        var results = await _searchService.SearchWithLanguageAsync<ServiceSearchDocument>(request, language);
        return Ok(results);
    }

    /// <summary>
    /// Get autocomplete suggestions for search queries
    /// </summary>
    /// <param name="query">Partial search query</param>
    /// <param name="categories">Filter by categories (optional)</param>
    /// <param name="limit">Maximum number of suggestions</param>
    /// <returns>List of search suggestions</returns>
    [HttpGet("suggestions")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<IEnumerable<SearchSuggestion>>> GetAutocompleteSuggestions(
        [FromQuery] string query = "",
        [FromQuery] string[]? categories = null,
        [FromQuery] int limit = 10)
    {
        _logger.LogDebug("Getting autocomplete suggestions for: {Query}", query);

        var suggestions = await _searchService.GetAutocompleteSuggestionsAsync(query, categories ?? Array.Empty<string>(), limit);
        return Ok(suggestions);
    }

    /// <summary>
    /// Find similar services to a given service
    /// </summary>
    /// <param name="serviceId">ID of the reference service</param>
    /// <param name="limit">Maximum number of similar services</param>
    /// <returns>List of similar services</returns>
    [HttpGet("similar/services/{serviceId}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<SearchResult<ServiceSearchDocument>>> GetSimilarServices(
        [FromRoute] string serviceId,
        [FromQuery] int limit = 10)
    {
        _logger.LogInformation("Finding similar services for: {ServiceId}", serviceId);

        var results = await _searchService.GetSimilarAsync<ServiceSearchDocument>(serviceId, limit);

        if (results.TotalCount == 0)
        {
            return NotFound($"No similar services found for service with ID: {serviceId}");
        }

        return Ok(results);
    }

    /// <summary>
    /// Find similar service providers to a given provider
    /// </summary>
    /// <param name="providerId">ID of the reference service provider</param>
    /// <param name="limit">Maximum number of similar providers</param>
    /// <returns>List of similar service providers</returns>
    [HttpGet("similar/providers/{providerId}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<SearchResult<ServiceProviderSearchDocument>>> GetSimilarProviders(
        [FromRoute] string providerId,
        [FromQuery] int limit = 10)
    {
        _logger.LogInformation("Finding similar providers for: {ProviderId}", providerId);

        var results = await _searchService.GetSimilarAsync<ServiceProviderSearchDocument>(providerId, limit);

        if (results.TotalCount == 0)
        {
            return NotFound($"No similar providers found for provider with ID: {providerId}");
        }

        return Ok(results);
    }

    /// <summary>
    /// Search across service providers with advanced filtering
    /// </summary>
    /// <param name="request">Advanced search request</param>
    /// <returns>Service provider search results with facets</returns>
    [HttpPost("providers/advanced")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<SearchResult<ServiceProviderSearchDocument>>> AdvancedSearchProviders(
        [FromBody] SearchRequest request)
    {
        _logger.LogInformation("Performing advanced provider search with query: {Query}", request.Query);

        var results = await _searchService.SearchAsync<ServiceProviderSearchDocument>(request);
        return Ok(results);
    }

    /// <summary>
    /// Search across universities with advanced filtering
    /// </summary>
    /// <param name="request">Advanced search request</param>
    /// <returns>University search results with facets</returns>
    [HttpPost("universities/advanced")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<SearchResult<UniversitySearchDocument>>> AdvancedSearchUniversities(
        [FromBody] SearchRequest request)
    {
        _logger.LogInformation("Performing advanced university search with query: {Query}", request.Query);

        var results = await _searchService.SearchAsync<UniversitySearchDocument>(request);
        return Ok(results);
    }

    /// <summary>
    /// Search across fields of study
    /// </summary>
    /// <param name="request">Advanced search request</param>
    /// <returns>Field of study search results with facets</returns>
    [HttpPost("fields-of-study/advanced")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<SearchResult<FieldOfStudySearchDocument>>> AdvancedSearchFieldsOfStudy(
        [FromBody] SearchRequest request)
    {
        _logger.LogInformation("Performing advanced field of study search with query: {Query}", request.Query);

        var results = await _searchService.SearchAsync<FieldOfStudySearchDocument>(request);
        return Ok(results);
    }

    /// <summary>
    /// Get search analytics for the given date range
    /// </summary>
    /// <param name="from">Start date</param>
    /// <param name="to">End date</param>
    /// <returns>Search analytics data</returns>
    [HttpGet("analytics")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<ActionResult<Dictionary<string, int>>> GetSearchAnalytics(
        [FromQuery] DateTime from,
        [FromQuery] DateTime to)
    {
        _logger.LogInformation("Retrieving search analytics from {From} to {To}", from, to);

        var analytics = await _searchService.GetSearchAnalyticsAsync(from, to);
        return Ok(analytics);
    }

    /// <summary>
    /// Check MeiliSearch health status
    /// </summary>
    /// <returns>Health status information</returns>
    [HttpGet("health")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status503ServiceUnavailable)]
    public async Task<ActionResult<object>> GetSearchHealth()
    {
        var isHealthy = await _searchService.IsHealthyAsync();
        var stats = await _searchService.GetStatsAsync();

        var healthData = new
        {
            IsHealthy = isHealthy,
            Service = "MeiliSearch",
            Stats = stats,
            Timestamp = DateTime.UtcNow
        };

        return isHealthy ? Ok(healthData) : StatusCode(503, healthData);
    }
}

public class GlobalSearchResults
{
    public SearchResult<ServiceSearchDocument> Services { get; set; } = new();
    public SearchResult<ServiceProviderSearchDocument> ServiceProviders { get; set; } = new();
    public SearchResult<UniversitySearchDocument> Universities { get; set; } = new();
}
