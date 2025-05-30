using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Net;
using System.Net.Mail;
using UniConnect.Domain.Services;

namespace UniConnect.Infrastructure.Services;

public class EmailService : IEmailService
{
    private readonly EmailSettings _emailSettings;
    private readonly ILogger<EmailService> _logger;

    public EmailService(IOptions<EmailSettings> emailSettings, ILogger<EmailService> logger)
    {
        _emailSettings = emailSettings.Value;
        _logger = logger;
    }

    public async Task SendEmailAsync(string to, string subject, string body, bool isHtml = true, CancellationToken cancellationToken = default)
    {
        try
        {
            using var client = CreateSmtpClient();
            using var message = new MailMessage
            {
                From = new MailAddress(_emailSettings.FromEmail, _emailSettings.FromName),
                Subject = subject,
                Body = body,
                IsBodyHtml = isHtml
            };

            message.To.Add(to);
            await client.SendMailAsync(message, cancellationToken);
            _logger.LogInformation("Email sent to {Recipient} with subject '{Subject}'", to, subject);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send email to {Recipient} with subject '{Subject}'", to, subject);
            throw;
        }
    }

    public async Task SendTemplatedEmailAsync(string to, string templateName, object templateData, CancellationToken cancellationToken = default)
    {
        try
        {
            // In a real implementation, this would load and render a template with the provided data
            var subject = $"UniConnect: {templateName}";
            var body = $"<h1>Template: {templateName}</h1><p>Hello, this is a templated email. Data: {templateData}</p>";

            await SendEmailAsync(to, subject, body, true, cancellationToken);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send templated email '{TemplateName}' to {Recipient}", templateName, to);
            throw;
        }
    }

    public async Task SendBulkEmailAsync(IEnumerable<string> recipients, string subject, string body, bool isHtml = true, CancellationToken cancellationToken = default)
    {
        try
        {
            using var client = CreateSmtpClient();

            foreach (var recipient in recipients)
            {
                using var message = new MailMessage
                {
                    From = new MailAddress(_emailSettings.FromEmail, _emailSettings.FromName),
                    Subject = subject,
                    Body = body,
                    IsBodyHtml = isHtml
                };

                message.To.Add(recipient);
                await client.SendMailAsync(message, cancellationToken);
            }

            _logger.LogInformation("Bulk email sent to {RecipientCount} recipients with subject '{Subject}'", recipients.Count(), subject);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send bulk email with subject '{Subject}' to {RecipientCount} recipients", subject, recipients.Count());
            throw;
        }
    }

    public async Task SendVerificationEmailAsync(string email, string token)
    {
        var subject = "Verify your UniConnect account";
        var body = $"<p>Please verify your email by clicking <a href='https://uniconnect.com/verify?token={token}'>here</a>.</p>";
        await SendEmailAsync(email, subject, body);
    }

    private SmtpClient CreateSmtpClient()
    {
        return new SmtpClient(_emailSettings.SmtpServer, _emailSettings.SmtpPort)
        {
            EnableSsl = _emailSettings.EnableSsl,
            UseDefaultCredentials = false,
            Credentials = new NetworkCredential(_emailSettings.SmtpUsername, _emailSettings.SmtpPassword)
        };
    }
}

public class EmailSettings
{
    public string SmtpServer { get; set; } = string.Empty;
    public int SmtpPort { get; set; }
    public string SmtpUsername { get; set; } = string.Empty;
    public string SmtpPassword { get; set; } = string.Empty;
    public bool EnableSsl { get; set; }
    public string FromEmail { get; set; } = string.Empty;
    public string FromName { get; set; } = string.Empty;
}
