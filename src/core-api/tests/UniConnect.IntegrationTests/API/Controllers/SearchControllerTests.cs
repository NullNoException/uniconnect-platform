using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System.Net;
using System.Net.Http.Json;
using UniConnect.Application.Common.Models;
using UniConnect.Infrastructure.Search.Models;
using Xunit;
using Xunit.Abstractions;

namespace UniConnect.IntegrationTests.API.Controllers;

public class SearchControllerTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;
    private readonly HttpClient _client;
    private readonly ITestOutputHelper _output;

    public SearchControllerTests(WebApplicationFactory<Program> factory, ITestOutputHelper output)
    {
        _factory = factory;
        _output = output;
        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task GetSearchHealth_ShouldReturnHealthStatus()
    {
        // Act
        var response = await _client.GetAsync("/api/search/health");

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
        var response = await _client.GetAsync($"/api/search/services?query={query}&page=1&pageSize=10");

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
        var response = await _client.GetAsync($"/api/search/providers?query={query}&page=1&pageSize=10");

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
        var response = await _client.GetAsync($"/api/search/universities?query={query}&page=1&pageSize=10");

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
        var query = "test";

        // Act
        var response = await _client.GetAsync($"/api/search/suggestions?query={query}&limit=5");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var suggestions = await response.Content.ReadFromJsonAsync<IEnumerable<object>>();
        Assert.NotNull(suggestions);
        _output.WriteLine($"Autocomplete returned {suggestions.Count()} suggestions");
    }

    [Fact]
    public async Task AdvancedSearchServices_ShouldReturnSearchResult()
    {
        // Arrange
        var searchRequest = new SearchRequest
        {
            Query = "test",
            Offset = 0,
            Limit = 10,
            Filters = new List<SearchFilter>(),
            Sort = new List<SortField>()
        };

        // Act
        var response = await _client.PostAsJsonAsync("/api/search/advanced", searchRequest);

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var result = await response.Content.ReadFromJsonAsync<SearchResult<ServiceSearchDocument>>();
        Assert.NotNull(result);
        Assert.NotNull(result.Items);
        Assert.Equal(searchRequest.Query, result.Query);
        Assert.Equal(searchRequest.Limit, result.Limit);
        _output.WriteLine($"Advanced search returned {result.Items.Count} items");
    }

    [Fact]
    public async Task SearchAll_ShouldReturnGlobalSearchResults()
    {
        // Arrange
        var query = "test";

        // Act
        var response = await _client.GetAsync($"/api/search?query={query}&page=1&pageSize=5");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var content = await response.Content.ReadAsStringAsync();
        Assert.NotEmpty(content);
        _output.WriteLine($"Global search response: {content}");

        // Verify the response structure contains the expected properties
        Assert.Contains("services", content.ToLower());
        Assert.Contains("serviceProviders", content.ToLower());
        Assert.Contains("universities", content.ToLower());
    }

    [Theory]
    [InlineData("services/test-id")]
    [InlineData("providers/test-id")]
    public async Task GetSimilarItems_ShouldReturnSimilarResults_OrNotFound(string endpoint)
    {
        // Act
        var response = await _client.GetAsync($"/api/search/similar/{endpoint}?limit=5");

        // Assert
        // Should return either OK with results or NotFound for non-existent items
        Assert.True(response.StatusCode == HttpStatusCode.OK || response.StatusCode == HttpStatusCode.NotFound);

        var content = await response.Content.ReadAsStringAsync();
        _output.WriteLine($"Similar items response for {endpoint}: Status={response.StatusCode}, Content={content}");
    }
}
