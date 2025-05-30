using Microsoft.Extensions.DependencyInjection;
using NUnit.Framework;

namespace UniConnect.IntegrationTests;

public abstract class IntegrationTestBase
{
    protected CustomWebApplicationFactory<Program> Factory = null!;

    [OneTimeSetUp]
    public async Task BaseOneTimeSetUp()
    {
        Factory = new CustomWebApplicationFactory<Program>();
        await using var scope = Factory.Services.CreateAsyncScope();
        var databaseInitializer = scope.ServiceProvider.GetRequiredService<TestDatabaseInitializer>();
        await databaseInitializer.InitializeAsync();
    }

    [OneTimeTearDown]
    public void BaseOneTimeTearDown()
    {
        Factory?.Dispose();
    }
}
