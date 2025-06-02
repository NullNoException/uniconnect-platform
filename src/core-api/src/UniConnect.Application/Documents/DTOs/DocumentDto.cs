using UniConnect.Domain.Enums;

namespace UniConnect.Application.Documents.DTOs;

public class DocumentDto
{
    public Guid Id { get; set; }
    public string OriginalFileName { get; set; } = string.Empty;
    public string ContentType { get; set; } = string.Empty;
    public long FileSize { get; set; }
    public DocumentType DocumentType { get; set; }
    public DateTime CreatedAt { get; set; }
    public MalwareScanStatus MalwareScanStatus { get; set; }
}
