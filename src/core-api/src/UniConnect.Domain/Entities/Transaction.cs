using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Transaction : BaseEntity
{
    public Guid RequestId { get; set; }
    public string TransactionType { get; set; } = string.Empty;
    public decimal Amount { get; set; }
    public Guid CurrencyId { get; set; }
    public decimal? ExchangeRate { get; set; }
    public string Status { get; set; } = "Pending";
    public Guid? PaymentMethodId { get; set; }
    public string? PaymentGatewayTransactionId { get; set; }
    public DateTime? EscrowReleaseDate { get; set; }
    public decimal PlatformFeeAmount { get; set; }
    public decimal ProviderAmount { get; set; }

    // Navigation properties
    public ServiceRequest Request { get; set; } = null!;
    public Currency Currency { get; set; } = null!;
    public PaymentMethod? PaymentMethod { get; set; }
}
