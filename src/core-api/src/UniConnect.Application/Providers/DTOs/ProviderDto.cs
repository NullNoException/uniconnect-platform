namespace UniConnect.Application.Providers.DTOs;

public class ProviderDto
{
    public Guid Id { get; set; }
    public string Email { get; set; } = string.Empty;
    public string OrganizationName { get; set; } = string.Empty;
    public string ContactName { get; set; } = string.Empty;
    public string ContactPhone { get; set; } = string.Empty;
    public string? Website { get; set; }
    public string Status { get; set; } = string.Empty;
}
