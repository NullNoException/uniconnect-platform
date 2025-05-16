using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ReviewResponse : BaseEntity
{
    public Guid ReviewId { get; set; }
    public Guid ResponderId { get; set; }
    public string Response { get; set; } = string.Empty;
    public DateTime ResponseDate { get; set; } = DateTime.UtcNow;
    public Guid? ModeratedById { get; set; }
    public DateTime? ModerationDate { get; set; }
    public string ModerationStatus { get; set; } = "Pending";

    // Navigation properties
    public Review Review { get; set; } = null!;
    public User Responder { get; set; } = null!;
    public User? ModeratedBy { get; set; }
}
