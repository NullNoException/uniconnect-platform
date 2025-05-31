namespace UniConnect.Domain.Services;

public interface IEmailService
{
    Task SendEmailAsync(string to, string subject, string body, bool isHtml = true, CancellationToken cancellationToken = default);
    Task SendTemplatedEmailAsync(string to, string templateName, object templateData, CancellationToken cancellationToken = default);
    Task SendBulkEmailAsync(IEnumerable<string> recipients, string subject, string body, bool isHtml = true, CancellationToken cancellationToken = default);
    Task SendVerificationEmailAsync(string email, string token);
}
