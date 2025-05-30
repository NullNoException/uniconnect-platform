using UniConnect.Domain.Entities;

namespace UniConnect.Domain.Repositories;

public interface IProviderRepository
{
    Task<bool> ExistsByEmailAsync(string email);
    Task AddAsync(ServiceProvider provider);
    // Add more methods as needed for provider management
}
