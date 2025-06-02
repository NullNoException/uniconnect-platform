using UniConnect.Domain.Enums;

namespace UniConnect.Application.Providers.DTOs;

public class ProviderDto
{
    public Guid Id { get; set; }
    public string Email { get; set; } = string.Empty;
    public string CompanyName { get; set; } = string.Empty;
    public string ContactEmail { get; set; } = string.Empty;
    public string ContactPhone { get; set; } = string.Empty;
    public string? CompanyAddress { get; set; }
    public string? CompanyDescription { get; set; }
    public string? Website { get; set; }
    public string? TaxIdentificationNumber { get; set; }
    public string? BusinessRegistrationNumber { get; set; }
    public ProviderVerificationStatus VerificationStatus { get; set; }
    public DateTime? VerificationDate { get; set; }
    public Guid? VerifiedById { get; set; }
    public string? VerificationNotes { get; set; }
    public string? RejectionReason { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
