using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ServiceRequirement : BaseEntity
{
    public Guid ServiceId { get; set; }
    public string RequirementName { get; set; } = string.Empty;
    public string? RequirementDescription { get; set; }
    public bool IsMandatory { get; set; }
    public Guid? DocumentTypeId { get; set; }

    // Navigation properties
    public Service Service { get; set; } = null!;
    public DocumentTypeEntity? DocumentType { get; set; }
}
