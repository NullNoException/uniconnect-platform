using UniConnect.Domain.Entities;

namespace UniConnect.Domain.Repositories;

public interface IDocumentRepository : IRepository<Document>
{
    // Add specific methods for documents if needed, beyond generic IRepository<T>
    Task<Document?> GetByFileNameAsync(string fileName, CancellationToken cancellationToken);
}
