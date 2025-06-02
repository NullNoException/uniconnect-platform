using UniConnect.Domain.Enums;

namespace UniConnect.Application.Providers.DTOs;

/// <summary>
/// DTO for provider performance metrics
/// Used in Admin Provider Management
/// </summary>
public class ProviderPerformanceDto
{
    public Guid ProviderId { get; set; }
    public string CompanyName { get; set; } = string.Empty;
    public string ContactEmail { get; set; } = string.Empty;
    public ProviderVerificationStatus VerificationStatus { get; set; }

    // Service metrics
    public int TotalServices { get; set; }
    public int ActiveServices { get; set; }

    // Application metrics
    public int TotalApplications { get; set; }
    public int CompletedApplications { get; set; }
    public int PendingApplications { get; set; }
    public int CancelledApplications { get; set; }

    // Performance metrics
    public double AverageCompletionTime { get; set; } // in days
    public decimal TotalRevenue { get; set; }
    public double CompletionRate => TotalApplications > 0 ? (double)CompletedApplications / TotalApplications * 100 : 0;
    public double CancellationRate => TotalApplications > 0 ? (double)CancelledApplications / TotalApplications * 100 : 0;

    // Activity metrics
    public DateTime LastActivityDate { get; set; }
    public DateTime CreatedAt { get; set; }
}
