using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class SystemLog : BaseEntity
{
    public string LogLevel { get; set; } = string.Empty;
    public string LogCategory { get; set; } = string.Empty;
    public string LogMessage { get; set; } = string.Empty;
    public string? ExceptionDetails { get; set; }
    public Guid? UserId { get; set; }
    public string? UserIP { get; set; }
    public string? UserAgent { get; set; }
    public string? RequestUrl { get; set; }
    public string? RequestMethod { get; set; }
    public string? RequestPayload { get; set; }
    public int? ResponseCode { get; set; }
    public long? ExecutionTimeMs { get; set; }

    // Navigation property
    public User? User { get; set; }
}
