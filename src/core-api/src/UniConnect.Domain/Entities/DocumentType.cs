using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

// Remove or rename the DocumentType entity if not used for this feature, or clarify usage to avoid confusion with the enum.
// If you need both, consider renaming the entity to DocumentTypeEntity or similar.
// For now, ensure all usages in upload feature use the enum UniConnect.Domain.Enums.DocumentType only.

public class DocumentTypeEntity : BaseEntity
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
