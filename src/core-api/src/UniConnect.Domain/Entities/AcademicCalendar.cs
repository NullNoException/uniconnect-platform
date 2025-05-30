using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class AcademicCalendar : BaseEntity
{
    public Guid UniversityId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }

    // Navigation properties
    public University University { get; set; } = null!;
    public ICollection<AcademicYear> AcademicYears { get; private set; } = new List<AcademicYear>();
}
