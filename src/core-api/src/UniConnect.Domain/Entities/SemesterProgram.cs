using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class SemesterProgram : BaseEntity
{
    public Guid SemesterId { get; set; }
    public Guid ProgramId { get; set; }  // Changed from AcademicProgramId to ProgramId
    public bool IsActive { get; set; } = true;
    public int AvailableSeats { get; set; }
    public string? Notes { get; set; }

    // Navigation properties
    public Semester Semester { get; set; } = null!;
    public AcademicProgram Program { get; set; } = null!;  // Changed from AcademicProgram to Program
}
