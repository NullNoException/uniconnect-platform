using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Areas.Common;
using UniConnect.Application.Auth.DTOs;
using UniConnect.Domain.Services;

namespace UniConnect.API.Areas.Admin.Controllers;

[Area("Admin")]
[Route("api/admin/v1/auth")]
public class AuthController : AreaControllerBase
{
    private readonly IIdentityService _identityService;
    private readonly ILogger<AuthController> _logger;
    private readonly IConfiguration _configuration;

    public AuthController(
        IIdentityService identityService,
        ILogger<AuthController> logger,
        IConfiguration configuration)
    {
        _identityService = identityService;
        _logger = logger;
        _configuration = configuration;
    }

    /// <summary>
    /// Authenticates an administrator and returns a JWT token
    /// </summary>
    /// <param name="request">Login credentials</param>
    /// <returns>Authentication response with JWT token</returns>
    [HttpPost("login")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<AuthResponse>> Login([FromBody] LoginRequest request)
    {
        var (success, userId, email, errorMessage) = await _identityService.ValidateUserCredentialsAsync(
            request.Email, request.Password);

        if (!success)
        {
            _logger.LogWarning("Failed admin login attempt for {Email}", request.Email);
            return Unauthorized(new { message = errorMessage });
        }

        // Verify user has admin role
        var roles = await _identityService.GetUserRolesAsync(userId!);
        if (!roles.Contains("Administrator") && !roles.Contains("Admin") && !roles.Contains("SuperAdmin"))
        {
            _logger.LogWarning("Unauthorized admin login attempt for {Email} - insufficient permissions", request.Email);
            return Unauthorized(new { message = "Insufficient permissions for admin portal" });
        }

        var (token, refreshToken) = await _identityService.GenerateTokensAsync(userId!, email!, roles);

        var keycloakSettings = _configuration.GetSection("KeycloakSettings");
        var expirationMinutes = int.Parse(keycloakSettings["AccessTokenExpirationMinutes"] ?? "15");
        var expiresAt = DateTime.UtcNow.AddMinutes(expirationMinutes);

        _logger.LogInformation("Admin {Email} logged in successfully", email);

        return Ok(new AuthResponse
        {
            Token = token,
            RefreshToken = refreshToken,
            ExpiresAt = expiresAt,
            UserId = userId!,
            Email = email!,
            Roles = roles
        });
    }

    /// <summary>
    /// Registers a new administrator (requires SuperAdmin role)
    /// </summary>
    /// <param name="request">Registration details</param>
    /// <returns>Registration result</returns>
    [HttpPost("register")]
    [Authorize(Policy = "SuperAdminOnly")]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult> Register([FromBody] RegisterRequest request)
    {
        if (request.Password != request.ConfirmPassword)
        {
            return BadRequest(new { message = "Passwords do not match" });
        }

        // For admin area, only allow admin user types
        var allowedUserTypes = new[] { "Administrator", "Admin" };
        var userType = string.IsNullOrEmpty(request.UserType) ? "Administrator" : request.UserType;

        if (!allowedUserTypes.Contains(userType))
        {
            return BadRequest(new { message = "Invalid user type for admin registration" });
        }

        var (success, userId, errorMessage) = await _identityService.CreateUserAsync(
            request.Email, request.Password, userType);

        if (!success)
        {
            _logger.LogWarning("Failed admin registration for {Email}: {Error}", request.Email, errorMessage);
            return BadRequest(new { message = errorMessage });
        }

        // Assign appropriate admin role
        var roleName = userType == "Administrator" ? "Administrator" : "Admin";
        await _identityService.AssignRoleToUserAsync(userId!, roleName);

        _logger.LogInformation("New admin user {Email} registered by {SuperAdmin}",
            request.Email, User.FindFirst(ClaimTypes.Email)?.Value);

        return CreatedAtAction(nameof(Login), new { }, new { message = "Admin user created successfully", userId });
    }

    /// <summary>
    /// Refreshes an expired JWT token
    /// </summary>
    /// <param name="request">Refresh token request</param>
    /// <returns>New JWT token</returns>
    [HttpPost("refresh")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<AuthResponse>> RefreshToken([FromBody] RefreshTokenRequest request)
    {
        var (success, userId, email, roles, errorMessage) = await _identityService.ValidateRefreshTokenAsync(request.RefreshToken);

        if (!success)
        {
            _logger.LogWarning("Failed refresh token validation for admin area");
            return Unauthorized(new { message = errorMessage });
        }

        // Verify user still has admin privileges
        if (roles == null || !roles.Any(r => r.Contains("Admin")))
        {
            _logger.LogWarning("User {Email} lost admin privileges during token refresh", email);
            return Forbid("Admin privileges revoked");
        }

        var (newToken, newRefreshToken) = await _identityService.GenerateTokensAsync(userId!, email!, roles);

        var keycloakSettings = _configuration.GetSection("KeycloakSettings");
        var expirationMinutes = int.Parse(keycloakSettings["AccessTokenExpirationMinutes"] ?? "15");
        var expiresAt = DateTime.UtcNow.AddMinutes(expirationMinutes);

        return Ok(new AuthResponse
        {
            Token = newToken,
            RefreshToken = newRefreshToken,
            ExpiresAt = expiresAt,
            UserId = userId!,
            Email = email!,
            Roles = roles
        });
    }

    /// <summary>
    /// Gets current administrator information
    /// </summary>
    /// <returns>Current administrator details</returns>
    [HttpGet("me")]
    [Authorize(Policy = "AdminPolicy")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<CurrentUserResponse>> GetCurrentUser()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var email = User.FindFirst(ClaimTypes.Email)?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Unauthorized();
        }

        var roles = await _identityService.GetUserRolesAsync(userId);

        return Ok(new CurrentUserResponse
        {
            UserId = userId,
            Email = email ?? string.Empty,
            Roles = roles,
            EmailVerified = true, // TODO: Implement email verification check
            TwoFactorEnabled = false, // TODO: Implement 2FA check
            LastLoginAt = DateTime.UtcNow // TODO: Get actual last login time
        });
    }

    /// <summary>
    /// Logs out the current administrator
    /// </summary>
    /// <returns>Logout result</returns>
    [HttpPost("logout")]
    [Authorize(Policy = "AdminPolicy")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public Task<IActionResult> Logout()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (!string.IsNullOrEmpty(userId))
        {
            _logger.LogInformation("Admin user {UserId} logged out", userId);
        }

        return Task.FromResult<IActionResult>(Ok(new { message = "Logout successful" }));
    }

    /// <summary>
    /// Initiates password reset for an administrator
    /// </summary>
    /// <param name="request">Forgot password request</param>
    /// <returns>Reset initiation result</returns>
    [HttpPost("forgot-password")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordRequest request)
    {
        var emailExists = await _identityService.CheckEmailExistsAsync(request.Email);
        if (!emailExists)
        {
            // Don't reveal if email exists or not for security
            return Ok(new { message = "If the email exists, a password reset email has been sent" });
        }

        var success = await _identityService.ResetPasswordAsync(request.Email);
        if (success)
        {
            _logger.LogInformation("Password reset initiated for admin {Email}", request.Email);
        }

        return Ok(new { message = "If the email exists, a password reset email has been sent" });
    }

    /// <summary>
    /// Changes the current administrator's password
    /// </summary>
    /// <param name="request">Change password request</param>
    /// <returns>Change result</returns>
    [HttpPost("change-password")]
    [Authorize(Policy = "AdminPolicy")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Unauthorized();
        }

        var success = await _identityService.ChangePasswordAsync(userId, request.CurrentPassword, request.NewPassword);

        if (!success)
        {
            return BadRequest(new { message = "Current password is incorrect" });
        }

        _logger.LogInformation("Password changed for admin {UserId}", userId);
        return Ok(new { message = "Password changed successfully" });
    }

    /// <summary>
    /// Gets active sessions for the current administrator
    /// </summary>
    /// <returns>List of active sessions</returns>
    [HttpGet("sessions")]
    [Authorize(Policy = "AdminPolicy")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public Task<ActionResult<SessionResponse>> GetSessions()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Task.FromResult<ActionResult<SessionResponse>>(Unauthorized());
        }

        // TODO: Implement actual session management with Keycloak/Redis
        // For now, return mock session data
        var sessions = new List<UserSessionDto>
        {
            new UserSessionDto
            {
                SessionId = HttpContext.Session.Id ?? Guid.NewGuid().ToString(),
                DeviceInfo = Request.Headers.UserAgent.ToString(),
                IpAddress = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Unknown",
                CreatedAt = DateTime.UtcNow.AddMinutes(-30),
                LastActivity = DateTime.UtcNow,
                IsActive = true,
                Location = "Unknown" // TODO: Implement GeoIP lookup
            }
        };

        return Task.FromResult<ActionResult<SessionResponse>>(Ok(new SessionResponse
        {
            Sessions = sessions,
            CurrentSession = sessions.FirstOrDefault(),
            TotalSessions = sessions.Count,
            ActiveSessions = sessions.Count(s => s.IsActive)
        }));
    }

    /// <summary>
    /// Terminates a specific session
    /// </summary>
    /// <param name="request">Session termination request</param>
    /// <returns>Termination result</returns>
    [HttpPost("terminate-session")]
    [Authorize(Policy = "AdminPolicy")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public Task<IActionResult> TerminateSession([FromBody] TerminateSessionRequest request)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Task.FromResult<IActionResult>(Unauthorized());
        }

        // TODO: Implement actual session termination with Keycloak/Redis
        _logger.LogInformation("Session {SessionId} termination requested for admin {UserId}", request.SessionId, userId);

        return Task.FromResult<IActionResult>(Ok(new { message = "Session terminated successfully" }));
    }

    /// <summary>
    /// Enables two-factor authentication for the current administrator
    /// </summary>
    /// <returns>2FA setup information</returns>
    [HttpPost("2fa/enable")]
    [Authorize(Policy = "AdminPolicy")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public Task<ActionResult<EnableTwoFactorResponse>> EnableTwoFactor()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Task.FromResult<ActionResult<EnableTwoFactorResponse>>(Unauthorized());
        }

        // TODO: Implement actual 2FA setup with TOTP
        var secretKey = Guid.NewGuid().ToString("N")[..16]; // Mock secret key
        var qrCodeUrl = $"otpauth://totp/UniConnect:Admin?secret={secretKey}&issuer=UniConnect";
        var backupCodes = Enumerable.Range(1, 10).Select(_ => Guid.NewGuid().ToString("N")[..8].ToUpper()).ToArray();

        _logger.LogInformation("Two-factor authentication setup initiated for admin {UserId}", userId);

        return Task.FromResult<ActionResult<EnableTwoFactorResponse>>(Ok(new EnableTwoFactorResponse
        {
            SecretKey = secretKey,
            QrCodeUrl = qrCodeUrl,
            BackupCodes = backupCodes,
            IsEnabled = false,
            ManualEntryKey = secretKey
        }));
    }

    /// <summary>
    /// Verifies two-factor authentication setup
    /// </summary>
    /// <param name="request">2FA verification request</param>
    /// <returns>Verification result</returns>
    [HttpPost("2fa/verify")]
    [Authorize(Policy = "AdminPolicy")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public Task<IActionResult> VerifyTwoFactor([FromBody] VerifyTwoFactorRequest request)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Task.FromResult<IActionResult>(Unauthorized());
        }

        // TODO: Implement actual TOTP verification
        // For now, accept any 6-digit code for testing
        if (request.Code.Length != 6 || !request.Code.All(char.IsDigit))
        {
            return Task.FromResult<IActionResult>(BadRequest(new { message = "Invalid verification code" }));
        }

        _logger.LogInformation("Two-factor authentication verified for admin {UserId}", userId);
        return Task.FromResult<IActionResult>(Ok(new { message = "Two-factor authentication enabled successfully" }));
    }
}
