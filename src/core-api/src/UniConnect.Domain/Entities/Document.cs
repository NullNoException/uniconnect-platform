using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class Document : AuditableEntity
{
    public string FileName { get; set; } = string.Empty; // Name used in storage (e.g., GUID.ext)
    public string OriginalFileName { get; set; } = string.Empty; // Original user-provided file name
    public string ContentType { get; set; } = string.Empty;
    public long FileSize { get; set; } // In bytes
    public string StoragePath { get; set; } = string.Empty; // Bucket/ObjectKey or full path in MinIO
    public DocumentType DocumentType { get; set; } // <-- Only the enum, not an entity

    public Guid UploadedByUserId { get; set; }
    // public User UploadedByUser { get; set; } = null!; // Assuming User entity exists

    public MalwareScanStatus MalwareScanStatus { get; set; } = MalwareScanStatus.Pending;
    public string? VirusScanDetails { get; set; } // Details from the scan, if any

    // For sharing, we might have a separate DocumentShare entity or properties here
    // For now, focusing on upload.
}
