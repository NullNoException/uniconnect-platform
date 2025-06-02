using MediatR;

namespace UniConnect.Application.Admin.Commands.SystemManagement;

/// <summary>
/// Command to configure platform settings
/// UC-3.4.1: Admin Configure Platform Settings
/// </summary>
public record ConfigurePlatformSettingsCommand : IRequest<PlatformSettingsDto>
{
    public Guid AdminId { get; init; }
    public string SettingCategory { get; init; } = string.Empty;
    public Dictionary<string, object> Settings { get; init; } = new();
}

public record ConfigurePlatformSettingsRequest
{
    public string SettingCategory { get; init; } = string.Empty;
    public Dictionary<string, object> Settings { get; init; } = new();
}

public class PlatformSettingsDto
{
    public string Category { get; set; } = string.Empty;
    public Dictionary<string, object> Settings { get; set; } = new();
    public DateTime LastModified { get; set; }
    public Guid ModifiedBy { get; set; }
}
