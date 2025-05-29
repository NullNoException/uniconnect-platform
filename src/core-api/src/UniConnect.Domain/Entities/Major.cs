using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Major : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public Guid? ParentMajorId { get; set; }
    public bool IsActive { get; set; } = true;
    public string? Code { get; set; }
    public int Level { get; set; } = 1; // For hierarchical organization

    // Navigation properties
    public Major? ParentMajor { get; set; }
    public ICollection<Major> SubMajors { get; private set; } = new List<Major>();
    public ICollection<AcademicProgram> AcademicPrograms { get; private set; } = new List<AcademicProgram>();
}
