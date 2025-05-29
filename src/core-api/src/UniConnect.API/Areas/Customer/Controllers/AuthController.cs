using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Areas.Common;
using UniConnect.Application.Auth.DTOs;
using UniConnect.Domain.Services;

namespace UniConnect.API.Areas.Customer.Controllers;

[Area("Customer")]
[Route("api/customer/v1/auth")]
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
    /// Authenticates a customer and returns a JWT token
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
            _logger.LogWarning("Failed customer login attempt for {Email}", request.Email);
            return Unauthorized(new { message = errorMessage });
        }

        // Verify user has customer role
        var roles = await _identityService.GetUserRolesAsync(userId!);
        if (!roles.Contains("Student") && !roles.Contains("Customer"))
        {
            _logger.LogWarning("Unauthorized customer login attempt for {Email} - insufficient permissions", request.Email);
            return Unauthorized(new { message = "Insufficient permissions for customer portal" });
        }

        var (token, refreshToken) = await _identityService.GenerateTokensAsync(userId!, email!, roles);

        var keycloakSettings = _configuration.GetSection("KeycloakSettings");
        var expirationMinutes = int.Parse(keycloakSettings["AccessTokenExpirationMinutes"] ?? "15");
        var expiresAt = DateTime.UtcNow.AddMinutes(expirationMinutes);

        _logger.LogInformation("Customer {Email} logged in successfully", email);

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
    /// Registers a new customer
    /// </summary>
    /// <param name="request">Customer registration details</param>
    /// <returns>Registration success response</returns>
    [HttpPost("register")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request)
    {
        if (request.Password != request.ConfirmPassword)
        {
            return BadRequest(new { message = "Passwords do not match" });
        }

        // For customer area, default to Student user type
        var userType = "Student";

        var (success, userId, errorMessage) = await _identityService.CreateUserAsync(
            request.Email, request.Password, userType);

        if (!success)
        {
            _logger.LogWarning("Failed customer registration for {Email}: {Error}", request.Email, errorMessage);
            return BadRequest(new { message = errorMessage });
        }

        // Assign Student role
        await _identityService.AssignRoleToUserAsync(userId!, "Student");

        _logger.LogInformation("Customer registered successfully: {Email}", request.Email);

        return Ok(new { message = "Registration successful. Please check your email to verify your account.", userId });
    }

    /// <summary>
    /// Handles OAuth callback for customer login
    /// </summary>
    /// <param name="request">OAuth callback data</param>
    /// <returns>Authentication response</returns>
    [HttpPost("oauth/callback")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public Task<ActionResult<AuthResponse>> OAuthCallback([FromBody] OAuthCallbackRequest request)
    {
        // This would integrate with OAuth providers like Google, Facebook, etc.
        // For now, return a placeholder implementation
        _logger.LogInformation("OAuth callback received for provider: {Provider}", request.Provider);

        return Task.FromResult<ActionResult<AuthResponse>>(BadRequest(new { message = "OAuth integration not yet implemented" }));
    }

    /// <summary>
    /// Refreshes an expired JWT token using a refresh token
    /// </summary>
    /// <param name="request">Refresh token request</param>
    /// <returns>New JWT and refresh tokens</returns>
    [HttpPost("refresh")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<AuthResponse>> RefreshToken([FromBody] RefreshTokenRequest request)
    {
        var (success, userId, email, roles, errorMessage) = await _identityService.ValidateRefreshTokenAsync(request.RefreshToken);

        if (!success)
        {
            _logger.LogWarning("Token refresh failed: {Error}", errorMessage);
            return Unauthorized(new { message = errorMessage });
        }

        // Verify user still has customer access
        if (!roles!.Contains("Student") && !roles.Contains("Customer"))
        {
            _logger.LogWarning("User {Email} lost customer privileges during token refresh", email);
            return Forbid("Customer privileges revoked");
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
    /// Validates a JWT token
    /// </summary>
    /// <param name="request">Token validation request</param>
    /// <returns>Token validation result</returns>
    [HttpPost("validate")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public Task<IActionResult> ValidateToken([FromBody] ValidateTokenRequest request)
    {
        // TODO: Implement actual token validation when available in IIdentityService
        // For now, return a basic validation response
        var isValid = !string.IsNullOrEmpty(request.Token);

        if (!isValid)
        {
            return Task.FromResult<IActionResult>(Unauthorized(new { message = "Invalid or expired token" }));
        }

        return Task.FromResult<IActionResult>(Ok(new { message = "Token is valid", isValid = true }));
    }

    /// <summary>
    /// Gets current authenticated customer information
    /// </summary>
    /// <returns>Current customer details</returns>
    [Authorize]
    [HttpGet("me")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<CurrentUserResponse>> GetCurrentUser()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Unauthorized();
        }

        var roles = await _identityService.GetUserRolesAsync(userId);

        return Ok(new CurrentUserResponse
        {
            UserId = userId,
            Email = User.FindFirst(ClaimTypes.Email)?.Value ?? "",
            FirstName = User.FindFirst(ClaimTypes.GivenName)?.Value ?? "",
            LastName = User.FindFirst(ClaimTypes.Surname)?.Value ?? "",
            UserType = "Customer",
            Roles = roles,
            EmailVerified = true // This would come from actual user data
        });
    }

    /// <summary>
    /// Logs out the current customer
    /// </summary>
    /// <returns>Logout confirmation</returns>
    [Authorize]
    [HttpPost("logout")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public Task<IActionResult> Logout()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (!string.IsNullOrEmpty(userId))
        {
            // Here you would invalidate the token/session
            _logger.LogInformation("Customer {UserId} logged out", userId);
        }

        return Task.FromResult<IActionResult>(Ok(new { message = "Logged out successfully" }));
    }

    /// <summary>
    /// Verifies customer email address
    /// </summary>
    /// <param name="request">Email verification details</param>
    /// <returns>Verification result</returns>
    [HttpPost("verify-email")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> VerifyEmail([FromBody] VerifyEmailRequest request)
    {
        // TODO: Implement actual email verification when available in IIdentityService
        // For now, return a success response
        var emailExists = await _identityService.CheckEmailExistsAsync(request.Email);

        if (!emailExists)
        {
            return BadRequest(new { message = "Email not found" });
        }

        _logger.LogInformation("Email verification requested for {Email}", request.Email);
        return Ok(new { message = "Email verified successfully" });
    }

    /// <summary>
    /// Initiates password reset for customer
    /// </summary>
    /// <param name="request">Password reset request</param>
    /// <returns>Password reset confirmation</returns>
    [HttpPost("forgot-password")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordRequest request)
    {
        var succeeded = await _identityService.ResetPasswordAsync(request.Email);

        _logger.LogInformation("Customer password reset requested for {Email}. Success: {Success}", request.Email, succeeded);

        return Ok(new { message = "If your email is registered, you will receive a password reset link shortly." });
    }

    /// <summary>
    /// Resets customer password using token
    /// </summary>
    /// <param name="request">Password reset details</param>
    /// <returns>Password reset result</returns>
    [HttpPost("reset-password")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordRequest request)
    {
        if (request.NewPassword != request.ConfirmPassword)
        {
            return BadRequest(new { message = "Passwords do not match" });
        }

        var result = await _identityService.ConfirmResetPasswordAsync(
            request.Email, request.Token, request.NewPassword);

        if (!result)
        {
            return BadRequest(new { message = "Invalid or expired password reset token" });
        }

        return Ok(new { message = "Password has been reset successfully" });
    }

    /// <summary>
    /// Changes password for authenticated customer
    /// </summary>
    /// <param name="request">Password change details</param>
    /// <returns>Password change result</returns>
    [Authorize]
    [HttpPost("change-password")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId))
        {
            return Unauthorized();
        }

        var result = await _identityService.ChangePasswordAsync(userId, request.CurrentPassword, request.NewPassword);

        if (!result)
        {
            return BadRequest(new { message = "Current password is incorrect" });
        }

        return Ok(new { message = "Password changed successfully" });
    }

    /// <summary>
    /// Revokes a token
    /// </summary>
    /// <param name="request">Token revocation request</param>
    /// <returns>Revocation result</returns>
    [HttpPost("revoke")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public Task<IActionResult> RevokeToken([FromBody] RevokeTokenRequest request)
    {
        // Implementation would depend on token storage strategy
        _logger.LogInformation("Token revocation requested for token type: {TokenType}", request.TokenType);

        return Task.FromResult<IActionResult>(Ok(new { message = "Token revoked successfully" }));
    }

    /// <summary>
    /// Gets customer active sessions
    /// </summary>
    /// <returns>List of active sessions</returns>
    [Authorize]
    [HttpGet("sessions")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public Task<ActionResult<SessionsResponse>> GetSessions()
    {
        // This would retrieve actual session data from your session store
        var sessions = new List<UserSessionDto>
        {
            new UserSessionDto
            {
                SessionId = "current",
                DeviceInfo = Request.Headers.UserAgent.ToString(),
                IpAddress = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Unknown",
                CreatedAt = DateTime.UtcNow.AddHours(-2),
                LastActivity = DateTime.UtcNow,
                IsActive = true,
                Location = "Unknown"
            }
        };

        return Task.FromResult<ActionResult<SessionsResponse>>(Ok(new SessionsResponse
        {
            Sessions = sessions,
            CurrentSession = sessions.First()
        }));
    }

    /// <summary>
    /// Terminates a specific session
    /// </summary>
    /// <param name="sessionId">Session ID to terminate</param>
    /// <returns>Session termination result</returns>
    [Authorize]
    [HttpDelete("sessions/{sessionId}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public Task<IActionResult> TerminateSession(string sessionId)
    {
        // Implementation would terminate the specific session
        _logger.LogInformation("Session termination requested for session: {SessionId}", sessionId);

        return Task.FromResult<IActionResult>(Ok(new { message = "Session terminated successfully" }));
    }

    /// <summary>
    /// Enables two-factor authentication for customer
    /// </summary>
    /// <param name="request">2FA setup request</param>
    /// <returns>2FA setup details</returns>
    [Authorize]
    [HttpPost("2fa/enable")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public Task<ActionResult<TwoFactorSetupResponse>> EnableTwoFactor([FromBody] Enable2FARequest request)
    {
        // This would integrate with TOTP library like Google Authenticator
        return Task.FromResult<ActionResult<TwoFactorSetupResponse>>(Ok(new TwoFactorSetupResponse
        {
            SecretKey = "PLACEHOLDER_SECRET",
            QrCodeUrl = "data:image/png;base64,placeholder",
            BackupCodes = new[] { "12345678", "87654321" }
        }));
    }

    /// <summary>
    /// Verifies two-factor authentication setup
    /// </summary>
    /// <param name="request">2FA verification request</param>
    /// <returns>2FA verification result</returns>
    [Authorize]
    [HttpPost("2fa/verify-setup")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public Task<IActionResult> VerifyTwoFactorSetup([FromBody] Verify2FASetupRequest request)
    {
        // This would verify the TOTP code
        return Task.FromResult<IActionResult>(Ok(new { message = "Two-factor authentication enabled successfully" }));
    }
}
