using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class FieldOfStudy : BaseEntity
{
    public string FieldName { get; set; } = string.Empty;
    public Guid? ParentFieldId { get; set; }

    // Navigation properties
    public FieldOfStudy? ParentField { get; set; }
    public ICollection<FieldOfStudy> ChildFields { get; private set; } = new List<FieldOfStudy>();
    public ICollection<Student> Students { get; private set; } = new List<Student>();
}
