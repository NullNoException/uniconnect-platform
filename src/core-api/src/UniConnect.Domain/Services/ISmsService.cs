namespace UniConnect.Domain.Services;

public interface ISmsService
{
    Task<bool> SendSmsAsync(string phoneNumber, string message, CancellationToken cancellationToken = default);
    Task<bool> SendBulkSmsAsync(IEnumerable<string> phoneNumbers, string message, CancellationToken cancellationToken = default);
    Task<bool> SendVerificationCodeAsync(string phoneNumber, string code, CancellationToken cancellationToken = default);
}
