using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.Auth.DTOs;

public class ValidateTokenRequest
{
    [Required]
    public string Token { get; set; } = string.Empty;
}
