using System;
using System.Collections.Generic;
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
using Xunit;

namespace UniConnect.UnitTests.Application.AcademicCalendars.Services;

public class SemesterStatusServiceTests
{
    private readonly Mock<IApplicationDbContext> _mockContext;
    private readonly Mock<ILogger<SemesterStatusService>> _mockLogger;
    private readonly Mock<IDateTime> _mockDateTime;
    private readonly SemesterStatusService _service;

    // Mock DbSet data
    private readonly List<Semester> _semesters;
    private readonly DateTime _fixedDate = new DateTime(2025, 5, 30);

    public SemesterStatusServiceTests()
    {
        _mockContext = new Mock<IApplicationDbContext>();
        _mockLogger = new Mock<ILogger<SemesterStatusService>>();
        _mockDateTime = new Mock<IDateTime>();

        // Setup fixed date for testing
        _mockDateTime.Setup(d => d.Now).Returns(_fixedDate);

        // Create sample data
        _semesters = new List<Semester>
        {
            // Past semester that should be Inactive
            new Semester
            {
                Id = Guid.NewGuid(),
                Name = "Past Semester",
                StartDate = _fixedDate.AddMonths(-6),
                EndDate = _fixedDate.AddMonths(-1),
                Status = SemesterStatus.Active // Should change to Inactive
            },
            
            // Current semester that should be Active
            new Semester
            {
                Id = Guid.NewGuid(),
                Name = "Current Semester",
                StartDate = _fixedDate.AddMonths(-1),
                EndDate = _fixedDate.AddMonths(2),
                Status = SemesterStatus.Upcoming // Should change to Active
            },
            
            // Future semester that should remain Upcoming
            new Semester
            {
                Id = Guid.NewGuid(),
                Name = "Future Semester",
                StartDate = _fixedDate.AddMonths(3),
                EndDate = _fixedDate.AddMonths(6),
                Status = SemesterStatus.Upcoming // Should stay Upcoming
            },
            
            // Edge case: Upcoming semester with past end date
            new Semester
            {
                Id = Guid.NewGuid(),
                Name = "Edge Case",
                StartDate = _fixedDate.AddMonths(-3),
                EndDate = _fixedDate.AddDays(-1),
                Status = SemesterStatus.Upcoming // Should change to Inactive
            }
        };

        // Setup mock DbSet
        var mockSemestersDbSet = CreateMockDbSet(_semesters);
        _mockContext.Setup(c => c.Semesters).Returns(mockSemestersDbSet.Object);

        // Create service
        _service = new SemesterStatusService(_mockContext.Object, _mockLogger.Object, _mockDateTime.Object);
    }

    [Fact]
    public async Task UpdateSemesterStatusesAsync_ShouldUpdateStatuses_BasedOnCurrentDate()
    {
        // Act
        await _service.UpdateSemesterStatusesAsync(CancellationToken.None);

        // Assert
        _mockContext.Verify(c => c.SaveChangesAsync(It.IsAny<CancellationToken>()), Times.Once);

        // Verify past semester is now inactive
        var pastSemester = _semesters[0];
        Assert.Equal(SemesterStatus.Inactive, pastSemester.Status);

        // Verify current semester is now active
        var currentSemester = _semesters[1];
        Assert.Equal(SemesterStatus.Active, currentSemester.Status);

        // Verify future semester stays upcoming
        var futureSemester = _semesters[2];
        Assert.Equal(SemesterStatus.Upcoming, futureSemester.Status);

        // Verify edge case is now inactive
        var edgeCaseSemester = _semesters[3];
        Assert.Equal(SemesterStatus.Inactive, edgeCaseSemester.Status);
    }

    private Mock<DbSet<T>> CreateMockDbSet<T>(List<T> data) where T : class
    {
        var queryable = data.AsQueryable();
        var mockSet = new Mock<DbSet<T>>();

        mockSet.As<IQueryable<T>>().Setup(m => m.Provider).Returns(queryable.Provider);
        mockSet.As<IQueryable<T>>().Setup(m => m.Expression).Returns(queryable.Expression);
        mockSet.As<IQueryable<T>>().Setup(m => m.ElementType).Returns(queryable.ElementType);
        mockSet.As<IQueryable<T>>().Setup(m => m.GetEnumerator()).Returns(() => queryable.GetEnumerator());

        return mockSet;
    }
}
