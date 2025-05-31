using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Queries.StaffAccountManagement;

public record GetProviderStaffQuery : IRequest<List<ProviderStaffDto>>
{
    public Guid ProviderId { get; init; }
    public bool? IsActive { get; init; }
    public string? Role { get; init; }
    public string? Department { get; init; }
}
