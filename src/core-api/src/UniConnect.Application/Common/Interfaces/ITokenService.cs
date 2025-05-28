namespace UniConnect.Application.Common.Interfaces;

public interface ITokenService
{
    Task<string?> GetRefreshTokenAsync(string userId);
    Task<bool> SaveRefreshTokenAsync(string userId, string refreshToken, int expiresInSeconds);
    Task<bool> RevokeRefreshTokenAsync(string token);
    Task<bool> ValidateRefreshTokenAsync(string token);
}
