using MediatR;
using UniConnect.Application.Admin.DTOs;

namespace UniConnect.Application.Admin.Commands.Financial;

/// <summary>
/// Command to release escrow payment
/// </summary>
public class ReleaseEscrowPaymentCommand : IRequest<TransactionDto>
{
    public Guid TransactionId { get; set; }
    public decimal ReleaseAmount { get; set; }
    public string? ReleaseReason { get; set; }
    public string? AdminNotes { get; set; }
    public Guid AdminId { get; set; }
}

/// <summary>
/// Request DTO for releasing escrow payment
/// </summary>
public class ReleaseEscrowPaymentRequest
{
    public decimal ReleaseAmount { get; set; }
    public string? ReleaseReason { get; set; }
    public string? AdminNotes { get; set; }
}
