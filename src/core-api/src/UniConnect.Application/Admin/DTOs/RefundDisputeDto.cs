using UniConnect.Application.Admin.Commands.FinancialManagement;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Admin.DTOs;

/// <summary>
/// DTO for refund dispute management operations
/// </summary>
public class RefundDisputeDto
{
    /// <summary>
    /// The ID of the transaction being disputed or refunded
    /// </summary>
    public Guid TransactionId { get; set; }

    /// <summary>
    /// The ID of the admin handling the dispute
    /// </summary>
    public Guid AdminId { get; set; }

    /// <summary>
    /// The action being taken on the refund/dispute
    /// </summary>
    public RefundDisputeAction Action { get; set; }

    /// <summary>
    /// The amount to refund (required for partial refunds)
    /// </summary>
    public decimal? RefundAmount { get; set; }

    /// <summary>
    /// Resolution details for the dispute
    /// </summary>
    public string Resolution { get; set; } = string.Empty;

    /// <summary>
    /// Additional notes from the admin
    /// </summary>
    public string Notes { get; set; } = string.Empty;

    /// <summary>
    /// Timestamp when the dispute was created
    /// </summary>
    public DateTime CreatedAt { get; set; }

    /// <summary>
    /// Timestamp when the dispute was last updated
    /// </summary>
    public DateTime? UpdatedAt { get; set; }

    /// <summary>
    /// Current status of the dispute
    /// </summary>
    public string Status { get; set; } = string.Empty;

    /// <summary>
    /// Original transaction amount
    /// </summary>
    public decimal OriginalAmount { get; set; }

    /// <summary>
    /// Service provider involved in the transaction
    /// </summary>
    public string ProviderName { get; set; } = string.Empty;

    /// <summary>
    /// Student involved in the transaction
    /// </summary>
    public string StudentName { get; set; } = string.Empty;

    /// <summary>
    /// Service name for the transaction
    /// </summary>
    public string ServiceName { get; set; } = string.Empty;

    /// <summary>
    /// Reason for the dispute/refund request
    /// </summary>
    public string DisputeReason { get; set; } = string.Empty;
}
