using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Review : BaseEntity
{
    public Guid RequestId { get; set; }
    public Guid ReviewerId { get; set; }
    public Guid ReviewedEntityId { get; set; }
    public string ReviewedEntityType { get; set; } = string.Empty;
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public bool IsPublic { get; set; } = true;
    public DateTime? PublishedDate { get; set; }
    public Guid? ModeratedById { get; set; }
    public DateTime? ModerationDate { get; set; }
    public string ModerationStatus { get; set; } = "Pending";
    public Guid? ResponseId { get; set; }

    // Navigation properties
    public ServiceRequest Request { get; set; } = null!;
    public User Reviewer { get; set; } = null!;
    public User? ModeratedBy { get; set; }
    public ReviewResponse? Response { get; set; }
}
