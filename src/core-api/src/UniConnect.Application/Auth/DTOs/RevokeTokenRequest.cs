using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.Auth.DTOs;

public class RevokeTokenRequest
{
    [Required]
    public string Token { get; set; } = string.Empty;

    public string TokenType { get; set; } = "refresh_token"; // access_token or refresh_token
}
