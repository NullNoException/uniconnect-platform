using System.Collections.Generic;
using System.Threading.Tasks;

namespace UniConnect.Application.Common.Interfaces;

public interface ISearchService
{
    Task<bool> CreateIndexAsync<T>() where T : class;
    Task<bool> IndexDocumentAsync<T>(T document, string id) where T : class;
    Task<bool> BulkIndexAsync<T>(IEnumerable<T> documents) where T : class;
    Task<bool> DeleteDocumentAsync<T>(string id) where T : class;
    Task<bool> UpdateDocumentAsync<T>(T document, string id) where T : class;
    Task<T?> GetDocumentAsync<T>(string id) where T : class;
    Task<IEnumerable<T>> SearchAsync<T>(string searchTerm, int page = 1, int pageSize = 10) where T : class;
}
