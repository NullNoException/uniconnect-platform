using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class User : AuditableEntity
{
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public UserType UserType { get; set; }
    public UserStatus Status { get; set; } = UserStatus.Pending;
    public DateTime? LastLoginDate { get; set; }

    // Navigation properties
    public UserProfile? Profile { get; set; }
    public Student? Student { get; set; }
    public ServiceProvider? ServiceProvider { get; set; }
    public Admin? Admin { get; set; }
    public ICollection<Address> Addresses { get; private set; } = new List<Address>();
    public ICollection<PaymentMethod> PaymentMethods { get; private set; } = new List<PaymentMethod>();
    public ICollection<CommunicationChannelPreference> CommunicationPreferences { get; private set; } = new List<CommunicationChannelPreference>();
}
