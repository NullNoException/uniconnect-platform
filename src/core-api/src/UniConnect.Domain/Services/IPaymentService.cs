namespace UniConnect.Domain.Services;

public interface IPaymentService
{
    Task<(bool Success, string? TransactionId, string? ErrorMessage)> ProcessPaymentAsync(
        decimal amount,
        string currency,
        string paymentMethodId,
        string description,
        Dictionary<string, string> metadata,
        CancellationToken cancellationToken = default);

    Task<bool> RefundPaymentAsync(string transactionId, decimal? amount = null, CancellationToken cancellationToken = default);

    Task<bool> CreateEscrowAsync(string transactionId, DateTime? releaseDate = null, CancellationToken cancellationToken = default);

    Task<bool> ReleaseEscrowAsync(string transactionId, CancellationToken cancellationToken = default);
}
