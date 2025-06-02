using MediatR;
using UniConnect.Application.Common.Models;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Admin.Queries.ProviderManagement;

/// <summary>
/// Query to get provider performance metrics
/// UC-3.1.2: Admin Monitor Provider Performance
/// </summary>
public record GetProviderPerformanceQuery : IRequest<PaginatedList<ProviderPerformanceDto>>
{
    public Guid? ProviderId { get; init; }
    public DateTime? DateFrom { get; init; }
    public DateTime? DateTo { get; init; }
    public int Page { get; init; } = 1;
    public int PageSize { get; init; } = 20;
    public string? SortBy { get; init; } = "CompanyName";
    public string? SortOrder { get; init; } = "asc";
}

public record GetProviderPerformanceRequest
{
    public Guid? ProviderId { get; init; }
    public DateTime? DateFrom { get; init; }
    public DateTime? DateTo { get; init; }
    public int Page { get; init; } = 1;
    public int PageSize { get; init; } = 20;
    public string? SortBy { get; init; } = "CompanyName";
    public string? SortOrder { get; init; } = "asc";
}
