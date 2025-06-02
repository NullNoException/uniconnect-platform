using UniConnect.Domain.Enums;

namespace UniConnect.Application.Services.DTOs;

public class ServiceDto
{
    public Guid Id { get; set; }
    public string ServiceName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? ShortDescription { get; set; }
    public Guid ProviderId { get; set; }
    public Guid CategoryId { get; set; }
    public bool IsActive { get; set; }
    public decimal BasePrice { get; set; }
    public Guid CurrencyId { get; set; }
    public int? EstimatedDeliveryDays { get; set; }
    public string? ThumbnailUrl { get; set; }

    // Approval properties
    public ServiceApprovalStatus ApprovalStatus { get; set; }
    public DateTime? ApprovalDate { get; set; }
    public Guid? ApprovedById { get; set; }
    public string? ApprovalNotes { get; set; }
    public string? RejectionReason { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
