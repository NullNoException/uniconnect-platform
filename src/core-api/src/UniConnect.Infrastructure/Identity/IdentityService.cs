using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Services;

namespace UniConnect.Infrastructure.Identity;

public class IdentityService : IIdentityService
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IConfiguration _configuration;
    private readonly ILogger<IdentityService> _logger;
    private readonly IApplicationDbContext _context;

    public IdentityService(
        UserManager<ApplicationUser> userManager,
        IConfiguration configuration,
        ILogger<IdentityService> logger,
        IApplicationDbContext context)
    {
        _userManager = userManager;
        _configuration = configuration;
        _logger = logger;
        _context = context;
    }

    public async Task<(bool Success, string? UserId, string? ErrorMessage)> CreateUserAsync(string email, string password, string userType)
    {
        try
        {
            var user = new ApplicationUser
            {
                UserName = email,
                Email = email,
                EmailConfirmed = false
            };

            var result = await _userManager.CreateAsync(user, password);

            if (result.Succeeded)
            {
                await _userManager.AddToRoleAsync(user, userType);

                return (true, user.Id, null);
            }

            return (false, null, string.Join(", ", result.Errors.Select(e => e.Description)));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating user {Email}", email);
            return (false, null, "An unexpected error occurred while creating user.");
        }
    }

    public async Task<(bool Success, string? UserId, string? Email, string? ErrorMessage)> ValidateUserCredentialsAsync(string email, string password)
    {
        try
        {
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
            {
                return (false, null, null, "Invalid email or password");
            }

            if (!user.IsActive)
            {
                return (false, null, null, "Account is disabled");
            }

            var isPasswordValid = await _userManager.CheckPasswordAsync(user, password);
            if (!isPasswordValid)
            {
                return (false, null, null, "Invalid email or password");
            }

            // Update last login timestamp
            user.LastLogin = DateTime.UtcNow;
            await _userManager.UpdateAsync(user);

            return (true, user.Id, user.Email, null);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error validating credentials for {Email}", email);
            return (false, null, null, "An unexpected error occurred");
        }
    }

    public async Task<bool> CheckEmailExistsAsync(string email)
    {
        return await _userManager.FindByEmailAsync(email) != null;
    }

    public async Task<bool> ResetPasswordAsync(string email)
    {
        try
        {
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
            {
                return false;
            }

            var token = await _userManager.GeneratePasswordResetTokenAsync(user);

            // In a real implementation, this would send an email with the token
            _logger.LogInformation("Password reset token generated for {Email}: {Token}", email, token);

            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error resetting password for {Email}", email);
            return false;
        }
    }

    public async Task<bool> ChangePasswordAsync(string userId, string currentPassword, string newPassword)
    {
        try
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return false;
            }

            var result = await _userManager.ChangePasswordAsync(user, currentPassword, newPassword);
            return result.Succeeded;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error changing password for user {UserId}", userId);
            return false;
        }
    }

    public async Task<List<string>> GetUserRolesAsync(string userId)
    {
        try
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return new List<string>();
            }

            var roles = await _userManager.GetRolesAsync(user);
            return roles.ToList();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting roles for user {UserId}", userId);
            return new List<string>();
        }
    }

    public async Task<bool> AssignRoleToUserAsync(string userId, string role)
    {
        try
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return false;
            }

            var result = await _userManager.AddToRoleAsync(user, role);
            return result.Succeeded;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error assigning role {Role} to user {UserId}", role, userId);
            return false;
        }
    }

    public async Task<bool> RemoveRoleFromUserAsync(string userId, string role)
    {
        try
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return false;
            }

            var result = await _userManager.RemoveFromRoleAsync(user, role);
            return result.Succeeded;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error removing role {Role} from user {UserId}", role, userId);
            return false;
        }
    }

    private string GenerateJwtToken(string userId, string email, List<string> roles)
    {
        var jwtSettings = _configuration.GetSection("JwtSettings");
        var secretKey = jwtSettings["SecretKey"]!;
        var issuer = jwtSettings["Issuer"]!;
        var audience = jwtSettings["Audience"]!;
        var expirationMinutes = int.Parse(jwtSettings["ExpirationMinutes"] ?? "60");

        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.NameIdentifier, userId),
            new Claim(ClaimTypes.Email, email),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
        };

        foreach (var role in roles)
        {
            claims.Add(new Claim(ClaimTypes.Role, role));
        }

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var expires = DateTime.UtcNow.AddMinutes(expirationMinutes);

        var token = new JwtSecurityToken(
            issuer: issuer,
            audience: audience,
            claims: claims,
            expires: expires,
            signingCredentials: credentials
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    public async Task<bool> ConfirmResetPasswordAsync(string email, string token, string newPassword)
    {
        try
        {
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
            {
                return false;
            }

            var result = await _userManager.ResetPasswordAsync(user, token, newPassword);
            return result.Succeeded;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error confirming password reset for {Email}", email);
            return false;
        }
    }

    public async Task<(string Token, string RefreshToken)> GenerateTokensAsync(string userId, string email, List<string> roles)
    {
        // Generate JWT
        var jwtToken = GenerateJwtToken(userId, email, roles);

        // Generate refresh token
        var refreshToken = GenerateRefreshToken();

        // Extract JWT ID claim
        var tokenHandler = new JwtSecurityTokenHandler();
        var jwt = tokenHandler.ReadJwtToken(jwtToken);
        var jwtId = jwt.Claims.First(c => c.Type == JwtRegisteredClaimNames.Jti).Value;

        // Create refresh token entity
        var refreshTokenEntity = new RefreshToken
        {
            Token = refreshToken,
            JwtId = jwtId,
            UserId = userId,
            ExpiryDate = DateTime.UtcNow.AddDays(30), // 30 days refresh token validity
            CreatedAt = DateTime.UtcNow,
            CreatedBy = userId
        };

        // Store refresh token in database
        await _context.RefreshTokens.AddAsync(refreshTokenEntity);
        await _context.SaveChangesAsync(CancellationToken.None);

        return (jwtToken, refreshToken);
    }

    private string GenerateRefreshToken()
    {
        var randomNumber = new byte[32];
        using (var rng = RandomNumberGenerator.Create())
        {
            rng.GetBytes(randomNumber);
            return Convert.ToBase64String(randomNumber);
        }
    }

    public async Task<(bool Success, string? UserId, string? Email, List<string>? Roles, string? ErrorMessage)> ValidateRefreshTokenAsync(string refreshToken)
    {
        try
        {
            // Find the refresh token in the database
            var storedRefreshToken = await _context.RefreshTokens
                .FirstOrDefaultAsync(rt => rt.Token == refreshToken);

            if (storedRefreshToken == null)
            {
                return (false, null, null, null, "Invalid refresh token");
            }

            // Check if token is used, revoked or expired
            if (storedRefreshToken.IsUsed)
            {
                return (false, null, null, null, "Refresh token has been used");
            }

            if (storedRefreshToken.IsRevoked)
            {
                return (false, null, null, null, "Refresh token has been revoked");
            }

            if (storedRefreshToken.ExpiryDate < DateTime.UtcNow)
            {
                return (false, null, null, null, "Refresh token has expired");
            }

            // Find the user
            var user = await _userManager.FindByIdAsync(storedRefreshToken.UserId);
            if (user == null || !user.IsActive)
            {
                return (false, null, null, null, "User not found or inactive");
            }

            // Mark token as used
            storedRefreshToken.IsUsed = true;
            storedRefreshToken.UpdatedAt = DateTime.UtcNow;
            storedRefreshToken.UpdatedBy = user.Id;
            await _context.SaveChangesAsync(CancellationToken.None);

            // Get user roles
            var roles = await _userManager.GetRolesAsync(user);

            return (true, user.Id, user.Email, roles.ToList(), null);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error validating refresh token");
            return (false, null, null, null, "An unexpected error occurred");
        }
    }
}
