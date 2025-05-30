using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;

namespace UniConnect.Infrastructure.Services;

public class SemesterStatusUpdateService : BackgroundService
{
    private readonly ILogger<SemesterStatusUpdateService> _logger;
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly TimeSpan _checkInterval = TimeSpan.FromHours(12); // Check twice a day

    public SemesterStatusUpdateService(
        ILogger<SemesterStatusUpdateService> logger,
        IServiceScopeFactory scopeFactory)
    {
        _logger = logger;
        _scopeFactory = scopeFactory;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("Semester Status Update Service is starting");

        while (!stoppingToken.IsCancellationRequested)
        {
            _logger.LogInformation("Semester Status Update Service is running at: {time}", DateTimeOffset.Now);

            try
            {
                await UpdateSemesterStatusesAsync(stoppingToken);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred while updating semester statuses");
            }

            // Wait for the next check interval
            await Task.Delay(_checkInterval, stoppingToken);
        }

        _logger.LogInformation("Semester Status Update Service is stopping");
    }

    private async Task UpdateSemesterStatusesAsync(CancellationToken stoppingToken)
    {
        using var scope = _scopeFactory.CreateScope();
        var semesterStatusService = scope.ServiceProvider.GetRequiredService<ISemesterStatusService>();
        await semesterStatusService.UpdateSemesterStatusesAsync(stoppingToken);
    }
}
