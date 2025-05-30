using Microsoft.EntityFrameworkCore;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Infrastructure.Persistence;

namespace UniConnect.IntegrationTests.Helpers;

/// <summary>
/// Helper class to create test data for integration tests
/// </summary>
public static class TestDataGenerator
{
    /// <summary>
    /// Creates a set of basic test data needed for most tests
    /// </summary>
    public static async Task CreateBasicTestDataAsync(ApplicationDbContext context)
    {
        // Check if data already exists
        if (await context.Universities.AnyAsync())
        {
            return;
        }

        // Create test university
        var university = new University
        {
            Name = "Test University",
            Description = "Test university for integration tests",
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        context.Universities.Add(university);
        await context.SaveChangesAsync();

        // Create academic calendar
        var calendar = new AcademicCalendar
        {
            UniversityId = university.Id,
            Name = "Test Calendar 2025-2026",
            Description = "Test academic calendar for integration tests",
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        context.AcademicCalendars.Add(calendar);
        await context.SaveChangesAsync();

        // Create academic year
        var academicYear = new AcademicYear
        {
            AcademicCalendarId = calendar.Id,
            Name = "2025-2026",
            StartDate = new DateTime(2025, 9, 1, 0, 0, 0, DateTimeKind.Utc),
            EndDate = new DateTime(2026, 8, 31, 0, 0, 0, DateTimeKind.Utc),
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        context.AcademicYears.Add(academicYear);
        await context.SaveChangesAsync();

        // Create semesters
        var semester1 = new Semester
        {
            AcademicYearId = academicYear.Id,
            Name = "Fall 2025",
            Code = "F2025",
            Description = "Fall semester 2025",
            StartDate = new DateTime(2025, 9, 1, 0, 0, 0, DateTimeKind.Utc),
            EndDate = new DateTime(2026, 1, 15, 0, 0, 0, DateTimeKind.Utc),
            Status = SemesterStatus.Active,
            Order = 1,
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        var semester2 = new Semester
        {
            AcademicYearId = academicYear.Id,
            Name = "Spring 2026",
            Code = "S2026",
            Description = "Spring semester 2026",
            StartDate = new DateTime(2026, 2, 1, 0, 0, 0, DateTimeKind.Utc),
            EndDate = new DateTime(2026, 6, 15, 0, 0, 0, DateTimeKind.Utc),
            Status = SemesterStatus.Upcoming,
            Order = 2,
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        context.Semesters.AddRange(semester1, semester2);
        await context.SaveChangesAsync();

        // Create services for search tests - commented out due to missing properties
        // Will need to adjust based on actual Service entity definition
        /* 
        var service1 = new Service
        {
            Title = "Test Academic Service",
            Description = "Test service for academic support",
            UniversityId = university.Id,
            IsActive = true,
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        var service2 = new Service
        {
            Title = "Test Career Service",
            Description = "Test service for career development",
            UniversityId = university.Id,
            IsActive = true,
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        context.Services.AddRange(service1, service2);
        await context.SaveChangesAsync();

        // Create service providers for search tests
        var provider1 = new ServiceProvider
        {
            Name = "Test Provider 1",
            Description = "Test service provider for integration tests",
            UniversityId = university.Id,
            IsActive = true,
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        var provider2 = new ServiceProvider
        {
            Name = "Test Provider 2",
            Description = "Another test service provider",
            UniversityId = university.Id,
            IsActive = true,
            CreatedAt = DateTime.UtcNow,
            CreatedBy = "IntegrationTest"
        };

        context.ServiceProviders.AddRange(provider1, provider2);
        await context.SaveChangesAsync();
        */
    }
}
