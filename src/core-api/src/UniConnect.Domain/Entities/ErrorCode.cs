using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ErrorCode : BaseEntity
{
    public string Code { get; set; } = string.Empty;
    public string ErrorDomain { get; set; } = string.Empty;
    public string ErrorDescription { get; set; } = string.Empty;
    public string? SuggestedAction { get; set; }
    public string Severity { get; set; } = "Error";
    public bool IsUserFacing { get; set; } = true;
}
