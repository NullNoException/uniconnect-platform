namespace UniConnect.Domain.Services;

public interface IIdentityService
{
    Task<(bool Success, string? UserId, string? ErrorMessage)> CreateUserAsync(string email, string password, string userType);
    Task<(bool Success, string? UserId, string? Email, string? ErrorMessage)> ValidateUserCredentialsAsync(string email, string password);
    Task<bool> CheckEmailExistsAsync(string email);
    Task<bool> ResetPasswordAsync(string email);
    Task<bool> ConfirmResetPasswordAsync(string email, string token, string newPassword);
    Task<bool> ChangePasswordAsync(string userId, string currentPassword, string newPassword);
    Task<List<string>> GetUserRolesAsync(string userId);
    Task<bool> AssignRoleToUserAsync(string userId, string role);
    Task<bool> RemoveRoleFromUserAsync(string userId, string role);
    Task<(string Token, string RefreshToken)> GenerateTokensAsync(string userId, string email, List<string> roles);
    Task<(bool Success, string? UserId, string? Email, List<string>? Roles, string? ErrorMessage)> ValidateRefreshTokenAsync(string refreshToken);
}
