using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Service : BaseEntity
{
    public Guid ProviderId { get; set; }
    public Guid CategoryId { get; set; }
    public string ServiceName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? ShortDescription { get; set; }
    public decimal BasePrice { get; set; }
    public Guid CurrencyId { get; set; }
    public int? EstimatedDeliveryDays { get; set; }
    public bool IsActive { get; set; } = true;
    public int? FeaturedRank { get; set; }
    public string? ThumbnailUrl { get; set; }

    // Navigation properties
    public ServiceProvider Provider { get; set; } = null!;
    public ServiceCategory Category { get; set; } = null!;
    public Currency Currency { get; set; } = null!;
    public ICollection<ServiceAttribute> Attributes { get; private set; } = new List<ServiceAttribute>();
    public ICollection<ServiceRequirement> Requirements { get; private set; } = new List<ServiceRequirement>();
    public ICollection<ServicePriceComponent> PriceComponents { get; private set; } = new List<ServicePriceComponent>();
    public ICollection<ServiceRequest> Requests { get; private set; } = new List<ServiceRequest>();
}
