using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class AcademicYear : BaseEntity
{
    public Guid AcademicCalendarId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public bool IsActive { get; set; } = true;
    public int Year { get; set; }

    // Navigation properties
    public AcademicCalendar AcademicCalendar { get; set; } = null!;
    public ICollection<Semester> Semesters { get; private set; } = new List<Semester>();
}
