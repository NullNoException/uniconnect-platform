using Microsoft.Extensions.Logging;
using UniConnect.Domain.Services;

namespace UniConnect.Infrastructure.Services;

public class SmsService : ISmsService
{
    private readonly ILogger<SmsService> _logger;

    public SmsService(ILogger<SmsService> logger)
    {
        _logger = logger;
    }

    public Task<bool> SendSmsAsync(string phoneNumber, string message, CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Sending SMS to {PhoneNumber}: {Message}", phoneNumber, message);
        // Implementation would go here - for now just logging
        return Task.FromResult(true);
    }

    public Task<bool> SendBulkSmsAsync(IEnumerable<string> phoneNumbers, string message, CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Sending bulk SMS to {PhoneNumberCount} recipients: {Message}",
            phoneNumbers.Count(), message);
        // Implementation would go here - for now just logging
        return Task.FromResult(true);
    }

    public Task<bool> SendVerificationCodeAsync(string phoneNumber, string code, CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Sending verification code to {PhoneNumber}: {Code}", phoneNumber, code);
        // Implementation would go here - for now just logging
        return Task.FromResult(true);
    }
}
