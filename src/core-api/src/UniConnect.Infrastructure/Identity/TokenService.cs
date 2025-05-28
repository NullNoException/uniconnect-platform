using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Infrastructure.Persistence;

namespace UniConnect.Infrastructure.Identity;

public class TokenService : ITokenService
{
    private readonly ApplicationDbContext _dbContext;
    private readonly ILogger<TokenService> _logger;

    public TokenService(ApplicationDbContext dbContext, ILogger<TokenService> logger)
    {
        _dbContext = dbContext;
        _logger = logger;
    }

    public async Task<string?> GetRefreshTokenAsync(string userId)
    {
        try
        {
            var token = await _dbContext.RefreshTokens
                .Where(t => t.UserId == userId && t.ExpiryDate > DateTime.UtcNow)
                .OrderByDescending(t => t.CreatedAt)
                .FirstOrDefaultAsync();

            return token?.Token;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving refresh token for user {UserId}", userId);
            return null;
        }
    }

    public async Task<bool> SaveRefreshTokenAsync(string userId, string refreshToken, int expiresInSeconds)
    {
        try
        {
            // Invalidate any existing refresh tokens for this user
            var existingTokens = await _dbContext.RefreshTokens
                .Where(t => t.UserId == userId)
                .ToListAsync();

            foreach (var token in existingTokens)
            {
                token.IsRevoked = true;
            }

            // Create a new refresh token
            var newToken = new RefreshToken
            {
                UserId = userId,
                Token = refreshToken,
                CreatedAt = DateTime.UtcNow,
                ExpiryDate = DateTime.UtcNow.AddSeconds(expiresInSeconds),
                IsRevoked = false
            };

            _dbContext.RefreshTokens.Add(newToken);
            await _dbContext.SaveChangesAsync();

            _logger.LogInformation("Saved new refresh token for user {UserId}", userId);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error saving refresh token for user {UserId}", userId);
            return false;
        }
    }

    public async Task<bool> RevokeRefreshTokenAsync(string token)
    {
        try
        {
            var refreshToken = await _dbContext.RefreshTokens
                .FirstOrDefaultAsync(t => t.Token == token);

            if (refreshToken == null)
            {
                _logger.LogWarning("Attempted to revoke non-existent refresh token");
                return false;
            }

            refreshToken.IsRevoked = true;
            refreshToken.UpdatedAt = DateTime.UtcNow;

            await _dbContext.SaveChangesAsync();

            _logger.LogInformation("Revoked refresh token for user {UserId}", refreshToken.UserId);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error revoking refresh token");
            return false;
        }
    }

    public async Task<bool> ValidateRefreshTokenAsync(string token)
    {
        try
        {
            var refreshToken = await _dbContext.RefreshTokens
                .FirstOrDefaultAsync(t => t.Token == token);

            if (refreshToken == null)
            {
                _logger.LogWarning("Attempted to validate non-existent refresh token");
                return false;
            }

            return !refreshToken.IsRevoked &&
                   !refreshToken.IsUsed &&
                   refreshToken.ExpiryDate > DateTime.UtcNow;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error validating refresh token");
            return false;
        }
    }
}
