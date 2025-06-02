using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Admin.Commands.FinancialManagement;

/// <summary>
/// Command to release escrow payment
/// UC-3.3.1: Admin Release Escrow Payment
/// </summary>
public record ReleaseEscrowPaymentCommand : IRequest<TransactionDto>
{
    public Guid TransactionId { get; init; }
    public Guid AdminId { get; init; }
    public string? ReleaseNotes { get; init; }
    public bool ForceRelease { get; init; } = false; // For disputed transactions
}

public record ReleaseEscrowPaymentRequest
{
    public string? ReleaseNotes { get; init; }
    public bool ForceRelease { get; init; } = false;
}
