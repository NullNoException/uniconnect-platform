using MediatR;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Admin.Commands.ProviderManagement;

/// <summary>
/// Command to verify or reject a provider application
/// UC-3.1.1: Admin Verify Provider
/// </summary>
public record VerifyProviderCommand : IRequest<ProviderDto>
{
    public Guid ProviderId { get; init; }
    public ProviderVerificationStatus Status { get; init; }
    public string? VerificationNotes { get; init; }
    public string? RejectionReason { get; init; }
    public Guid AdminId { get; init; }
}

public record VerifyProviderRequest
{
    public ProviderVerificationStatus Status { get; init; }
    public string? VerificationNotes { get; init; }
    public string? RejectionReason { get; init; }
}
