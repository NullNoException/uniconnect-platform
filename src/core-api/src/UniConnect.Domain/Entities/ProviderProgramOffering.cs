using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class ProviderProgramOffering : BaseEntity
{
    public Guid ProviderId { get; set; }
    public Guid ProgramId { get; set; }
    public string? ServiceDescription { get; set; }
    public string? MarketingContent { get; set; }
    public string? EntryRequirements { get; set; }
    public string? ProgramHighlights { get; set; }
    public OfferingStatus Status { get; set; } = OfferingStatus.Active;
    public DateTime? ActivationDate { get; set; }
    public DateTime? DeactivationDate { get; set; }
    public bool IsPromoted { get; set; } = false;
    public int DisplayOrder { get; set; } = 0;

    // Navigation properties
    public ServiceProvider Provider { get; set; } = null!;
    public AcademicProgram Program { get; set; } = null!;
    public ICollection<ProgramTuitionFee> CustomTuitionFees { get; private set; } = new List<ProgramTuitionFee>();
}
