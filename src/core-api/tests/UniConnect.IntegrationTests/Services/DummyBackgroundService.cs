using Microsoft.Extensions.Hosting;

namespace UniConnect.IntegrationTests.Services;

/// <summary>
/// A dummy background service that does nothing - used to replace actual background services in tests
/// </summary>
public class DummyBackgroundService : BackgroundService
{
    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        // Do nothing
        return Task.CompletedTask;
    }
}
