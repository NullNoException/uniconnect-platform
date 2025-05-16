using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Conversation : BaseEntity
{
    public Guid? RequestId { get; set; }
    public string ConversationType { get; set; } = string.Empty;
    public Guid? LastMessageId { get; set; }
    public DateTime LastActivityDate { get; set; } = DateTime.UtcNow;
    public string Status { get; set; } = "Active";

    // Navigation properties
    public ServiceRequest? Request { get; set; }
    public Message? LastMessage { get; set; }
    public ICollection<Message> Messages { get; private set; } = new List<Message>();
    public ICollection<ConversationParticipant> Participants { get; private set; } = new List<ConversationParticipant>();
}
