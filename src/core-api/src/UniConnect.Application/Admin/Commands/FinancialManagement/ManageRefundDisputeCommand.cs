using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Admin.Commands.FinancialManagement;

/// <summary>
/// Command to manage refunds and disputes
/// UC-3.3.2: Admin Manage Refunds and Disputes
/// </summary>
public record ManageRefundDisputeCommand : IRequest<TransactionDto>
{
    public Guid TransactionId { get; init; }
    public Guid AdminId { get; init; }
    public RefundDisputeAction Action { get; init; }
    public decimal? RefundAmount { get; init; }
    public string Resolution { get; init; } = string.Empty;
    public string? Notes { get; init; }
}

public enum RefundDisputeAction
{
    ApproveRefund,
    RejectRefund,
    PartialRefund,
    ResolveDispute,
    EscalateDispute
}

public record ManageRefundDisputeRequest
{
    public RefundDisputeAction Action { get; init; }
    public decimal? RefundAmount { get; init; }
    public string Resolution { get; init; } = string.Empty;
    public string? Notes { get; init; }
}
