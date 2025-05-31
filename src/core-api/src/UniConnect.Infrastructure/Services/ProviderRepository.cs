using Microsoft.EntityFrameworkCore;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;
using UniConnect.Infrastructure.Persistence;

namespace UniConnect.Infrastructure.Services;

public class ProviderRepository : IProviderRepository
{
    private readonly ApplicationDbContext _dbContext;
    public ProviderRepository(ApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<bool> ExistsByEmailAsync(string email)
    {
        return await _dbContext.ServiceProviders
            .Include(p => p.User)
            .AnyAsync(p => p.User.Email == email);
    }

    public async Task AddAsync(ServiceProvider provider)
    {
        await _dbContext.ServiceProviders.AddAsync(provider);
    }
}
