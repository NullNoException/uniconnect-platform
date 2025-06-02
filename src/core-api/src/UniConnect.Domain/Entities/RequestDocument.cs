using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class RequestDocument : BaseEntity
{
    public Guid RequestId { get; set; }
    public Guid DocumentTypeId { get; set; }
    public string DocumentName { get; set; } = string.Empty;
    public string FileUrl { get; set; } = string.Empty;
    public long FileSize { get; set; }
    public DateTime UploadDate { get; set; } = DateTime.UtcNow;
    public string Status { get; set; } = "Pending";
    public Guid? VerifiedById { get; set; }
    public DateTime? VerificationDate { get; set; }
    public string? VerificationNotes { get; set; }

    // Navigation properties
    public ServiceRequest Request { get; set; } = null!;
    public DocumentTypeEntity DocumentType { get; set; } = null!;
    public User? VerifiedBy { get; set; }
}
