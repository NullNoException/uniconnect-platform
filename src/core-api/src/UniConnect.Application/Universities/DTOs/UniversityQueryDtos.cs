using UniConnect.Domain.Enums;

namespace UniConnect.Application.Universities.DTOs;

public record UniversitySearchRequest
{
    public string? Name { get; init; }
    public Guid? CountryId { get; init; }
    public UniversityStatus? Status { get; init; }
    public AccreditationStatus? AccreditationStatus { get; init; }
    public string? Type { get; init; }
    public int? EstablishedYearFrom { get; init; }
    public int? EstablishedYearTo { get; init; }
    public decimal? RankingFrom { get; init; }
    public decimal? RankingTo { get; init; }
    public bool? IsActive { get; init; } = true;
    public int Page { get; init; } = 1;
    public int PageSize { get; init; } = 20;
    public string? SortBy { get; init; } = "Name";
    public string? SortOrder { get; init; } = "asc";
}

public record UniversityVerificationRequest
{
    public Guid UniversityId { get; init; }
    public UniversityStatus Status { get; init; }
    public string? Comments { get; init; }
}

public record UniversityBulkStatusUpdateRequest
{
    public List<Guid> UniversityIds { get; init; } = new();
    public UniversityStatus Status { get; init; }
    public string? Comments { get; init; }
}

public record UniversitySearchResponse
{
    public List<UniversitySummaryDto> Universities { get; init; } = new();
    public int TotalCount { get; init; }
    public int Page { get; init; }
    public int PageSize { get; init; }
    public int TotalPages { get; init; }
}

public record UniversitySummaryDto
{
    public Guid Id { get; init; }
    public string Name { get; init; } = string.Empty;
    public string CountryName { get; init; } = string.Empty;
    public string? LogoUrl { get; init; }
    public UniversityStatus Status { get; init; }
    public AccreditationStatus AccreditationStatus { get; init; }
    public int EstablishedYear { get; init; }
    public string? Type { get; init; }
    public decimal? Ranking { get; init; }
    public int ProgramCount { get; init; }
    public DateTime CreatedAt { get; init; }
}
