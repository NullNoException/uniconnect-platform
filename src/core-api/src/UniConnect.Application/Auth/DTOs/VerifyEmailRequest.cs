using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.Auth.DTOs;

public class VerifyEmailRequest
{
    [Required]
    [EmailAddress]
    public string Email { get; set; } = string.Empty;

    [Required]
    public string Token { get; set; } = string.Empty;
}
