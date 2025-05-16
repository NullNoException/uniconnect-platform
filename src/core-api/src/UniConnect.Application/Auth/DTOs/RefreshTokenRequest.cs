using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.Auth.DTOs;

public class RefreshTokenRequest
{
    [Required]
    public string RefreshToken { get; set; } = string.Empty;
}
