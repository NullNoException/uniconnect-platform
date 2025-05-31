using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Education : BaseEntity
{
    public Guid UserProfileId { get; set; }
    public string School { get; set; } = string.Empty;
    public string Degree { get; set; } = string.Empty;
    public string FieldOfStudy { get; set; } = string.Empty;
    public string StartYear { get; set; } = string.Empty;
    public string? EndYear { get; set; }
    public UserProfile UserProfile { get; set; } = null!;
}
