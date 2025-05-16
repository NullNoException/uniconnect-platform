using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class CommunicationChannelPreference : BaseEntity
{
    public Guid UserId { get; set; }
    public string NotificationType { get; set; } = string.Empty;
    public bool EmailEnabled { get; set; } = true;
    public bool PushEnabled { get; set; } = false;
    public bool SMSEnabled { get; set; } = false;
    public bool InAppEnabled { get; set; } = true;
    public bool WhatsAppEnabled { get; set; } = false;
    public bool TelegramEnabled { get; set; } = false;

    // Navigation property
    public User User { get; set; } = null!;
}
