using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.Auth.DTOs;

public class UserSessionDto
{
    public string SessionId { get; set; } = string.Empty;
    public string DeviceInfo { get; set; } = string.Empty;
    public string IpAddress { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public DateTime LastActivity { get; set; }
    public bool IsActive { get; set; }
    public string Location { get; set; } = string.Empty;
}

public class SessionsResponse
{
    public List<UserSessionDto> Sessions { get; set; } = new();
    public UserSessionDto? CurrentSession { get; set; }
}

public class SessionResponse
{
    public List<UserSessionDto> Sessions { get; set; } = new();
    public UserSessionDto? CurrentSession { get; set; }
    public int TotalSessions { get; set; }
    public int ActiveSessions { get; set; }
}

public class TerminateSessionRequest
{
    [Required]
    public string SessionId { get; set; } = string.Empty;

    public bool TerminateAllOtherSessions { get; set; } = false;
}
