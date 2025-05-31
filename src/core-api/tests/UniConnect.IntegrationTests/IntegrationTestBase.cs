using Microsoft.Extensions.DependencyInjection;
using UniConnect.IntegrationTests.Services;
using Xunit;


namespace UniConnect.IntegrationTests;

public abstract class IntegrationTestBase : IAsyncLifetime
{
    protected CustomWebApplicationFactory<Program> Factory = null!;

    public async Task InitializeAsync()
    {
        Factory = new CustomWebApplicationFactory<Program>();
        await using var scope = Factory.Services.CreateAsyncScope();
        var databaseInitializer = scope.ServiceProvider.GetRequiredService<TestDatabaseInitializer>();
        await databaseInitializer.InitializeAsync();
    }

    public Task DisposeAsync()
    {
        Factory?.Dispose();
        return Task.CompletedTask;
    }
}
