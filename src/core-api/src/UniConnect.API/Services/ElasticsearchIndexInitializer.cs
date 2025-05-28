using System.Diagnostics;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Infrastructure.Persistence;
using DomainServiceProvider = UniConnect.Domain.Entities.ServiceProvider;

namespace UniConnect.API.Services;

public class ElasticsearchIndexInitializer : BackgroundService
{
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly ILogger<ElasticsearchIndexInitializer> _logger;

    public ElasticsearchIndexInitializer(
        IServiceScopeFactory scopeFactory,
        ILogger<ElasticsearchIndexInitializer> logger)
    {
        _scopeFactory = scopeFactory;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        // Wait some time for the application to fully start up
        await Task.Delay(TimeSpan.FromSeconds(10), stoppingToken);

        _logger.LogInformation("Starting Elasticsearch index initialization");

        try
        {
            using var scope = _scopeFactory.CreateScope();
            var searchService = scope.ServiceProvider.GetRequiredService<ISearchService>();
            var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();

            var stopwatch = Stopwatch.StartNew();

            // Create indexes for our entity types
            await searchService.CreateIndexAsync<Service>();
            await searchService.CreateIndexAsync<DomainServiceProvider>();
            await searchService.CreateIndexAsync<University>();
            await searchService.CreateIndexAsync<FieldOfStudy>();
            await searchService.CreateIndexAsync<ServiceCategory>();

            _logger.LogInformation("Created Elasticsearch indexes in {ElapsedMs}ms", stopwatch.ElapsedMilliseconds);

            // Index existing data
            await IndexEntities<Service>(dbContext, searchService, stoppingToken);
            await IndexEntities<DomainServiceProvider>(dbContext, searchService, stoppingToken);
            await IndexEntities<University>(dbContext, searchService, stoppingToken);
            await IndexEntities<ServiceCategory>(dbContext, searchService, stoppingToken);
            await IndexEntities<FieldOfStudy>(dbContext, searchService, stoppingToken);

            _logger.LogInformation("Finished indexing all entities in {ElapsedMs}ms", stopwatch.ElapsedMilliseconds);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error occurred during Elasticsearch index initialization");
        }
    }

    private async Task IndexEntities<T>(ApplicationDbContext dbContext, ISearchService searchService,
        CancellationToken stoppingToken) where T : class
    {
        try
        {
            var entityName = typeof(T).Name;
            _logger.LogInformation("Starting indexing of {EntityType}", entityName);

            var entities = await dbContext.Set<T>().ToListAsync(stoppingToken);
            if (entities.Any())
            {
                var success = await searchService.BulkIndexAsync(entities);
                _logger.LogInformation("Indexed {Count} {EntityType} entities. Success: {Success}",
                    entities.Count, entityName, success);
            }
            else
            {
                _logger.LogInformation("No {EntityType} entities to index", entityName);
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error indexing entities of type {EntityType}", typeof(T).Name);
        }
    }
}
