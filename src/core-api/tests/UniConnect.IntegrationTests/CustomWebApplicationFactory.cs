using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Serilog;
using Serilog.Events;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Infrastructure.Persistence;
using UniConnect.IntegrationTests.Services;

namespace UniConnect.IntegrationTests;

public class CustomWebApplicationFactory<TProgram> : WebApplicationFactory<TProgram> where TProgram : class
{
    // Keep connection open to maintain in-memory database during test
    private readonly SqliteConnection _connection;

    public CustomWebApplicationFactory()
    {
        _connection = new SqliteConnection("DataSource=:memory:");
        _connection.Open();

        // Ensure environment variable is set to Testing
        Environment.SetEnvironmentVariable("ASPNETCORE_ENVIRONMENT", "Testing");
    }

    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        // Set environment to Testing
        builder.UseEnvironment("Testing");

        builder.ConfigureServices(services =>
        {
            // Remove the real DB context registration first
            var descriptors = services.Where(d =>
                d.ServiceType == typeof(DbContextOptions<ApplicationDbContext>) ||
                d.ServiceType == typeof(IApplicationDbContext) ||
                d.ServiceType == typeof(ApplicationDbContextInitialiser) ||
                d.ServiceType == typeof(IDateTime) ||
                d.ServiceType.Name.Contains("EntityFrameworkCore"))
                .ToList();

            foreach (var descriptor in descriptors)
            {
                services.Remove(descriptor);
            }

            // Add SQLite in-memory database for testing (using the persistent connection)
            services.AddDbContext<ApplicationDbContext>(options =>
            {
                options.UseSqlite(_connection);
                options.EnableSensitiveDataLogging();
            });

            // Register the application DB context interface
            services.AddScoped<IApplicationDbContext>(provider =>
                provider.GetRequiredService<ApplicationDbContext>());

            // Use our test DateTime service that always returns UTC times
            services.AddSingleton<IDateTime, TestDateTimeService>();

            // Disable background services for tests
            services.AddSingleton<IHostedService, DummyBackgroundService>();

            // Add the database initializer to create the schema
            services.AddScoped<TestDatabaseInitializer>();

            // Remove any OpenTelemetry services that might have been registered
            var telemetryDescriptors = services.Where(d =>
                (d.ServiceType.FullName?.Contains("OpenTelemetry")).GetValueOrDefault() ||
                (d.ServiceType.FullName?.Contains("Jaeger")).GetValueOrDefault())
                .ToList();

            foreach (var descriptor in telemetryDescriptors)
            {
                services.Remove(descriptor);
            }
        });

        // Configure the app to skip database initialization
        builder.ConfigureAppConfiguration((context, config) =>
        {
            // Add test configuration file
            config.AddJsonFile("appsettings.Testing.json", optional: true);

            config.AddInMemoryCollection(new[]
            {
                new KeyValuePair<string, string?>("SkipDbInitialization", "true"),
                new KeyValuePair<string, string?>("UseSerilog", "false"), // Disable Serilog in tests
                new KeyValuePair<string, string?>("ConnectionStrings:DefaultConnection", "DataSource=:memory:"), // Override connection string
                new KeyValuePair<string, string?>("UseInMemoryDatabase", "true") // Signal to use in-memory database
            });
        });

        builder.ConfigureLogging(logging =>
        {
            // Use basic logging for tests
            logging.ClearProviders();
            logging.AddConsole();
        });
    }

    protected override void Dispose(bool disposing)
    {
        if (disposing)
        {
            _connection?.Dispose();
        }

        base.Dispose(disposing);
    }
}
