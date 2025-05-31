using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Queries.ApplicationManagement;

public record GetProviderApplicationsQuery : IRequest<List<ServiceRequestDto>>
{
    public Guid ProviderId { get; init; }
    public string? Status { get; init; }
    public DateTime? DateFrom { get; init; }
    public DateTime? DateTo { get; init; }
    public int PageNumber { get; init; } = 1;
    public int PageSize { get; init; } = 10;
}
