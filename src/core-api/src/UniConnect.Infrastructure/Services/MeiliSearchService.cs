using Meilisearch;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Caching.Distributed;
using System.Text.Json;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Models;
using UniConnect.Infrastructure.Configuration;

namespace UniConnect.Infrastructure.Services;

/// <summary>
/// MeiliSearch service implementation with advanced search features
/// </summary>
public class MeiliSearchService : ISearchService
{
    private readonly MeilisearchClient _client;
    private readonly IDistributedCache _cache;
    private readonly ILogger<MeiliSearchService> _logger;
    private readonly MeiliSearchSettings _settings;

    // Index names
    private const string ServicesIndex = "services";
    private const string ServiceProvidersIndex = "service_providers";
    private const string UniversitiesIndex = "universities";
    private const string FieldsOfStudyIndex = "fields_of_study";

    public MeiliSearchService(
        IOptions<MeiliSearchSettings> settings,
        IDistributedCache cache,
        ILogger<MeiliSearchService> logger)
    {
        _settings = settings.Value;
        _cache = cache;
        _logger = logger;
        _client = new MeilisearchClient(_settings.Url, _settings.MasterKey);
    }

    public async Task InitializeIndexesAsync(CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Initializing MeiliSearch indexes...");
        try
        {
            // Create indexes if they don't exist
            await CreateIndexIfNotExistsAsync(ServicesIndex, "id", cancellationToken);
            await CreateIndexIfNotExistsAsync(ServiceProvidersIndex, "id", cancellationToken);
            await CreateIndexIfNotExistsAsync(UniversitiesIndex, "id", cancellationToken);
            await CreateIndexIfNotExistsAsync(FieldsOfStudyIndex, "id", cancellationToken);

            _logger.LogInformation("MeiliSearch indexes initialized successfully");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to initialize MeiliSearch indexes");
            throw;
        }
    }

    private async Task CreateIndexIfNotExistsAsync(string indexName, string primaryKey, CancellationToken cancellationToken)
    {
        try
        {
            var index = _client.Index(indexName);
            await index.FetchInfoAsync(cancellationToken);
            _logger.LogInformation("Index {IndexName} already exists", indexName);
        }
        catch
        {
            // Index doesn't exist, create it
            var task = await _client.CreateIndexAsync(indexName, primaryKey, cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);
            _logger.LogInformation("Created index {IndexName} with primary key {PrimaryKey}", indexName, primaryKey);

            // Configure index settings
            await ConfigureIndexAsync(indexName, cancellationToken);
        }
    }

    private async Task ConfigureIndexAsync(string indexName, CancellationToken cancellationToken)
    {
        var index = _client.Index(indexName);

        // Configure searchable attributes
        var searchableAttributes = GetSearchableAttributes(indexName);
        if (searchableAttributes.Any())
        {
            var task = await index.UpdateSearchableAttributesAsync(searchableAttributes, cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);
        }

        // Configure filterable attributes
        var filterableAttributes = GetFilterableAttributes(indexName);
        if (filterableAttributes.Any())
        {
            var task = await index.UpdateFilterableAttributesAsync(filterableAttributes, cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);
        }

        // Configure sortable attributes
        var sortableAttributes = GetSortableAttributes(indexName);
        if (sortableAttributes.Any())
        {
            var task = await index.UpdateSortableAttributesAsync(sortableAttributes, cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);
        }

        // Configure ranking rules
        var rankingRules = GetRankingRules(indexName);
        if (rankingRules.Any())
        {
            var task = await index.UpdateRankingRulesAsync(rankingRules, cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);
        }

        // Configure typo tolerance
        var typoTolerance = new TypoTolerance
        {
            Enabled = _settings.TypoTolerance.Enabled,
            MinWordSizeForTypos = new Meilisearch.TypoTolerance.TypoSize
            {
                OneTypo = _settings.TypoTolerance.MinWordSizeOneTypo,
                TwoTypos = _settings.TypoTolerance.MinWordSizeTwoTypos
            }
        };
        var typoTask = await index.UpdateTypoToleranceAsync(typoTolerance, cancellationToken);
        await _client.WaitForTaskAsync(typoTask.TaskUid, cancellationToken: cancellationToken);
    }

    private string[] GetSearchableAttributes(string indexName) => indexName switch
    {
        ServicesIndex => ["name", "description", "requirements", "category"],
        ServiceProvidersIndex => ["name", "description", "businessFields", "location"],
        UniversitiesIndex => ["name", "description", "location", "country"],
        FieldsOfStudyIndex => ["name", "description", "category"],
        _ => Array.Empty<string>()
    };

    private string[] GetFilterableAttributes(string indexName) => indexName switch
    {
        ServicesIndex => ["category", "isActive", "createdAt", "businessScore"],
        ServiceProvidersIndex => ["businessFields", "location", "isVerified", "rating"],
        UniversitiesIndex => ["country", "location", "isActive"],
        FieldsOfStudyIndex => ["category", "level"],
        _ => Array.Empty<string>()
    };

    private string[] GetSortableAttributes(string indexName) => indexName switch
    {
        ServicesIndex => ["businessScore", "createdAt", "name"],
        ServiceProvidersIndex => ["rating", "createdAt", "name"],
        UniversitiesIndex => ["name", "createdAt"],
        FieldsOfStudyIndex => ["name", "level"],
        _ => Array.Empty<string>()
    };

    private string[] GetRankingRules(string indexName) => indexName switch
    {
        ServicesIndex => ["words", "typo", "proximity", "attribute", "sort", "exactness", "businessScore:desc"],
        ServiceProvidersIndex => ["words", "typo", "proximity", "attribute", "sort", "exactness", "rating:desc"],
        _ => ["words", "typo", "proximity", "attribute", "sort", "exactness"]
    };

    public async Task IndexServiceAsync(object service, CancellationToken cancellationToken = default)
    {
        await IndexDocumentAsync(ServicesIndex, service, cancellationToken);
    }

    public async Task IndexServiceProviderAsync(object provider, CancellationToken cancellationToken = default)
    {
        await IndexDocumentAsync(ServiceProvidersIndex, provider, cancellationToken);
    }

    public async Task IndexUniversityAsync(object university, CancellationToken cancellationToken = default)
    {
        await IndexDocumentAsync(UniversitiesIndex, university, cancellationToken);
    }

    public async Task IndexFieldOfStudyAsync(object field, CancellationToken cancellationToken = default)
    {
        await IndexDocumentAsync(FieldsOfStudyIndex, field, cancellationToken);
    }

    private async Task IndexDocumentAsync(string indexName, object document, CancellationToken cancellationToken)
    {
        try
        {
            var index = _client.Index(indexName);
            var task = await index.AddDocumentsAsync(new[] { document }, cancellationToken: cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);

            _logger.LogDebug("Indexed document in {IndexName}", indexName);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to index document in {IndexName}", indexName);
            throw;
        }
    }

    public async Task BulkIndexAsync<T>(string indexName, IEnumerable<T> documents, CancellationToken cancellationToken = default) where T : class
    {
        try
        {
            var index = _client.Index(indexName);
            var task = await index.AddDocumentsAsync(documents, cancellationToken: cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);

            _logger.LogInformation("Bulk indexed {Count} documents in {IndexName}", documents.Count(), indexName);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to bulk index documents in {IndexName}", indexName);
            throw;
        }
    }

    public async Task<UniConnect.Application.Common.Models.SearchResult<T>> SearchAsync<T>(SearchRequest request, CancellationToken cancellationToken = default) where T : class
    {
        var cacheKey = $"search:{JsonSerializer.Serialize(request)}";

        // Try to get from cache first
        var cachedResult = await GetFromCacheAsync<UniConnect.Application.Common.Models.SearchResult<T>>(cacheKey, cancellationToken);
        if (cachedResult != null)
        {
            return cachedResult;
        }

        try
        {
            var indexName = GetIndexNameForType<T>();
            var index = _client.Index(indexName);

            var searchQuery = new SearchQuery
            {
                Q = request.Query,
                Offset = request.Offset,
                Limit = request.Limit,
                Filter = BuildFilterString(request.Filters),
                Sort = request.Sort.Select(s => s.Descending ? $"{s.Field}:desc" : $"{s.Field}:asc").ToArray()
            };

            var meilisearchResult = await index.SearchAsync<T>(request.Query ?? string.Empty, searchQuery);

            var result = new UniConnect.Application.Common.Models.SearchResult<T>
            {
                Items = meilisearchResult.Hits?.ToList() ?? new List<T>(),
                TotalCount = meilisearchResult.Hits?.Count() ?? 0,
                Offset = request.Offset,
                Limit = request.Limit,
                Query = request.Query ?? string.Empty,
                ProcessingTimeMs = (int)meilisearchResult.ProcessingTimeMs
            };

            // Cache the result
            await SetCacheAsync(cacheKey, result, TimeSpan.FromMinutes(_settings.CacheSettings.SearchResultTtlMinutes), cancellationToken);

            return result;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Search failed for query: {Query}", request.Query);
            throw;
        }
    }

    public async Task<UniConnect.Application.Common.Models.SearchResult<T>> SearchWithLanguageAsync<T>(SearchRequest request, string language, CancellationToken cancellationToken = default) where T : class
    {
        // For now, delegate to regular search
        // TODO: Implement language-specific search logic
        return await SearchAsync<T>(request, cancellationToken);
    }

    public async Task<IEnumerable<object>> GetAutocompleteSuggestionsAsync(string query, string[]? categories = null, int limit = 10, CancellationToken cancellationToken = default)
    {
        var suggestions = new List<object>();

        try
        {
            // Search across all indexes for suggestions
            var indexes = new[] { ServicesIndex, ServiceProvidersIndex, UniversitiesIndex, FieldsOfStudyIndex };

            foreach (var indexName in indexes)
            {
                var index = _client.Index(indexName);
                var searchQuery = new SearchQuery
                {
                    Q = query,
                    Limit = limit / indexes.Length + 1,
                    AttributesToRetrieve = new[] { "id", "name" }
                };

                var result = await index.SearchAsync<object>(query, searchQuery);
                suggestions.AddRange(result.Hits ?? Enumerable.Empty<object>());
            }

            return suggestions.Take(limit);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get autocomplete suggestions for query: {Query}", query);
            return Enumerable.Empty<object>();
        }
    }

    public async Task<UniConnect.Application.Common.Models.SearchResult<T>> GetSimilarAsync<T>(string documentId, int limit = 10, CancellationToken cancellationToken = default) where T : class
    {
        // For now, return empty result as similarity search needs special implementation
        return await Task.FromResult(new UniConnect.Application.Common.Models.SearchResult<T>
        {
            Items = new List<T>(),
            TotalCount = 0,
            Offset = 0,
            Limit = limit,
            Query = string.Empty,
            ProcessingTimeMs = 0
        });
    }

    public async Task RemoveDocumentAsync(string indexName, string documentId, CancellationToken cancellationToken = default)
    {
        try
        {
            var index = _client.Index(indexName);
            var task = await index.DeleteDocumentsAsync(new[] { documentId }, cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);

            _logger.LogDebug("Removed document {DocumentId} from index {IndexName}", documentId, indexName);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to remove document {DocumentId} from index {IndexName}", documentId, indexName);
            throw;
        }
    }

    public async Task RemoveDocumentsAsync(string indexName, IEnumerable<string> documentIds, CancellationToken cancellationToken = default)
    {
        try
        {
            var index = _client.Index(indexName);
            var task = await index.DeleteDocumentsAsync(documentIds, cancellationToken);
            await _client.WaitForTaskAsync(task.TaskUid, cancellationToken: cancellationToken);

            _logger.LogDebug("Removed {Count} documents from index {IndexName}", documentIds.Count(), indexName);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to remove documents from index {IndexName}", indexName);
            throw;
        }
    }

    public Task SetIndexLanguageAsync(string indexName, string language, CancellationToken cancellationToken = default)
    {
        try
        {
            // Note: MeiliSearch handles multi-language automatically
            // This method is for future language-specific configurations
            _logger.LogDebug("Language setting not required for MeiliSearch - automatic multi-language support");
            return Task.CompletedTask;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to set language for index {IndexName}", indexName);
            throw;
        }
    }

    public Task<Dictionary<string, int>> GetSearchAnalyticsAsync(DateTime from, DateTime to, CancellationToken cancellationToken = default)
    {
        try
        {
            // MeiliSearch doesn't have built-in analytics API
            // Return empty dictionary for now
            return Task.FromResult(new Dictionary<string, int>());
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get search analytics");
            throw;
        }
    }

    public async Task<bool> IsHealthyAsync(CancellationToken cancellationToken = default)
    {
        try
        {
            var health = await _client.HealthAsync(cancellationToken);
            return health.Status == "available";
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Health check failed");
            return false;
        }
    }

    public async Task<Dictionary<string, object>> GetStatsAsync(CancellationToken cancellationToken = default)
    {
        try
        {
            var stats = await _client.GetStatsAsync(cancellationToken);
            return new Dictionary<string, object>
            {
                ["indexes"] = stats.Indexes?.Count ?? 0,
                ["databaseSize"] = stats.DatabaseSize,
                ["lastUpdate"] = stats.LastUpdate?.ToString() ?? string.Empty
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get stats");
            return new Dictionary<string, object>();
        }
    }

    private string GetIndexNameForType<T>() => typeof(T).Name.ToLowerInvariant() switch
    {
        var name when name.Contains("service") && !name.Contains("provider") => ServicesIndex,
        var name when name.Contains("provider") => ServiceProvidersIndex,
        var name when name.Contains("university") => UniversitiesIndex,
        var name when name.Contains("field") => FieldsOfStudyIndex,
        _ => "default"
    };

    private string? BuildFilterString(List<SearchFilter> filters)
    {
        if (!filters.Any()) return null;

        var filterParts = new List<string>();
        foreach (var filter in filters)
        {
            if (filter.Values.Any())
            {
                var values = string.Join(" OR ", filter.Values.Select(v => $"{filter.Field} = '{v}'"));
                filterParts.Add($"({values})");
            }
        }

        return filterParts.Any() ? string.Join(" AND ", filterParts) : null;
    }

    private async Task<T?> GetFromCacheAsync<T>(string key, CancellationToken cancellationToken) where T : class
    {
        try
        {
            var cached = await _cache.GetStringAsync(key, cancellationToken);
            return cached != null ? JsonSerializer.Deserialize<T>(cached) : null;
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to get item from cache with key: {Key}", key);
            return null;
        }
    }

    private async Task SetCacheAsync<T>(string key, T value, TimeSpan expiry, CancellationToken cancellationToken) where T : class
    {
        try
        {
            var options = new DistributedCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = expiry
            };
            var serialized = JsonSerializer.Serialize(value);
            await _cache.SetStringAsync(key, serialized, options, cancellationToken);
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to set item in cache with key: {Key}", key);
        }
    }
}