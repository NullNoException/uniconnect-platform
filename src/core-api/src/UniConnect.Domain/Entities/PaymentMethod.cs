using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class PaymentMethod : BaseEntity
{
    public Guid UserId { get; set; }
    public string MethodType { get; set; } = string.Empty;
    public string AccountName { get; set; } = string.Empty;
    public string MaskedAccountNumber { get; set; } = string.Empty;
    public DateTime? ExpiryDate { get; set; }
    public bool IsDefault { get; set; }
    public string? PaymentGatewayCustomerId { get; set; }
    public string? PaymentGatewayToken { get; set; }

    // Navigation properties
    public User User { get; set; } = null!;
    public ICollection<Transaction> Transactions { get; private set; } = new List<Transaction>();
}
