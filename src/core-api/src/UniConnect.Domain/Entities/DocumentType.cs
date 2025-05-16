using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class DocumentType : BaseEntity
{
    public string TypeName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? AllowedFileExtensions { get; set; }
    public int MaxFileSizeMB { get; set; }
    public bool IsPersonalId { get; set; }
    public bool IsEducational { get; set; }

    // Navigation properties
    public ICollection<ServiceRequirement> ServiceRequirements { get; private set; } = new List<ServiceRequirement>();
    public ICollection<RequestDocument> RequestDocuments { get; private set; } = new List<RequestDocument>();
}
