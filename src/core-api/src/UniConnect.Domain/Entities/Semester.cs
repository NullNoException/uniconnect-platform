using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class Semester : BaseEntity
{
    public Guid AcademicYearId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public SemesterStatus Status { get; set; } = SemesterStatus.Upcoming;
    public int Order { get; set; } // Used for ordering semesters within an academic year (1, 2, 3, etc.)

    // Navigation properties
    public AcademicYear AcademicYear { get; set; } = null!;
    public ICollection<Deadline> Deadlines { get; private set; } = new List<Deadline>();
    public ICollection<AcademicProgram> AvailablePrograms { get; private set; } = new List<AcademicProgram>();
    public ICollection<SemesterProgram> SemesterPrograms { get; private set; } = new List<SemesterProgram>();
}
