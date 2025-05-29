using System.Text.Json.Serialization;

namespace UniConnect.Infrastructure.Search.Models;

/// <summary>
/// Base search document interface
/// </summary>
public interface ISearchDocument
{
    string Id { get; set; }
    string Type { get; set; }
    double? CustomScore { get; set; }
    DateTime LastUpdated { get; set; }
}

/// <summary>
/// Service search document
/// </summary>
public class ServiceSearchDocument : ISearchDocument
{
    [JsonPropertyName("id")]
    public string Id { get; set; } = string.Empty;

    [JsonPropertyName("type")]
    public string Type { get; set; } = "service";

    [JsonPropertyName("name")]
    public string Name { get; set; } = string.Empty;

    [JsonPropertyName("description")]
    public string Description { get; set; } = string.Empty;

    [JsonPropertyName("requirements")]
    public string Requirements { get; set; } = string.Empty;

    [JsonPropertyName("category")]
    public string Category { get; set; } = string.Empty;

    [JsonPropertyName("subcategory")]
    public string Subcategory { get; set; } = string.Empty;

    [JsonPropertyName("language")]
    public string Language { get; set; } = string.Empty;

    [JsonPropertyName("price_range")]
    public string PriceRange { get; set; } = string.Empty;

    [JsonPropertyName("location")]
    public string Location { get; set; } = string.Empty;

    [JsonPropertyName("provider_name")]
    public string ProviderName { get; set; } = string.Empty;

    [JsonPropertyName("provider_rating")]
    public double ProviderRating { get; set; }

    [JsonPropertyName("is_verified")]
    public bool IsVerified { get; set; }

    [JsonPropertyName("created_at")]
    public DateTime CreatedAt { get; set; }

    [JsonPropertyName("last_updated")]
    public DateTime LastUpdated { get; set; }

    [JsonPropertyName("custom_score")]
    public double? CustomScore { get; set; }

    [JsonPropertyName("tags")]
    public string[] Tags { get; set; } = Array.Empty<string>();
}

/// <summary>
/// Service Provider search document
/// </summary>
public class ServiceProviderSearchDocument : ISearchDocument
{
    [JsonPropertyName("id")]
    public string Id { get; set; } = string.Empty;

    [JsonPropertyName("type")]
    public string Type { get; set; } = "service_provider";

    [JsonPropertyName("name")]
    public string Name { get; set; } = string.Empty;

    [JsonPropertyName("description")]
    public string Description { get; set; } = string.Empty;

    [JsonPropertyName("business_fields")]
    public string[] BusinessFields { get; set; } = Array.Empty<string>();

    [JsonPropertyName("location")]
    public string Location { get; set; } = string.Empty;

    [JsonPropertyName("city")]
    public string City { get; set; } = string.Empty;

    [JsonPropertyName("country")]
    public string Country { get; set; } = string.Empty;

    [JsonPropertyName("rating")]
    public double Rating { get; set; }

    [JsonPropertyName("total_services")]
    public int TotalServices { get; set; }

    [JsonPropertyName("is_verified")]
    public bool IsVerified { get; set; }

    [JsonPropertyName("is_premium")]
    public bool IsPremium { get; set; }

    [JsonPropertyName("years_of_experience")]
    public int YearsOfExperience { get; set; }

    [JsonPropertyName("languages")]
    public string[] Languages { get; set; } = Array.Empty<string>();

    [JsonPropertyName("created_at")]
    public DateTime CreatedAt { get; set; }

    [JsonPropertyName("last_updated")]
    public DateTime LastUpdated { get; set; }

    [JsonPropertyName("custom_score")]
    public double? CustomScore { get; set; }
}

/// <summary>
/// University search document
/// </summary>
public class UniversitySearchDocument : ISearchDocument
{
    [JsonPropertyName("id")]
    public string Id { get; set; } = string.Empty;

    [JsonPropertyName("type")]
    public string Type { get; set; } = "university";

    [JsonPropertyName("name")]
    public string Name { get; set; } = string.Empty;

    [JsonPropertyName("description")]
    public string Description { get; set; } = string.Empty;

    [JsonPropertyName("location")]
    public string Location { get; set; } = string.Empty;

    [JsonPropertyName("city")]
    public string City { get; set; } = string.Empty;

    [JsonPropertyName("country")]
    public string Country { get; set; } = string.Empty;

    [JsonPropertyName("established_year")]
    public int EstablishedYear { get; set; }

    [JsonPropertyName("university_type")]
    public string UniversityType { get; set; } = string.Empty;

    [JsonPropertyName("ranking")]
    public int? Ranking { get; set; }

    [JsonPropertyName("website")]
    public string Website { get; set; } = string.Empty;

    [JsonPropertyName("languages")]
    public string[] Languages { get; set; } = Array.Empty<string>();

    [JsonPropertyName("fields_of_study")]
    public string[] FieldsOfStudy { get; set; } = Array.Empty<string>();

    [JsonPropertyName("created_at")]
    public DateTime CreatedAt { get; set; }

    [JsonPropertyName("last_updated")]
    public DateTime LastUpdated { get; set; }

    [JsonPropertyName("custom_score")]
    public double? CustomScore { get; set; }
}

/// <summary>
/// Field of Study search document
/// </summary>
public class FieldOfStudySearchDocument : ISearchDocument
{
    [JsonPropertyName("id")]
    public string Id { get; set; } = string.Empty;

    [JsonPropertyName("type")]
    public string Type { get; set; } = "field_of_study";

    [JsonPropertyName("name")]
    public string Name { get; set; } = string.Empty;

    [JsonPropertyName("description")]
    public string Description { get; set; } = string.Empty;

    [JsonPropertyName("category")]
    public string Category { get; set; } = string.Empty;

    [JsonPropertyName("level")]
    public string Level { get; set; } = string.Empty;

    [JsonPropertyName("duration")]
    public string Duration { get; set; } = string.Empty;

    [JsonPropertyName("language")]
    public string Language { get; set; } = string.Empty;

    [JsonPropertyName("universities_count")]
    public int UniversitiesCount { get; set; }

    [JsonPropertyName("career_prospects")]
    public string[] CareerProspects { get; set; } = Array.Empty<string>();

    [JsonPropertyName("related_fields")]
    public string[] RelatedFields { get; set; } = Array.Empty<string>();

    [JsonPropertyName("created_at")]
    public DateTime CreatedAt { get; set; }

    [JsonPropertyName("last_updated")]
    public DateTime LastUpdated { get; set; }

    [JsonPropertyName("custom_score")]
    public double? CustomScore { get; set; }
}

/// <summary>
/// Search suggestion for autocomplete
/// </summary>
public class SearchSuggestion
{
    public string Text { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public double Score { get; set; }
    public Dictionary<string, object> Metadata { get; set; } = new();
}

/// <summary>
/// Search analytics data
/// </summary>
public class SearchAnalytics
{
    public string Query { get; set; } = string.Empty;
    public int ResultsCount { get; set; }
    public long ResponseTimeMs { get; set; }
    public DateTime Timestamp { get; set; }
    public string UserId { get; set; } = string.Empty;
    public string IndexName { get; set; } = string.Empty;
    public Dictionary<string, object> Filters { get; set; } = new();
}
