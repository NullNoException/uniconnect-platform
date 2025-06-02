using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.Admin.DTOs;

/// <summary>
/// DTO for transaction information
/// </summary>
public class TransactionDto : IMapFrom<Transaction>
{
    public Guid Id { get; set; }
    public string TransactionType { get; set; } = string.Empty;
    public decimal Amount { get; set; }
    public string Currency { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public Guid? ServiceRequestId { get; set; }
    public Guid? PaymentMethodId { get; set; }
    public string? PaymentProvider { get; set; }
    public string? ProviderTransactionId { get; set; }
    public Guid? StudentId { get; set; }
    public string StudentName { get; set; } = string.Empty;
    public Guid? ProviderId { get; set; }
    public string ProviderName { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public bool IsEscrow { get; set; }
    public decimal? EscrowReleaseAmount { get; set; }
    public DateTime? EscrowReleaseDate { get; set; }
    public string? EscrowReleaseReason { get; set; }
    public Guid? ReleasedByAdminId { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
