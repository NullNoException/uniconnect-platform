using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using UniConnect.Infrastructure.Configuration;
using UniConnect.Infrastructure.Services;

namespace UniConnect.API.Services;

/// <summary>
/// Background service to initialize MeiliSearch indexes on application startup
/// </summary>
public class MeiliSearchIndexInitializer : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<MeiliSearchIndexInitializer> _logger;
    private readonly MeiliSearchSettings _settings;

    public MeiliSearchIndexInitializer(
        IServiceProvider serviceProvider,
        ILogger<MeiliSearchIndexInitializer> logger,
        IOptions<MeiliSearchSettings> settings)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
        _settings = settings.Value;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("Starting MeiliSearch index initialization...");

        try
        {
            // Wait for application to be ready
            await Task.Delay(5000, stoppingToken);

            using var scope = _serviceProvider.CreateScope();
            var searchService = scope.ServiceProvider.GetRequiredService<MeiliSearchService>();

            // Initialize indexes with proper configuration
            await searchService.InitializeIndexesAsync(stoppingToken);

            // Warm up cache with frequently accessed data
            await WarmUpSearchCache(searchService, stoppingToken);

            _logger.LogInformation("MeiliSearch index initialization completed successfully");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during MeiliSearch index initialization");
            throw;
        }
    }

    private async Task WarmUpSearchCache(MeiliSearchService searchService, CancellationToken cancellationToken)
    {
        try
        {
            _logger.LogInformation("Starting search cache warm-up...");

            // Pre-cache popular search terms
            var popularQueries = new[]
            {
                "programming", "design", "consultation", "tutoring", "repair",
                "university", "computer science", "engineering", "business"
            };

            var warmUpTasks = popularQueries.Select(async query =>
            {
                try
                {
                    // Perform searches to warm up cache
                    var request = new UniConnect.Application.Common.Models.SearchRequest
                    {
                        Query = query,
                        Limit = 10,
                        Offset = 0
                    };

                    // Search across different types
                    await searchService.SearchAsync<UniConnect.Infrastructure.Search.Models.ServiceSearchDocument>(request, cancellationToken);
                    await searchService.SearchAsync<UniConnect.Infrastructure.Search.Models.ServiceProviderSearchDocument>(request, cancellationToken);
                    await searchService.SearchAsync<UniConnect.Infrastructure.Search.Models.UniversitySearchDocument>(request, cancellationToken);

                    _logger.LogDebug("Warmed up cache for query: {Query}", query);
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Failed to warm up cache for query: {Query}", query);
                }
            });

            await Task.WhenAll(warmUpTasks);

            _logger.LogInformation("Search cache warm-up completed");
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Error during search cache warm-up");
        }
    }
}
