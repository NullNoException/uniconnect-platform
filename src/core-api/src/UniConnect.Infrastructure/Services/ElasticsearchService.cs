using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Nest;
using System.Collections.Generic;
using System.Threading.Tasks;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using DomainServiceProvider = UniConnect.Domain.Entities.ServiceProvider;

namespace UniConnect.Infrastructure.Services;

public class ElasticsearchService : ISearchService
{
    private readonly IElasticClient _elasticClient;
    private readonly ILogger<ElasticsearchService> _logger;

    public ElasticsearchService(IElasticClient elasticClient, ILogger<ElasticsearchService> logger)
    {
        _elasticClient = elasticClient;
        _logger = logger;
    }

    public async Task<bool> IndexDocumentAsync<T>(T document, string id) where T : class
    {
        try
        {
            var indexName = GetIndexName<T>();
            var response = await _elasticClient.IndexDocumentAsync(document);

            if (!response.IsValid)
            {
                _logger.LogError("Failed to index document {Id} in index {IndexName}. Error: {Error}",
                    id, indexName, response.DebugInformation);
            }

            return response.IsValid;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error occurred while indexing document {Id}", id);
            return false;
        }
    }

    public async Task<bool> BulkIndexAsync<T>(IEnumerable<T> documents) where T : class
    {
        try
        {
            var indexName = GetIndexName<T>();
            var response = await _elasticClient.IndexManyAsync(documents, indexName);

            if (!response.IsValid)
            {
                _logger.LogError("Failed to bulk index documents in index {IndexName}. Error: {Error}",
                    indexName, response.DebugInformation);
            }

            return response.IsValid;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error occurred while bulk indexing documents");
            return false;
        }
    }

    public async Task<bool> DeleteDocumentAsync<T>(string id) where T : class
    {
        try
        {
            var indexName = GetIndexName<T>();
            var response = await _elasticClient.DeleteAsync(new DeleteRequest(indexName, id));

            if (!response.IsValid)
            {
                _logger.LogError("Failed to delete document {Id} from index {IndexName}. Error: {Error}",
                    id, indexName, response.DebugInformation);
            }

            return response.IsValid;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error occurred while deleting document {Id}", id);
            return false;
        }
    }

    public async Task<bool> UpdateDocumentAsync<T>(T document, string id) where T : class
    {
        try
        {
            var indexName = GetIndexName<T>();
            var response = await _elasticClient.UpdateAsync<T>(id, u => u.Doc(document).Index(indexName));

            if (!response.IsValid)
            {
                _logger.LogError("Failed to update document {Id} in index {IndexName}. Error: {Error}",
                    id, indexName, response.DebugInformation);
            }

            return response.IsValid;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error occurred while updating document {Id}", id);
            return false;
        }
    }

    public async Task<T?> GetDocumentAsync<T>(string id) where T : class
    {
        try
        {
            var indexName = GetIndexName<T>();
            var response = await _elasticClient.GetAsync<T>(id, g => g.Index(indexName));

            if (!response.IsValid)
            {
                _logger.LogError("Failed to get document {Id} from index {IndexName}. Error: {Error}",
                    id, indexName, response.DebugInformation);
                return null;
            }

            return response.Source;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error occurred while getting document {Id}", id);
            return null;
        }
    }

    public async Task<IEnumerable<T>> SearchAsync<T>(string searchTerm, int page = 1, int pageSize = 10) where T : class
    {
        try
        {
            var indexName = GetIndexName<T>();

            var searchRequest = new SearchRequest<T>(indexName)
            {
                From = (page - 1) * pageSize,
                Size = pageSize,
                Query = new MultiMatchQuery
                {
                    Fields = GetSearchableFields<T>(),
                    Query = searchTerm,
                    Fuzziness = Fuzziness.Auto
                }
            };

            var response = await _elasticClient.SearchAsync<T>(searchRequest);

            if (!response.IsValid)
            {
                _logger.LogError("Failed to search for term {SearchTerm} in index {IndexName}. Error: {Error}",
                    searchTerm, indexName, response.DebugInformation);
                return Enumerable.Empty<T>();
            }

            return response.Documents;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error occurred while searching for term {SearchTerm}", searchTerm);
            return Enumerable.Empty<T>();
        }
    }

    private string GetIndexName<T>() where T : class
    {
        return typeof(T).Name.ToLowerInvariant();
    }

    private string[] GetSearchableFields<T>() where T : class
    {
        // Define searchable fields for each entity
        if (typeof(T) == typeof(Service))
        {
            return new[] { "name^3", "description^2", "requirements" }; // Boosting more important fields
        }
        else if (typeof(T) == typeof(DomainServiceProvider))
        {
            return new[] { "name^3", "description^2", "businessFields" };
        }
        else if (typeof(T) == typeof(University))
        {
            return new[] { "name^3", "description", "location" };
        }
        else
        {
            // Default searchable fields
            return new[] { "name", "description" };
        }
    }

    public async Task<bool> CreateIndexAsync<T>() where T : class
    {
        var indexName = GetIndexName<T>();

        if (!(await _elasticClient.Indices.ExistsAsync(indexName)).Exists)
        {
            var createIndexResponse = await _elasticClient.Indices.CreateAsync(indexName, c => c
                .Settings(s => s
                    .Analysis(a => a
                        .Analyzers(an => an
                            .Standard("standard_analyzer", sa => sa
                                .StopWords("_english_")
                            )
                        )
                    )
                )
                .Map<T>(m => ConfigureMapping<T>(m))
            );

            if (!createIndexResponse.IsValid)
            {
                _logger.LogError("Failed to create index {IndexName}. Error: {Error}",
                    indexName, createIndexResponse.DebugInformation);
                return false;
            }
        }

        return true;
    }

    private TypeMappingDescriptor<T> ConfigureMapping<T>(TypeMappingDescriptor<T> mapping) where T : class
    {
        if (typeof(T) == typeof(Service))
        {
            return mapping
                .Properties(p => p
                    .Text(t => t.Name("name").Analyzer("standard_analyzer"))
                    .Text(t => t.Name("description").Analyzer("standard_analyzer"))
                    .Text(t => t.Name("requirements").Analyzer("standard_analyzer"))
                    .Keyword(k => k.Name("serviceProviderId"))
                    .Keyword(k => k.Name("categoryId"))
                    .Date(d => d.Name("createdDate"))
                    .Boolean(b => b.Name("isActive"))
                );
        }
        else if (typeof(T) == typeof(DomainServiceProvider))
        {
            return mapping
                .Properties(p => p
                    .Text(t => t.Name("name").Analyzer("standard_analyzer"))
                    .Text(t => t.Name("description").Analyzer("standard_analyzer"))
                    .Text(t => t.Name("businessFields").Analyzer("standard_analyzer"))
                    .Keyword(k => k.Name("location"))
                    .Boolean(b => b.Name("isVerified"))
                );
        }

        // Default mapping
        return mapping;
    }
}
