using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Caching.StackExchangeRedis;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.IdentityModel.Tokens;
using Nest;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Repositories;
using UniConnect.Domain.Services;
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

        // Configure ASP.NET Core Identity
        services.AddIdentity<ApplicationUser, IdentityRole>(options =>
            {
                options.Password.RequiredLength = 8;
                options.Password.RequireNonAlphanumeric = true;
                options.Password.RequireUppercase = true;
                options.Password.RequireLowercase = true;
                options.Password.RequireDigit = true;
                options.User.RequireUniqueEmail = true;
            })
            .AddEntityFrameworkStores<ApplicationDbContext>()
            .AddDefaultTokenProviders();

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

        // Register services
        services.AddTransient<IDateTime, DateTimeService>();
        services.AddTransient<IIdentityService, KeycloakAuthService>();
        services.AddTransient<ITokenService, TokenService>();

        // Configure Email settings
        services.Configure<EmailSettings>(configuration.GetSection("EmailSettings"));
        services.AddTransient<IEmailService, EmailService>();
        services.AddTransient<ISmsService, SmsService>();
        services.AddTransient<IStorageService, MinioStorageService>();
        services.AddTransient<ICacheService, RedisCacheService>();
        services.AddTransient<IPaymentService, PaymentService>();

        // Configure Elasticsearch
        ConfigureElasticsearch(services, configuration);

        // Configure OpenTelemetry with Jaeger
        services.AddOpenTelemetryServices(configuration);

        // Configure JWT authentication
        var jwtSettings = configuration.GetSection("JwtSettings");
        var secretKey = jwtSettings["SecretKey"];

        if (string.IsNullOrEmpty(secretKey))
        {
            throw new InvalidOperationException("JWT Secret Key is not configured.");
        }

        services.AddAuthentication(options =>
        {
            options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
        })
        .AddJwtBearer(options =>
        {
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                ValidIssuer = jwtSettings["Issuer"],
                ValidAudience = jwtSettings["Audience"],
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey))
            };
        });

        return services;
    }

    private static void ConfigureElasticsearch(IServiceCollection services, IConfiguration configuration)
    {
        var elasticsearchUrl = configuration["Elasticsearch:Url"];

        if (string.IsNullOrEmpty(elasticsearchUrl))
        {
            elasticsearchUrl = configuration["Elasticsearch:DefaultUrl"] ?? "http://elasticsearch:9200";
        }

        var settings = new ConnectionSettings(new Uri(elasticsearchUrl))
            .DefaultMappingFor<Domain.Entities.Service>(m => m
                .IndexName("services"))
            .DefaultMappingFor<Domain.Entities.ServiceProvider>(m => m
                .IndexName("serviceproviders"))
            .DefaultMappingFor<Domain.Entities.University>(m => m
                .IndexName("universities"))
            .DefaultMappingFor<Domain.Entities.FieldOfStudy>(m => m
                .IndexName("fieldsofstudy"))
            .DefaultMappingFor<Domain.Entities.ServiceCategory>(m => m
                .IndexName("servicecategories"))
            .EnableDebugMode()
            .PrettyJson()
            .RequestTimeout(TimeSpan.FromSeconds(30));

        var client = new ElasticClient(settings);
        services.AddSingleton<IElasticClient>(client);
        services.AddScoped<ISearchService, ElasticsearchService>();

        // Register health check for Elasticsearch
        services.AddHealthChecks()
            .AddUrlGroup(
                new Uri(elasticsearchUrl),
                name: "elasticsearch",
                failureStatus: HealthStatus.Degraded,
                tags: new[] { "elasticsearch" });
    }
}
