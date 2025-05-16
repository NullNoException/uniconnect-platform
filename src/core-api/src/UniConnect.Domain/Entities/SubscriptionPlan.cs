using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class SubscriptionPlan : BaseEntity
{
    public string PlanName { get; set; } = string.Empty;
    public string? PlanDescription { get; set; }
    public decimal MonthlyPrice { get; set; }
    public decimal? AnnualPrice { get; set; }
    public Guid CurrencyId { get; set; }
    public decimal CommissionPercentage { get; set; }
    public int MaxServiceListings { get; set; }
    public bool IncludesFeaturedListings { get; set; }
    public int? FeaturedListingsCount { get; set; }
    public bool IncludesAPI { get; set; }
    public int MaxStaffAccounts { get; set; }
    public bool IsActive { get; set; } = true;

    // Navigation properties
    public Currency Currency { get; set; } = null!;
    public ICollection<ServiceProvider> ServiceProviders { get; private set; } = new List<ServiceProvider>();
}
