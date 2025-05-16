using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class FeatureToggle : BaseEntity
{
    public string FeatureName { get; set; } = string.Empty;
    public bool IsEnabled { get; set; }
    public string? EnabledForUserIds { get; set; }
    public string? EnabledForUserTypes { get; set; }
    public int? EnabledForPercentage { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
}
