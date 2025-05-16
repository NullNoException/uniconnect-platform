using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Student : BaseEntity
{
    public Guid UserId { get; set; }
    public string? CurrentEducationLevel { get; set; }
    public Guid? CurrentUniversityId { get; set; }
    public string? TargetEducationLevel { get; set; }
    public Guid? FieldOfStudyId { get; set; }
    public string? PreferredCountries { get; set; }
    public DateTime? StudyStartDate { get; set; }

    // Navigation properties
    public User User { get; set; } = null!;
    public University? CurrentUniversity { get; set; }
    public FieldOfStudy? FieldOfStudy { get; set; }
    public ICollection<ServiceRequest> ServiceRequests { get; private set; } = new List<ServiceRequest>();
}
