using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class AcademicProgram : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public Guid UniversityId { get; set; }
    public Guid AcademicLevelId { get; set; }
    public Guid? MajorId { get; set; }
    public int DurationInSemesters { get; set; }
    public decimal? BaseTuitionFee { get; set; }
    public Guid? CurrencyId { get; set; }
    public ProgramStatus Status { get; set; } = ProgramStatus.Active;
    public string? Requirements { get; set; }
    public string? Highlights { get; set; }
    public DateTime? ApplicationDeadline { get; set; }
    public DateTime? StartDate { get; set; }
    public string? ProgramCode { get; set; }
    public int? CreditHours { get; set; }
    public string? Language { get; set; } = "English";
    public bool IsOnline { get; set; } = false;
    public bool IsPartTime { get; set; } = false;

    // Navigation properties
    public University University { get; set; } = null!;
    public AcademicLevel AcademicLevel { get; set; } = null!;
    public Major? Major { get; set; }
    public Currency? Currency { get; set; }
    public ICollection<ProgramTuitionFee> TuitionFees { get; private set; } = new List<ProgramTuitionFee>();
    public ICollection<ProviderProgramOffering> ProviderOfferings { get; private set; } = new List<ProviderProgramOffering>();
}
