using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Commands.StaffAccountManagement;

public class CreateProviderStaffCommand : IRequest<ProviderStaffDto>
{
    public Guid ProviderId { get; set; }
    public string Email { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? PhoneNumber { get; set; }
    public string? Position { get; set; }
    public Guid? SupervisorId { get; set; }
}
