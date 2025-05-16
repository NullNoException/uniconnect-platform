using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class ServiceProvider : BaseEntity
{
    public Guid UserId { get; set; }
    public string CompanyName { get; set; } = string.Empty;
    public string? RegistrationNumber { get; set; }
    public ProviderVerificationStatus VerificationStatus { get; set; } = ProviderVerificationStatus.Pending;
    public Guid? VerifiedById { get; set; }
    public DateTime? VerificationDate { get; set; }
    public string? CompanyLogoUrl { get; set; }
    public string? CompanyWebsite { get; set; }
    public int? YearsInBusiness { get; set; }
    public Guid? SubscriptionPlanId { get; set; }
    public DateTime? SubscriptionStartDate { get; set; }
    public DateTime? SubscriptionEndDate { get; set; }
    public Guid? BillingAddressId { get; set; }
    public string? TaxIdentificationNumber { get; set; }

    // Navigation properties
    public User User { get; set; } = null!;
    public User? VerifiedBy { get; set; }
    public SubscriptionPlan? SubscriptionPlan { get; set; }
    public Address? BillingAddress { get; set; }
    public ICollection<ProviderStaff> Staff { get; private set; } = new List<ProviderStaff>();
    public ICollection<Service> Services { get; private set; } = new List<Service>();
}
