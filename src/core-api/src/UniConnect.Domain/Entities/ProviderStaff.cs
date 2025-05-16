using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ProviderStaff : BaseEntity
{
    public Guid UserId { get; set; }
    public Guid ProviderId { get; set; }
    public string Position { get; set; } = string.Empty;
    public string Permissions { get; set; } = string.Empty;
    public Guid? SupervisorId { get; set; }

    // Navigation properties
    public User User { get; set; } = null!;
    public ServiceProvider Provider { get; set; } = null!;
    public ProviderStaff? Supervisor { get; set; }
    public ICollection<ProviderStaff> Subordinates { get; private set; } = new List<ProviderStaff>();
}
