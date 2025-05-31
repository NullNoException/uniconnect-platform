using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Commands.StaffAccountManagement;

public record UpdateProviderStaffCommand : IRequest<ProviderStaffDto>
{
    public Guid StaffId { get; init; }
    public Guid ProviderId { get; init; }
    public string? FirstName { get; init; }
    public string? LastName { get; init; }
    public string? Role { get; init; }
    public string? Department { get; init; }
    public string? PhoneNumber { get; init; }
    public bool? IsActive { get; init; }
    public List<string>? Permissions { get; init; }
}
