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

    // Navigation property
    public User User { get; set; } = null!;

    // Full name computed property
    public string FullName => $"{FirstName} {LastName}";
}
