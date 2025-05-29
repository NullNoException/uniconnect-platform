using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.Auth.DTOs;

public class Enable2FARequest
{
    [Required]
    public string Password { get; set; } = string.Empty;
}

public class Verify2FASetupRequest
{
    [Required]
    public string Code { get; set; } = string.Empty;

    [Required]
    public string SecretKey { get; set; } = string.Empty;
}

public class TwoFactorSetupResponse
{
    public string SecretKey { get; set; } = string.Empty;
    public string QrCodeUrl { get; set; } = string.Empty;
    public string[] BackupCodes { get; set; } = Array.Empty<string>();
}

public class EnableTwoFactorResponse
{
    public string SecretKey { get; set; } = string.Empty;
    public string QrCodeUrl { get; set; } = string.Empty;
    public string[] BackupCodes { get; set; } = Array.Empty<string>();
    public bool IsEnabled { get; set; }
    public string ManualEntryKey { get; set; } = string.Empty;
}

public class VerifyTwoFactorRequest
{
    [Required]
    [StringLength(6, MinimumLength = 6, ErrorMessage = "Code must be exactly 6 digits")]
    [RegularExpression(@"^\d{6}$", ErrorMessage = "Code must be 6 digits")]
    public string Code { get; set; } = string.Empty;

    public bool RememberDevice { get; set; } = false;
}
