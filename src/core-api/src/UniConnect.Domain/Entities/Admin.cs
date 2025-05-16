using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Admin : BaseEntity
{
    public Guid UserId { get; set; }
    public string Role { get; set; } = string.Empty;
    public string Department { get; set; } = string.Empty;

    // Navigation property
    public User User { get; set; } = null!;
}
