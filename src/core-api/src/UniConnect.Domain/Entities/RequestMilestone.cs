using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class RequestMilestone : BaseEntity
{
    public Guid RequestId { get; set; }
    public string MilestoneName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime? DueDate { get; set; }
    public DateTime? CompletionDate { get; set; }
    public string Status { get; set; } = "Pending";

    // Navigation property
    public ServiceRequest Request { get; set; } = null!;
}
