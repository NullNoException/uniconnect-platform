using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using UniConnect.Domain.Entities;
using UniConnect.Infrastructure.Persistence;
using UniConnect.Infrastructure.Services;
using UniConnect.UnitTests.Infrastructure;
using Xunit;

namespace UniConnect.UnitTests.Infrastructure
{
    public class ProviderRepositoryTests
    {
        private static ApplicationDbContext GetDbContext(string dbName)
        {
            var options = new DbContextOptionsBuilder<ApplicationDbContext>()
                .UseInMemoryDatabase(databaseName: dbName)
                .Options;
            var interceptor = TestAuditableEntitySaveChangesInterceptorFactory.Create();
            return new ApplicationDbContext(options, interceptor);
        }

        [Fact]
        public async Task ExistsByEmailAsync_ReturnsTrue_WhenProviderWithEmailExists()
        {
            // Arrange
            var dbContext = GetDbContext("ExistsByEmailAsync_True");
            var user = new User { Email = "test@example.com" };
            var provider = new ServiceProvider { User = user };
            dbContext.ServiceProviders.Add(provider);
            await dbContext.SaveChangesAsync();
            var repo = new ProviderRepository(dbContext);

            // Act
            var exists = await repo.ExistsByEmailAsync("test@example.com");

            // Assert
            Assert.True(exists);
        }

        [Fact]
        public async Task ExistsByEmailAsync_ReturnsFalse_WhenProviderWithEmailDoesNotExist()
        {
            // Arrange
            var dbContext = GetDbContext("ExistsByEmailAsync_False");
            var repo = new ProviderRepository(dbContext);

            // Act
            var exists = await repo.ExistsByEmailAsync("notfound@example.com");

            // Assert
            Assert.False(exists);
        }

        [Fact]
        public async Task AddAsync_AddsProviderToDatabase()
        {
            // Arrange
            var dbContext = GetDbContext("AddAsync");
            var repo = new ProviderRepository(dbContext);
            var user = new User { Email = "add@example.com" };
            var provider = new ServiceProvider { User = user };

            // Act
            await repo.AddAsync(provider);
            await dbContext.SaveChangesAsync();

            // Assert
            var exists = await dbContext.ServiceProviders.Include(p => p.User).AnyAsync(p => p.User.Email == "add@example.com");
            Assert.True(exists);
        }
    }
}
