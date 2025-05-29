using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.Auth.DTOs;

public class OAuthCallbackRequest
{
    [Required]
    public string Code { get; set; } = string.Empty;

    public string? State { get; set; }

    public string? RedirectUri { get; set; }

    [Required]
    public string Provider { get; set; } = string.Empty; // google, facebook, etc.
}
