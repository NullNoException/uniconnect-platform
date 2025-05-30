using System.Net;
using System.Net.Http.Json;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using UniConnect.Application.AcademicCalendars.Commands.CreateSemester;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Models;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Infrastructure.Persistence;
using Xunit;

namespace UniConnect.IntegrationTests.API;

public class SemesterControllerTests : IntegrationTest
{
    private Guid _testAcademicYearId;
    private Guid _testSemesterId;

    public SemesterControllerTests()
        : base()
    {
    }

    public override async Task InitializeAsync()
    {
        // Initialize base first
        await base.InitializeAsync();

        // Get test data IDs
        await GetTestDataIdsAsync();
    }

    [Fact]
    public async Task CreateSemester_ShouldCreateNewSemester_WhenValidRequest()
    {
        // Arrange
        var request = new CreateSemesterRequest
        {
            AcademicYearId = _testAcademicYearId,
            Name = "Test Semester",
            Code = "TS-2025",
            Description = "Test semester description",
            StartDate = new DateTime(2025, 9, 1, 0, 0, 0, DateTimeKind.Utc),
            EndDate = new DateTime(2026, 1, 31, 0, 0, 0, DateTimeKind.Utc),
            Status = SemesterStatus.Upcoming,
            Order = 1
        };

        // Act
        var response = await _httpClient.PostAsJsonAsync("/api/v1/admin/semesters", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Created);
        var result = await response.Content.ReadFromJsonAsync<SemesterDto>();
        result.Should().NotBeNull();
        result!.Name.Should().Be("Test Semester");
        result.Code.Should().Be("TS-2025");
        result.Status.Should().Be(SemesterStatus.Upcoming);
    }

    [Fact]
    public async Task GetSemesters_ShouldReturnFilteredSemesters_WhenQueryParametersProvided()
    {
        // Act
        var response = await _httpClient.GetAsync($"/api/v1/admin/semesters?AcademicYearId={_testAcademicYearId}&Status={SemesterStatus.Active}");

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
        var result = await response.Content.ReadFromJsonAsync<PaginatedList<SemesterDto>>();
        result.Should().NotBeNull();

        // Should only contain active semesters
        result!.Items.Should().OnlyContain(s => s.Status == SemesterStatus.Active);
    }

    [Fact]
    public async Task UpdateSemesterStatus_ShouldChangeStatus_WhenValidRequest()
    {
        // Arrange
        var newStatus = SemesterStatus.Active;

        // Act
        var response = await _httpClient.PatchAsJsonAsync($"/api/v1/admin/semesters/{_testSemesterId}/status", newStatus);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
        var result = await response.Content.ReadFromJsonAsync<SemesterDto>();
        result.Should().NotBeNull();
        result!.Status.Should().Be(newStatus);

        // Verify in database
        using var scope = _factory.Services.CreateScope();
        var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
        var semester = await dbContext.Semesters.FindAsync(_testSemesterId);
        semester.Should().NotBeNull();
        semester!.Status.Should().Be(newStatus);
    }

    /// <summary>
    /// Get IDs of the test data created by TestDataGenerator
    /// </summary>
    private async Task GetTestDataIdsAsync()
    {
        using var scope = _factory.Services.CreateScope();
        var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();

        // Get first test semester
        var testSemester = await dbContext.Semesters
            .Include(s => s.AcademicYear)
            .ThenInclude(ay => ay.AcademicCalendar)
            .FirstAsync(s => s.Name == "Fall 2025");

        _testSemesterId = testSemester.Id;
        _testAcademicYearId = testSemester.AcademicYearId;
    }
}
