using Microsoft.EntityFrameworkCore;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;
using UniConnect.Infrastructure.Persistence;

namespace UniConnect.Infrastructure.Persistence.Repositories;

public class DocumentRepository : Repository<Document>, IDocumentRepository
{
    public DocumentRepository(ApplicationDbContext context) : base(context) { }

    public async Task<Document?> GetByFileNameAsync(string fileName, CancellationToken cancellationToken)
    {
        return await _dbSet.FirstOrDefaultAsync(d => d.FileName == fileName, cancellationToken);
    }
}
