using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Infrastructure.Identity;
using UniConnect.Infrastructure.Persistence;
using UniConnect.IntegrationTests.Services;
using Xunit;

namespace UniConnect.IntegrationTests;

/// <summary>
/// Base class for integration tests providing common test infrastructure
/// </summary>
public abstract class IntegrationTest : IClassFixture<CustomWebApplicationFactory<Program>>, IAsyncLifetime, IDisposable
{
    protected readonly CustomWebApplicationFactory<Program> _factory;
    protected readonly HttpClient _httpClient;
    protected readonly IServiceScope _scope;
    private bool _disposed;

    protected IntegrationTest()
    {
        _factory = new CustomWebApplicationFactory<Program>();
        _httpClient = _factory.CreateClient();
        _scope = _factory.Services.CreateScope();
    }

    /// <summary>
    /// Initialize the test database before tests run
    /// </summary>
    public virtual async Task InitializeAsync()
    {
        // Initialize database with schema
        var initializer = _scope.ServiceProvider.GetRequiredService<TestDatabaseInitializer>();
        await initializer.InitializeAsync();
    }

    /// <summary>
    /// Cleanup after tests run
    /// </summary>
    public Task DisposeAsync()
    {
        // No async cleanup needed since Dispose is called
        return Task.CompletedTask;
    }

    /// <summary>
    /// Gets the database context for test data setup and verification
    /// </summary>
    protected ApplicationDbContext GetDbContext()
    {
        var scope = _factory.Services.CreateScope();
        return scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    }

    /// <summary>
    /// Gets a service from the dependency injection container
    /// </summary>
    protected T GetService<T>() where T : notnull
    {
        return _scope.ServiceProvider.GetRequiredService<T>();
    }

    protected virtual void Dispose(bool disposing)
    {
        if (!_disposed && disposing)
        {
            _scope?.Dispose();
            _httpClient?.Dispose();
            _factory?.Dispose();
            _disposed = true;
        }
    }

    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
}

public class Testing
{
    [Fact]
    public void HelloWorldTest()
    {
        Assert.Equal(1, 1);
    }
}