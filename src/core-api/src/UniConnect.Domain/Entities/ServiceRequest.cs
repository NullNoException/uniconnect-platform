using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class ServiceRequest : BaseEntity
{
    public Guid StudentId { get; set; }
    public Guid ServiceId { get; set; }
    public ServiceRequestStatus RequestStatus { get; set; } = ServiceRequestStatus.Draft;
    public DateTime InitiatedDate { get; set; } = DateTime.UtcNow;
    public DateTime? RequiredByDate { get; set; }
    public DateTime? CompletedDate { get; set; }
    public DateTime? CancelledDate { get; set; }
    public string? CancellationReason { get; set; }
    public string? Notes { get; set; }

    // Navigation properties
    public Student Student { get; set; } = null!;
    public Service Service { get; set; } = null!;
    public ICollection<RequestDocument> Documents { get; private set; } = new List<RequestDocument>();
    public ICollection<RequestMilestone> Milestones { get; private set; } = new List<RequestMilestone>();
    public ICollection<Transaction> Transactions { get; private set; } = new List<Transaction>();
    public ICollection<Conversation> Conversations { get; private set; } = new List<Conversation>();
    public ICollection<Review> Reviews { get; private set; } = new List<Review>();
}
