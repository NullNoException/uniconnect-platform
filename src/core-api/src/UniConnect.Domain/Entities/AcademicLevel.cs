using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class AcademicLevel : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int Order { get; set; } // For ordering: Bachelor=1, Master=2, PhD=3, etc.
    public bool IsActive { get; set; } = true;
    public string? Code { get; set; } // Bachelor, Master, PhD, etc.

    // Navigation properties
    public ICollection<AcademicProgram> AcademicPrograms { get; private set; } = new List<AcademicProgram>();
}
