using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Infrastructure.Persistence;
using UniConnect.IntegrationTests.Helpers;

namespace UniConnect.IntegrationTests.Services;

/// <summary>
/// Creates and initializes the test database schema
/// </summary>
public class TestDatabaseInitializer
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<TestDatabaseInitializer> _logger;

    public TestDatabaseInitializer(
        ApplicationDbContext context,
        ILogger<TestDatabaseInitializer> logger)
    {
        _context = context;
        _logger = logger;
    }

    /// <summary>
    /// Initialize the database schema for tests
    /// </summary>
    public async Task InitializeAsync()
    {
        try
        {
            // Ensure the schema is created by creating/updating tables based on entity configurations
            _logger.LogInformation("Creating database schema from model...");
            await _context.Database.EnsureCreatedAsync();

            // If schema is created successfully but there's no data, seed with test data
            if (!await _context.Users.AnyAsync())
            {
                _logger.LogInformation("Seeding initial test data...");
                await SeedTestDataAsync();
            }

            _logger.LogInformation("Test database initialization completed successfully");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred while initializing the test database");
            throw;
        }
    }

    private async Task SeedTestDataAsync()
    {
        // Add some basic test data
        var testSemester = new Domain.Entities.Semester
        {
            Id = Guid.NewGuid(),
            Name = "Test Semester",
            StartDate = DateTime.UtcNow,
            EndDate = DateTime.UtcNow.AddMonths(6),
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "system"
        };

        await _context.Semesters.AddAsync(testSemester);
        await _context.SaveChangesAsync();
    }

    /// <summary>
    /// Reset the database back to a clean state
    /// </summary>
    public async Task ResetAsync()
    {
        try
        {
            // Delete all data but keep the schema
            foreach (var entityType in _context.Model.GetEntityTypes())
            {
                var tableName = entityType.GetTableName();
                if (tableName != null)
                {
                    // Using FormattableString for SQL injection protection
                    await _context.Database.ExecuteSqlInterpolatedAsync($"DELETE FROM {tableName}");
                }
            }

            await _context.SaveChangesAsync();

            // Recreate test data
            await TestDataGenerator.CreateBasicTestDataAsync(_context);

            _logger.LogInformation("Test database reset successfully with fresh test data");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred while resetting the test database");
            throw;
        }
    }
}
