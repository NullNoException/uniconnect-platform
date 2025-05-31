using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class CommunicationPreferences : BaseEntity
{
    public Guid UserProfileId { get; set; }
    public bool Email { get; set; }
    public bool Sms { get; set; }
    public bool WhatsApp { get; set; }
    public bool Telegram { get; set; }
    public UserProfile UserProfile { get; set; } = null!;
}
