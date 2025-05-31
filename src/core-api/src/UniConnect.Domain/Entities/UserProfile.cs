using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class UserProfile : BaseEntity
{
    public Guid UserId { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? PhoneNumber { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string? ProfilePictureUrl { get; set; }
    public string PreferredLanguage { get; set; } = "en";

    // Extended fields for admin model
    public string? EducationsJson { get; set; } // JSON serialized list of educations
    public string? TargetCountries { get; set; } // Comma-separated
    public string? EducationGoals { get; set; } // Comma-separated
    public string? CommunicationPreferencesJson { get; set; } // JSON serialized preferences

    // Navigation property
    public User User { get; set; } = null!;
    public ICollection<Education> Educations { get; private set; } = new List<Education>();
    public CommunicationPreferences? CommunicationPreferences { get; set; }

    // Full name computed property
    public string FullName => $"{FirstName} {LastName}";
}
