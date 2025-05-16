using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Message : BaseEntity
{
    public Guid ConversationId { get; set; }
    public Guid SenderId { get; set; }
    public Guid? RecipientId { get; set; }
    public string MessageContent { get; set; } = string.Empty;
    public string? AttachmentUrl { get; set; }
    public string ReadStatus { get; set; } = "Unread";
    public DateTime? ReadTimestamp { get; set; }

    // Navigation properties
    public Conversation Conversation { get; set; } = null!;
    public User Sender { get; set; } = null!;
    public User? Recipient { get; set; }
}
