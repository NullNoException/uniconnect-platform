using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Caching.StackExchangeRedis;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using StackExchange.Redis;
using Keycloak.AuthServices.Authentication;
using Keycloak.AuthServices.Authorization;
using Keycloak.AuthServices.Sdk;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Repositories;
using UniConnect.Domain.Services;
using UniConnect.Infrastructure.Configuration;
using UniConnect.Infrastructure.Identity;
using UniConnect.Infrastructure.Persistence;
using UniConnect.Infrastructure.Persistence.Interceptors;
using UniConnect.Infrastructure.Persistence.Repositories;
using UniConnect.Infrastructure.Services;
using UniConnect.Infrastructure.Telemetry;
using HealthChecks.Uris;

namespace UniConnect.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddScoped<AuditableEntitySaveChangesInterceptor>();

        // Database configuration
        services.AddDbContext<ApplicationDbContext>(options =>
            options.UseNpgsql(
                configuration.GetConnectionString("DefaultConnection"),
                b => b.MigrationsAssembly(typeof(ApplicationDbContext).Assembly.FullName)));

        services.AddScoped<IApplicationDbContext>(provider => provider.GetRequiredService<ApplicationDbContext>());
        services.AddScoped<ApplicationDbContextInitialiser>();

        // Configure Keycloak Authentication and Authorization
        services.AddKeycloakWebApiAuthentication(configuration);
        services.AddKeycloakAuthorization(configuration);

        // Add Keycloak Admin SDK
        services.AddKeycloakAdminHttpClient(configuration);

        // Register health checks for the database
        services.AddHealthChecks()
            .AddDbContextCheck<ApplicationDbContext>(
                name: "database",
                tags: new[] { "database", "sql", "postgresql" });

        // Register repositories
        services.AddScoped(typeof(Domain.Repositories.IRepository<>), typeof(Repository<>));
        services.AddScoped<IUnitOfWork, UnitOfWork>();

        // Configure Redis
        services.AddStackExchangeRedisCache(options =>
        {
            options.Configuration = configuration.GetSection("Redis")["Configuration"] ?? "localhost:6379";
            options.InstanceName = "UniConnect:";
        });

        // Add Redis connection multiplexer for advanced operations
        services.AddSingleton<IConnectionMultiplexer>(provider =>
        {
            var connectionString = configuration.GetSection("Redis")["Configuration"] ?? "localhost:6379";
            return ConnectionMultiplexer.Connect(connectionString);
        });

        // Register services
        services.AddTransient<IDateTime, DateTimeService>();
        services.AddTransient<IIdentityService, KeycloakAuthService>();
        services.AddTransient<ITokenService, TokenService>();

        // Configure Email settings
        services.Configure<EmailSettings>(configuration.GetSection("EmailSettings"));
        services.AddTransient<IEmailService, EmailService>();
        services.AddTransient<ISmsService, SmsService>();
        services.AddTransient<IStorageService, MinioStorageService>();
        services.AddTransient<ICacheService, EnhancedRedisCacheService>();
        services.AddTransient<IPaymentService, PaymentService>();

        // Configure MeiliSearch
        ConfigureMeiliSearch(services, configuration);

        // Configure OpenTelemetry with Jaeger
        services.AddOpenTelemetryServices(configuration);

        return services;
    }

    private static void ConfigureMeiliSearch(IServiceCollection services, IConfiguration configuration)
    {
        // Configure MeiliSearch settings
        services.Configure<MeiliSearchSettings>(configuration.GetSection(MeiliSearchSettings.SectionName));

        // Register MeiliSearch service
        services.AddScoped<MeiliSearchService>();
        services.AddScoped<ISearchService>(provider => provider.GetRequiredService<MeiliSearchService>());

        // Register health check for MeiliSearch
        var meilisearchUrl = configuration["MeilisearchSettings:Url"] ?? "http://meilisearch:7700";
        services.AddHealthChecks()
            .AddUrlGroup(
                new Uri($"{meilisearchUrl}/health"),
                name: "meilisearch",
                failureStatus: HealthStatus.Degraded,
                tags: new[] { "meilisearch", "search" });
    }
}
