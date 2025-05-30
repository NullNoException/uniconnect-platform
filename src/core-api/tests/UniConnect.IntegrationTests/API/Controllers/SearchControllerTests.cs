using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System.Net;
using System.Net.Http.Json;
using UniConnect.Application.Common.Models;
using UniConnect.Infrastructure.Search.Models;
using Xunit;
using Xunit.Abstractions;

namespace UniConnect.IntegrationTests.API.Controllers;

public class SearchControllerTests : IntegrationTest
{
    private readonly ITestOutputHelper _output;

    public SearchControllerTests(ITestOutputHelper output)
    {
        _output = output;
    }

    [Fact]
    public async Task GetSearchHealth_ShouldReturnHealthStatus()
    {
        // Act
        var response = await _httpClient.GetAsync("/api/search/health");

        // Assert
        // The response can be either 200 (healthy) or 503 (unhealthy) depending on MeiliSearch availability
        Assert.True(response.StatusCode == HttpStatusCode.OK || response.StatusCode == HttpStatusCode.ServiceUnavailable);

        var content = await response.Content.ReadAsStringAsync();
        Assert.NotEmpty(content);
        _output.WriteLine($"Search health response: {content}");
    }

    [Fact]
    public async Task SearchServices_ShouldReturnSearchResult()
    {
        // Arrange
        var query = "test";

        // Act
        var response = await _httpClient.GetAsync($"/api/search/services?query={query}&page=1&pageSize=10");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var result = await response.Content.ReadFromJsonAsync<SearchResult<ServiceSearchDocument>>();
        Assert.NotNull(result);
        Assert.NotNull(result.Items);
        Assert.True(result.Limit > 0);
        _output.WriteLine($"Search services returned {result.Items.Count} items");
    }

    [Fact]
    public async Task SearchProviders_ShouldReturnSearchResult()
    {
        // Arrange
        var query = "provider";

        // Act
        var response = await _httpClient.GetAsync($"/api/search/providers?query={query}&page=1&pageSize=10");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var result = await response.Content.ReadFromJsonAsync<SearchResult<ServiceProviderSearchDocument>>();
        Assert.NotNull(result);
        Assert.NotNull(result.Items);
        Assert.True(result.Limit > 0);
        _output.WriteLine($"Search providers returned {result.Items.Count} items");
    }

    [Fact]
    public async Task SearchUniversities_ShouldReturnSearchResult()
    {
        // Arrange
        var query = "university";

        // Act
        var response = await _httpClient.GetAsync($"/api/search/universities?query={query}&page=1&pageSize=10");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var result = await response.Content.ReadFromJsonAsync<SearchResult<UniversitySearchDocument>>();
        Assert.NotNull(result);
        Assert.NotNull(result.Items);
        Assert.True(result.Limit > 0);
        _output.WriteLine($"Search universities returned {result.Items.Count} items");
    }

    [Fact]
    public async Task GetAutocompleteSuggestions_ShouldReturnSuggestions()
    {
        // Arrange
        var query = "uni";

        // Act
        var response = await _httpClient.GetAsync($"/api/search/autocomplete?query={query}");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var result = await response.Content.ReadFromJsonAsync<List<string>>();
        Assert.NotNull(result);
        _output.WriteLine($"Autocomplete returned {result.Count} suggestions");
    }
}
