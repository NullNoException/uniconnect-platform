using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ApiKey : BaseEntity
{
    public Guid EntityId { get; set; }
    public string EntityType { get; set; } = string.Empty;
    public string KeyValue { get; set; } = string.Empty;
    public string KeyName { get; set; } = string.Empty;
    public string Permissions { get; set; } = string.Empty;
    public DateTime? ExpiryDate { get; set; }
    public DateTime? LastUsedDate { get; set; }
    public bool IsActive { get; set; } = true;
}
