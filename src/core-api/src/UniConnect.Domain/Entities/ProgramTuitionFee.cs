using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ProgramTuitionFee : BaseEntity
{
    public Guid ProgramId { get; set; }
    public Guid? ProviderId { get; set; }
    public decimal Amount { get; set; }
    public Guid CurrencyId { get; set; }
    public string FeeType { get; set; } = string.Empty; // Semester, Annual, Total, etc.
    public int? Semester { get; set; }
    public int? AcademicYear { get; set; }
    public DateTime EffectiveDate { get; set; }
    public DateTime? ExpiryDate { get; set; }
    public bool IsActive { get; set; } = true;
    public string? Notes { get; set; }

    // Navigation properties
    public AcademicProgram Program { get; set; } = null!;
    public ServiceProvider? Provider { get; set; }
    public Currency Currency { get; set; } = null!;
}
