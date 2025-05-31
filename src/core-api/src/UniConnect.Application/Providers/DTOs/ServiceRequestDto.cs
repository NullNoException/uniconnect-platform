using UniConnect.Domain.Enums;

namespace UniConnect.Application.Providers.DTOs;

public class ServiceRequestDto
{
    public Guid Id { get; set; }
    public Guid StudentId { get; set; }
    public Guid ServiceId { get; set; }
    public string ServiceName { get; set; } = string.Empty;
    public string StudentName { get; set; } = string.Empty;
    public string StudentEmail { get; set; } = string.Empty;
    public ServiceRequestStatus RequestStatus { get; set; }
    public DateTime InitiatedDate { get; set; }
    public DateTime? RequiredByDate { get; set; }
    public DateTime? CompletedDate { get; set; }
    public DateTime? CancelledDate { get; set; }
    public string? CancellationReason { get; set; }
    public string? Notes { get; set; }
    public List<RequestDocumentDto> Documents { get; set; } = new();
    public List<RequestMilestoneDto> Milestones { get; set; } = new();
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}

public class RequestDocumentDto
{
    public Guid Id { get; set; }
    public Guid DocumentTypeId { get; set; }
    public string DocumentTypeName { get; set; } = string.Empty;
    public string DocumentName { get; set; } = string.Empty;
    public string FileUrl { get; set; } = string.Empty;
    public long FileSize { get; set; }
    public DateTime UploadDate { get; set; }
    public string Status { get; set; } = string.Empty;
    public Guid? VerifiedById { get; set; }
    public DateTime? VerificationDate { get; set; }
    public string? VerificationNotes { get; set; }
}

public class RequestMilestoneDto
{
    public Guid Id { get; set; }
    public string MilestoneName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime? DueDate { get; set; }
    public DateTime? CompletionDate { get; set; }
    public string Status { get; set; } = string.Empty;
}
