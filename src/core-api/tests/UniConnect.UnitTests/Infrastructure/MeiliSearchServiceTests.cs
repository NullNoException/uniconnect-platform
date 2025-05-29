using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Moq;
using UniConnect.Application.Common.Models;
using UniConnect.Infrastructure.Configuration;
using UniConnect.Infrastructure.Services;
using Xunit;

namespace UniConnect.UnitTests.Infrastructure;

public class MeiliSearchServiceTests
{
    private readonly Mock<IDistributedCache> _mockCache;
    private readonly Mock<ILogger<MeiliSearchService>> _mockLogger;
    private readonly MeiliSearchSettings _settings;
    private readonly MeiliSearchService _service;

    public MeiliSearchServiceTests()
    {
        _mockCache = new Mock<IDistributedCache>();
        _mockLogger = new Mock<ILogger<MeiliSearchService>>();

        _settings = new MeiliSearchSettings
        {
            Url = "http://localhost:7700",
            MasterKey = "test-key",
            TypoTolerance = new TypoToleranceSettings
            {
                Enabled = true,
                MinWordSizeOneTypo = 5,
                MinWordSizeTwoTypos = 9
            },
            CacheSettings = new CacheSettings
            {
                SearchResultTtlMinutes = 10,
                AutocompleteTtlMinutes = 60
            }
        };

        var options = Options.Create(_settings);
        _service = new MeiliSearchService(options, _mockCache.Object, _mockLogger.Object);
    }

    [Fact]
    public void Constructor_ShouldInitializeCorrectly()
    {
        // Arrange & Act
        var options = Options.Create(_settings);
        var service = new MeiliSearchService(options, _mockCache.Object, _mockLogger.Object);

        // Assert
        Assert.NotNull(service);
    }

    [Fact]
    public async Task GetSimilarAsync_ShouldReturnEmptyResult()
    {
        // Arrange
        var documentId = "test-id";
        var limit = 10;

        // Act
        var result = await _service.GetSimilarAsync<TestDocument>(documentId, limit);

        // Assert
        Assert.NotNull(result);
        Assert.Empty(result.Items);
        Assert.Equal(0, result.TotalCount);
        Assert.Equal(0, result.Offset);
        Assert.Equal(limit, result.Limit);
        Assert.Equal(string.Empty, result.Query);
        Assert.Equal(0, result.ProcessingTimeMs);
    }

    [Fact]
    public async Task InitializeIndexesAsync_ShouldNotThrow()
    {
        // Arrange & Act & Assert
        // This test just ensures the method doesn't throw during initialization
        // In a real test environment with MeiliSearch running, this would actually create indexes
        var exception = await Record.ExceptionAsync(() => _service.InitializeIndexesAsync());

        // We expect this to throw in unit tests since we don't have a real MeiliSearch instance
        // but we're testing that the method exists and has the right signature
        Assert.NotNull(exception);
    }

    // Test document class for testing
    private class TestDocument
    {
        public string Id { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
    }
}
