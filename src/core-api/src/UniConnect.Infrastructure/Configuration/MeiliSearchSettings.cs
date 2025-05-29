using System.ComponentModel.DataAnnotations;

namespace UniConnect.Infrastructure.Configuration;

public class MeiliSearchSettings
{
    public const string SectionName = "MeilisearchSettings";

    [Required]
    public string Url { get; set; } = string.Empty;

    [Required]
    public string MasterKey { get; set; } = string.Empty;

    public TimeSpan DefaultTimeout { get; set; } = TimeSpan.FromSeconds(30);

    /// <summary>
    /// Whether to enable typo tolerance (fuzzy search)
    /// </summary>
    public bool EnableTypoTolerance { get; set; } = true;

    /// <summary>
    /// Maximum typos allowed for typo tolerance
    /// </summary>
    public int MaxTypos { get; set; } = 2;

    /// <summary>
    /// Default language for multi-language support
    /// </summary>
    public string DefaultLanguage { get; set; } = "en";

    /// <summary>
    /// Supported languages for the search
    /// </summary>
    public string[] SupportedLanguages { get; set; } = { "en", "ar", "fr", "es", "de" };

    /// <summary>
    /// Search cache TTL in minutes
    /// </summary>
    public int SearchCacheTtlMinutes { get; set; } = 10;

    /// <summary>
    /// Typo tolerance configuration
    /// </summary>
    public TypoToleranceSettings TypoTolerance { get; set; } = new();

    /// <summary>
    /// Cache settings configuration
    /// </summary>
    public CacheSettings CacheSettings { get; set; } = new();

    /// <summary>
    /// Index settings for high availability
    /// </summary>
    public IndexSettings IndexSettings { get; set; } = new();
}

public class IndexSettings
{
    /// <summary>
    /// Number of replicas for high availability
    /// </summary>
    public int NumberOfReplicas { get; set; } = 1;

    /// <summary>
    /// Pagination default limit
    /// </summary>
    public int DefaultPaginationLimit { get; set; } = 20;

    /// <summary>
    /// Maximum pagination limit
    /// </summary>
    public int MaxPaginationLimit { get; set; } = 1000;

    /// <summary>
    /// Ranking rules for custom business logic
    /// </summary>
    public string[] DefaultRankingRules { get; set; } =
    {
        "words",
        "typo",
        "proximity",
        "attribute",
        "sort",
        "exactness",
        "custom_score:desc"
    };
}

/// <summary>
/// Typo tolerance settings for fuzzy search
/// </summary>
public class TypoToleranceSettings
{
    /// <summary>
    /// Whether typo tolerance is enabled
    /// </summary>
    public bool Enabled { get; set; } = true;

    /// <summary>
    /// Minimum word size for one typo
    /// </summary>
    public int MinWordSizeOneTypo { get; set; } = 5;

    /// <summary>
    /// Minimum word size for two typos
    /// </summary>
    public int MinWordSizeTwoTypos { get; set; } = 9;
}

/// <summary>
/// Cache settings configuration
/// </summary>
public class CacheSettings
{
    /// <summary>
    /// Search result cache TTL in minutes
    /// </summary>
    public int SearchResultTtlMinutes { get; set; } = 10;

    /// <summary>
    /// Autocomplete cache TTL in minutes
    /// </summary>
    public int AutocompleteTtlMinutes { get; set; } = 60;
}

/// <summary>
/// MeiliSearch typo tolerance configuration
/// </summary>
public class MinWordSizeForTypos
{
    /// <summary>
    /// Minimum word size for one typo
    /// </summary>
    public int OneTypo { get; set; } = 5;

    /// <summary>
    /// Minimum word size for two typos
    /// </summary>
    public int TwoTypos { get; set; } = 9;
}
