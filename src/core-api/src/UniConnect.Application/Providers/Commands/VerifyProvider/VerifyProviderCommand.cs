using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Commands.VerifyProvider;

public class VerifyProviderCommand : IRequest<ProviderDto>
{
    public Guid ProviderId { get; set; }
    public bool IsApproved { get; set; }
    public string? Comments { get; set; }
    public Guid VerifiedByAdminId { get; set; }
}
