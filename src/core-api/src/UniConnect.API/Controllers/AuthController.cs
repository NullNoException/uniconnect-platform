using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Auth.DTOs;
using UniConnect.Application.Common.Models;
using UniConnect.Domain.Services;

namespace UniConnect.API.Controllers;

public class AuthController : ApiControllerBase
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
    /// Authenticates a user and returns a JWT token
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
            _logger.LogWarning("Failed login attempt for {Email}", request.Email);
            return Unauthorized(new { message = errorMessage });
        }

        var roles = await _identityService.GetUserRolesAsync(userId!);
        var (token, refreshToken) = await _identityService.GenerateTokensAsync(userId!, email!, roles);

        // Get token expiry from settings
        var jwtSettings = _configuration.GetSection("JwtSettings");
        var expirationMinutes = int.Parse(jwtSettings["ExpirationMinutes"] ?? "60");
        var expiresAt = DateTime.UtcNow.AddMinutes(expirationMinutes);

        _logger.LogInformation("User {Email} logged in successfully", email);

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
        if (string.IsNullOrEmpty(request.RefreshToken))
        {
            return BadRequest(new { message = "Refresh token is required" });
        }

        var (success, userId, email, roles, errorMessage) =
            await _identityService.ValidateRefreshTokenAsync(request.RefreshToken);

        if (!success)
        {
            _logger.LogWarning("Invalid refresh token attempt: {Error}", errorMessage);
            return Unauthorized(new { message = errorMessage });
        }

        var (newToken, newRefreshToken) = await _identityService.GenerateTokensAsync(
            userId!, email!, roles!);

        // Get token expiry from settings
        var jwtSettings = _configuration.GetSection("JwtSettings");
        var expirationMinutes = int.Parse(jwtSettings["ExpirationMinutes"] ?? "60");
        var expiresAt = DateTime.UtcNow.AddMinutes(expirationMinutes);

        _logger.LogInformation("Token refreshed for user {UserId}", userId);

        return Ok(new AuthResponse
        {
            Token = newToken,
            RefreshToken = newRefreshToken,
            ExpiresAt = expiresAt,
            UserId = userId!,
            Email = email!,
            Roles = roles!
        });
    }

    /// <summary>
    /// Initiates a password reset flow by sending a reset token
    /// </summary>
    /// <param name="request">Email address for password reset</param>
    /// <returns>Success or failure message</returns>
    [HttpPost("forgot-password")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordRequest request)
    {
        var succeeded = await _identityService.ResetPasswordAsync(request.Email);

        // Always return success to prevent email enumeration attacks
        _logger.LogInformation("Password reset requested for {Email}. Success: {Success}", request.Email, succeeded);

        return Ok(new { message = "If your email is registered in our system, you will receive a password reset link shortly." });
    }

    /// <summary>
    /// Completes the password reset process using the token
    /// </summary>
    /// <param name="request">Password reset details with token</param>
    /// <returns>Success or failure message</returns>
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
            _logger.LogWarning("Failed password reset attempt for {Email}", request.Email);
            return BadRequest(new { message = "Invalid or expired password reset token" });
        }

        _logger.LogInformation("Password reset successful for {Email}", request.Email);

        return Ok(new { message = "Password has been reset successfully" });
    }

    /// <summary>
    /// Changes the password for an authenticated user
    /// </summary>
    /// <param name="request">Current and new password</param>
    /// <returns>Success or failure message</returns>
    [Authorize]
    [HttpPost("change-password")]
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

        var result = await _identityService.ChangePasswordAsync(
            userId, request.CurrentPassword, request.NewPassword);

        if (!result)
        {
            return BadRequest(new { message = "Failed to change password. Ensure your current password is correct." });
        }

        _logger.LogInformation("Password changed for user {UserId}", userId);

        return Ok(new { message = "Password changed successfully" });
    }
}
