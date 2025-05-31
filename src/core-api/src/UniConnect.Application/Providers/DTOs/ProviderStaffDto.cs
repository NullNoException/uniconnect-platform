namespace UniConnect.Application.Providers.DTOs;

public class ProviderStaffDto
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public Guid ProviderId { get; set; }
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public string? PhoneNumber { get; set; }
    public string? Position { get; set; } = string.Empty;
    public string? Role { get; set; } = string.Empty;
    public string? Department { get; set; } = string.Empty;
    public bool IsActive { get; set; } = true;
    public string Permissions { get; set; } = string.Empty;
    public Guid? SupervisorId { get; set; }
    public string? UserName { get; set; }
    public string? Email { get; set; }
    public string? SupervisorName { get; set; }
    public DateTime? CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
