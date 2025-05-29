using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class UniversityContact : BaseEntity
{
    public Guid UniversityId { get; set; }
    public string ContactType { get; set; } = string.Empty; // Admissions, General, Academic, etc.
    public string? Name { get; set; }
    public string? Email { get; set; }
    public string? Phone { get; set; }
    public string? Department { get; set; }
    public bool IsPrimary { get; set; } = false;
    public bool IsActive { get; set; } = true;

    // Navigation properties
    public University University { get; set; } = null!;
}
