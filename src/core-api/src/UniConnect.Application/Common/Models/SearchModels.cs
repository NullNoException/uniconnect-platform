namespace UniConnect.Application.Common.Models;

/// <summary>
/// Search request model with advanced filtering and sorting options
/// </summary>
public class SearchRequest
{
    /// <summary>
    /// Search query string
    /// </summary>
    public string Query { get; set; } = string.Empty;

    /// <summary>
    /// Filters to apply to the search
    /// </summary>
    public List<SearchFilter> Filters { get; set; } = new();

    /// <summary>
    /// Sorting options
    /// </summary>
    public List<SortField> Sort { get; set; } = new();

    /// <summary>
    /// Number of results to skip (pagination)
    /// </summary>
    public int Offset { get; set; } = 0;

    /// <summary>
    /// Maximum number of results to return
    /// </summary>
    public int Limit { get; set; } = 20;
}

/// <summary>
/// Search filter for faceted search
/// </summary>
public class SearchFilter
{
    /// <summary>
    /// Field name to filter on
    /// </summary>
    public string Field { get; set; } = string.Empty;

    /// <summary>
    /// Values to filter by
    /// </summary>
    public string[] Values { get; set; } = Array.Empty<string>();
}

/// <summary>
/// Sort field specification
/// </summary>
public class SortField
{
    /// <summary>
    /// Field name to sort by
    /// </summary>
    public string Field { get; set; } = string.Empty;

    /// <summary>
    /// Whether to sort in descending order
    /// </summary>
    public bool Descending { get; set; } = false;
}

/// <summary>
/// Search result with metadata and facets
/// </summary>
/// <typeparam name="T">Type of search result items</typeparam>
public class SearchResult<T> where T : class
{
    /// <summary>
    /// Search result items
    /// </summary>
    public List<T> Items { get; set; } = new();

    /// <summary>
    /// Total number of matching results
    /// </summary>
    public int TotalCount { get; set; }

    /// <summary>
    /// Current offset
    /// </summary>
    public int Offset { get; set; }

    /// <summary>
    /// Current limit
    /// </summary>
    public int Limit { get; set; }

    /// <summary>
    /// Original search query
    /// </summary>
    public string Query { get; set; } = string.Empty;

    /// <summary>
    /// Processing time in milliseconds
    /// </summary>
    public int ProcessingTimeMs { get; set; }

    /// <summary>
    /// Faceted search results for filtering
    /// </summary>
    public Dictionary<string, Dictionary<string, long>> Facets { get; set; } = new();

    /// <summary>
    /// Search suggestions for autocomplete
    /// </summary>
    public List<object> Suggestions { get; set; } = new();

    /// <summary>
    /// Whether there are more results available
    /// </summary>
    public bool HasNextPage => Offset + Limit < TotalCount;

    /// <summary>
    /// Whether there are previous results available
    /// </summary>
    public bool HasPreviousPage => Offset > 0;
}
