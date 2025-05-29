using System.Collections.Generic;
using System.Threading.Tasks;
using System.Threading;
using UniConnect.Application.Common.Models;

namespace UniConnect.Application.Common.Interfaces;

public interface ISearchService
{
    // Index management
    Task InitializeIndexesAsync(CancellationToken cancellationToken = default);

    // Document indexing
    Task IndexServiceAsync(object service, CancellationToken cancellationToken = default);
    Task IndexServiceProviderAsync(object provider, CancellationToken cancellationToken = default);
    Task IndexUniversityAsync(object university, CancellationToken cancellationToken = default);
    Task IndexFieldOfStudyAsync(object field, CancellationToken cancellationToken = default);
    Task BulkIndexAsync<T>(string indexName, IEnumerable<T> documents, CancellationToken cancellationToken = default) where T : class;

    // Search operations
    Task<SearchResult<T>> SearchAsync<T>(SearchRequest request, CancellationToken cancellationToken = default) where T : class;
    Task<IEnumerable<object>> GetAutocompleteSuggestionsAsync(string query, string[]? categories = null, int limit = 10, CancellationToken cancellationToken = default);
    Task<SearchResult<T>> GetSimilarAsync<T>(string documentId, int limit = 10, CancellationToken cancellationToken = default) where T : class;

    // Document removal
    Task RemoveDocumentAsync(string indexName, string documentId, CancellationToken cancellationToken = default);
    Task RemoveDocumentsAsync(string indexName, IEnumerable<string> documentIds, CancellationToken cancellationToken = default);

    // Multi-language support
    Task<SearchResult<T>> SearchWithLanguageAsync<T>(SearchRequest request, string language, CancellationToken cancellationToken = default) where T : class;
    Task SetIndexLanguageAsync(string indexName, string language, CancellationToken cancellationToken = default);

    // Analytics and monitoring
    Task<Dictionary<string, int>> GetSearchAnalyticsAsync(DateTime from, DateTime to, CancellationToken cancellationToken = default);
    Task<bool> IsHealthyAsync(CancellationToken cancellationToken = default);
    Task<Dictionary<string, object>> GetStatsAsync(CancellationToken cancellationToken = default);
}
