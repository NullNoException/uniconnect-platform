namespace UniConnect.Application.Providers.DTOs;

public class ProviderEarningsDto
{
    public Guid ProviderId { get; set; }
    public decimal TotalEarnings { get; set; }
    public decimal PendingEarnings { get; set; }
    public decimal AvailableForWithdrawal { get; set; }
    public decimal ThisMonthEarnings { get; set; }
    public decimal LastMonthEarnings { get; set; }
    public List<EarningsBreakdownDto> EarningsBreakdown { get; set; } = new();
    public List<TransactionDto> RecentTransactions { get; set; } = new();
}

public class EarningsBreakdownDto
{
    public Guid ServiceId { get; set; }
    public string ServiceName { get; set; } = string.Empty;
    public decimal TotalEarnings { get; set; }
    public int CompletedRequests { get; set; }
    public decimal AverageOrderValue { get; set; }
}

public class TransactionDto
{
    public Guid Id { get; set; }
    public Guid? RequestId { get; set; }
    public Guid? ServiceRequestId { get; set; }
    public Guid? StudentId { get; set; }
    public Guid? ProviderId { get; set; }
    public string TransactionType { get; set; } = string.Empty;
    public decimal Amount { get; set; }
    public string CurrencyCode { get; set; } = string.Empty;
    public string Currency { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public DateTime TransactionDate { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? ProcessedDate { get; set; }
    public string? PaymentMethod { get; set; }
    public string? Description { get; set; }
    public string? Notes { get; set; }
    public string? ServiceName { get; set; }
    public string? StudentName { get; set; }
}

public class PaymentMethodDto
{
    public Guid Id { get; set; }
    public string MethodType { get; set; } = string.Empty;
    public string? AccountNumber { get; set; }
    public string? BankName { get; set; }
    public string? PayPalEmail { get; set; }
    public bool IsDefault { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class EscrowReleaseDto
{
    public Guid TransactionId { get; set; }
    public Guid RequestId { get; set; }
    public decimal Amount { get; set; }
    public string CurrencyCode { get; set; } = string.Empty;
    public DateTime ReleaseDate { get; set; }
    public string ServiceName { get; set; } = string.Empty;
    public string StudentName { get; set; } = string.Empty;
}
