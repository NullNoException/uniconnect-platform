using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Currency : BaseEntity
{
    public string CurrencyCode { get; set; } = string.Empty;
    public string CurrencyName { get; set; } = string.Empty;
    public string CurrencySymbol { get; set; } = string.Empty;
    public bool IsActive { get; set; } = true;

    // Navigation properties
    public ICollection<Service> Services { get; private set; } = new List<Service>();
    public ICollection<Transaction> Transactions { get; private set; } = new List<Transaction>();
    public ICollection<SubscriptionPlan> SubscriptionPlans { get; private set; } = new List<SubscriptionPlan>();
    public ICollection<Invoice> Invoices { get; private set; } = new List<Invoice>();
}
