using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ServicePriceComponent : BaseEntity
{
    public Guid ServiceId { get; set; }
    public string ComponentName { get; set; } = string.Empty;
    public string? ComponentDescription { get; set; }
    public decimal Price { get; set; }
    public bool IsOptional { get; set; }

    // Navigation property
    public Service Service { get; set; } = null!;
}
