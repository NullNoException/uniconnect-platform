using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Moq;
using UniConnect.Application.AcademicCalendars.Services;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Infrastructure.Persistence;
using UniConnect.Infrastructure.Persistence.Interceptors;
using Xunit;

namespace UniConnect.UnitTests.Application.AcademicCalendars.Services;

public class SemesterStatusServiceTests
{
    private static readonly DateTime _fixedDate = new DateTime(2025, 5, 30, 0, 0, 0, DateTimeKind.Utc);

    private static ApplicationDbContext GetDbContext(string dbName)
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(databaseName: dbName)
            .Options;
        var interceptor = new AuditableEntitySaveChangesInterceptor(
            new TestCurrentUserService(), new TestDateTime());
        return new ApplicationDbContext(options, interceptor);
    }

    [Fact]
    public async Task UpdateSemesterStatusesAsync_ShouldUpdateStatuses_BasedOnCurrentDate()
    {
        // Arrange
        var dbContext = GetDbContext("SemesterStatusServiceTestDb");
        dbContext.Semesters.AddRange(new[]
        {
            // Past semester that should be Inactive
            new Semester
            {
                Id = Guid.NewGuid(),
                Name = "Past Semester",
                StartDate = _fixedDate.AddMonths(-6),
                EndDate = _fixedDate.AddMonths(-1),
                Status = SemesterStatus.Active
            },
            // Current semester that should be Active
            new Semester
            {
                Id = Guid.NewGuid(),
                Name = "Current Semester",
                StartDate = _fixedDate.AddMonths(-1),
                EndDate = _fixedDate.AddMonths(2),
                Status = SemesterStatus.Upcoming
            },
            // Future semester that should remain Upcoming
            new Semester
            {
                Id = Guid.NewGuid(),
                Name = "Future Semester",
                StartDate = _fixedDate.AddMonths(3),
                EndDate = _fixedDate.AddMonths(6),
                Status = SemesterStatus.Upcoming
            },
            // Edge case: Upcoming semester with past end date
            new Semester
            {
                Id = Guid.NewGuid(),
                Name = "Edge Case",
                StartDate = _fixedDate.AddMonths(-3),
                EndDate = _fixedDate.AddDays(-1),
                Status = SemesterStatus.Upcoming
            }
        });
        await dbContext.SaveChangesAsync();

        var logger = new Mock<ILogger<SemesterStatusService>>();
        var dateTime = new Mock<IDateTime>();
        dateTime.Setup(d => d.UtcNow).Returns(_fixedDate);

        var service = new SemesterStatusService(dbContext, logger.Object, dateTime.Object);

        // Act
        await service.UpdateSemesterStatusesAsync(CancellationToken.None);

        // Assert
        var semesters = await dbContext.Semesters.ToListAsync();
        Assert.Equal(SemesterStatus.Inactive, semesters[0].Status); // Past
        Assert.Equal(SemesterStatus.Active, semesters[1].Status);   // Current
        Assert.Equal(SemesterStatus.Upcoming, semesters[2].Status); // Future
        Assert.Equal(SemesterStatus.Inactive, semesters[3].Status); // Edge
    }

    // TestCurrentUserService and TestDateTime for the interceptor
    private class TestCurrentUserService : ICurrentUserService
    {
        public string? UserId => "test-user";
        public string? UserEmail => "test@example.com";
        public bool IsAuthenticated => true;
        public bool IsInRole(string role) => false;
    }
    private class TestDateTime : IDateTime
    {
        public DateTime Now => _fixedDate;
        public DateTime UtcNow => _fixedDate;
    }
}
