using System.Text;
using Microsoft.AspNetCore.Identity;
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

        // Database configuration - conditionally use in-memory DB for tests
        if (configuration.GetValue<bool>("UseInMemoryDatabase", false))
        {
            // This branch will be used in tests, but we won't add the DbContext here
            // as it will be added by the test framework
        }
        else
        {
            // Add PostgreSQL for normal operation
            services.AddDbContext<ApplicationDbContext>(options =>
                options.UseNpgsql(
                    configuration.GetConnectionString("DefaultConnection"),
                    b => b.MigrationsAssembly(typeof(ApplicationDbContext).Assembly.FullName)));
        }

        services.AddScoped<IApplicationDbContext>(provider => provider.GetRequiredService<ApplicationDbContext>());
        services.AddScoped<ApplicationDbContextInitialiser>();

        // Configure ASP.NET Core Identity
        services.AddIdentity<ApplicationUser, IdentityRole>(options =>
        {
            // Password settings
            options.Password.RequireDigit = true;
            options.Password.RequireLowercase = true;
            options.Password.RequireNonAlphanumeric = false;
            options.Password.RequireUppercase = true;
            options.Password.RequiredLength = 8;
            options.Password.RequiredUniqueChars = 1;

            // Lockout settings
            options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
            options.Lockout.MaxFailedAccessAttempts = 5;
            options.Lockout.AllowedForNewUsers = true;

            // User settings
            options.User.AllowedUserNameCharacters =
                "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._@+";
            options.User.RequireUniqueEmail = true;

            // SignIn settings
            options.SignIn.RequireConfirmedEmail = true;
            options.SignIn.RequireConfirmedPhoneNumber = false;
        })
        .AddEntityFrameworkStores<ApplicationDbContext>()
        .AddDefaultTokenProviders();

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
        services.AddScoped(typeof(IRepository<>), typeof(Repository<>));
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

        // Register background services
        services.AddHostedService<SemesterStatusUpdateService>();

        // Configure MinIO settings and storage services
        services.Configure<MinioSettings>(configuration.GetSection("MinioSettings"));


        // Configure Email settings
        services.Configure<EmailSettings>(configuration.GetSection("EmailSettings"));
        services.AddTransient<IEmailService, EmailService>();
        services.AddTransient<ISmsService, SmsService>();

        // Register MinioStorageService as implementation for both interfaces
        services.AddTransient<MinioStorageService>();
        services.AddTransient<IStorageService>(provider => provider.GetRequiredService<MinioStorageService>());
        services.AddTransient<IFileStorageService>(provider => provider.GetRequiredService<MinioStorageService>());

        services.AddTransient<ICacheService, EnhancedRedisCacheService>();
        services.AddTransient<IPaymentService, PaymentService>();

        // Configure MeiliSearch
        ConfigureMeiliSearch(services, configuration);

        // Configure OpenTelemetry with Jaeger only in non-test environments
        if (!configuration.GetValue<bool>("UseInMemoryDatabase", false) &&
            configuration.GetSection("JaegerSettings").GetValue<bool>("Enabled", true))
        {
            services.AddOpenTelemetryServices(configuration);
        }

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
