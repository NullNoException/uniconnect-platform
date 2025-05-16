using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ServiceAttribute : BaseEntity
{
    public Guid ServiceId { get; set; }
    public string AttributeKey { get; set; } = string.Empty;
    public string AttributeValue { get; set; } = string.Empty;

    // Navigation property
    public Service Service { get; set; } = null!;
}
