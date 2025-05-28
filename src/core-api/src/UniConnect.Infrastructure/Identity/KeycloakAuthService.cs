using System.IdentityModel.Tokens.Jwt;
using System.Net.Http;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using System.Text.Json;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using UniConnect.Application.Auth.DTOs;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Services;

namespace UniConnect.Infrastructure.Identity;

public class KeycloakAuthService : IIdentityService
{
    private readonly HttpClient _httpClient;
    private readonly IConfiguration _configuration;
    private readonly ILogger<KeycloakAuthService> _logger;
    private readonly ITokenService _tokenService;

    public KeycloakAuthService(
        HttpClient httpClient,
        IConfiguration configuration,
        ILogger<KeycloakAuthService> logger,
        ITokenService tokenService)
    {
        _httpClient = httpClient;
        _configuration = configuration;
        _logger = logger;
        _tokenService = tokenService;
    }

    public async Task<(bool Success, string UserId, string Message)> AuthenticateAsync(string email, string password)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var tokenEndpoint = $"{keycloakSettings["Authority"]}/realms/{keycloakSettings["Realm"]}/protocol/openid-connect/token";

            var content = new FormUrlEncodedContent(new Dictionary<string, string>
            {
                { "client_id", keycloakSettings["ClientId"] ?? string.Empty },
                { "client_secret", keycloakSettings["ClientSecret"] ?? string.Empty },
                { "grant_type", "password" },
                { "username", email },
                { "password", password },
                { "scope", "openid" }
            });

            var response = await _httpClient.PostAsync(tokenEndpoint, content);

            if (!response.IsSuccessStatusCode)
            {
                var errorContent = await response.Content.ReadAsStringAsync();
                _logger.LogWarning("Authentication failed for user {Email}. Status code: {StatusCode}, Response: {Response}",
                    email, response.StatusCode, errorContent);
                return (false, string.Empty, "Authentication failed. Please check your credentials.");
            }

            var tokenResponse = await response.Content.ReadFromJsonAsync<KeycloakTokenResponse>();
            if (tokenResponse == null)
            {
                _logger.LogError("Failed to deserialize token response for user {Email}", email);
                return (false, string.Empty, "Error processing authentication response.");
            }

            // Extract user ID from the JWT token
            var handler = new JwtSecurityTokenHandler();
            var jwtToken = handler.ReadJwtToken(tokenResponse.AccessToken);
            var userId = jwtToken.Claims.FirstOrDefault(c => c.Type == "sub")?.Value;

            if (string.IsNullOrEmpty(userId))
            {
                _logger.LogError("User ID claim not found in token for user {Email}", email);
                return (false, string.Empty, "Error retrieving user information.");
            }

            // Store the refresh token
            await _tokenService.SaveRefreshTokenAsync(userId, tokenResponse.RefreshToken, tokenResponse.RefreshExpiresIn);

            return (true, userId, "Authentication successful");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during authentication for user {Email}", email);
            return (false, string.Empty, "An error occurred during authentication.");
        }
    }

    // Implement required IIdentityService methods
    public async Task<(bool Success, string? UserId, string? ErrorMessage)> CreateUserAsync(string email, string password, string userType)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var usersEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users";

            // First, authenticate as admin to get admin token
            var adminToken = await GetAdminToken();
            if (string.IsNullOrEmpty(adminToken))
            {
                return (false, null, "Failed to authenticate with admin credentials");
            }

            // Create user request
            var userRequest = new
            {
                username = email,
                email = email,
                enabled = true,
                emailVerified = false,
                credentials = new[]
                {
                    new
                    {
                        type = "password",
                        value = password,
                        temporary = false
                    }
                }
            };

            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var response = await _httpClient.PostAsJsonAsync(usersEndpoint, userRequest);

            if (!response.IsSuccessStatusCode)
            {
                var errorContent = await response.Content.ReadAsStringAsync();
                _logger.LogWarning("User creation failed. Status code: {StatusCode}, Response: {Response}",
                    response.StatusCode, errorContent);
                return (false, null, $"User creation failed: {errorContent}");
            }

            // Get the created user ID
            // In Keycloak, the created user ID is not directly returned in the response
            // We need to search for the user by email to get the ID
            var userId = await GetUserIdByEmail(email, adminToken);
            if (string.IsNullOrEmpty(userId))
            {
                return (false, null, "User created but unable to retrieve user ID");
            }

            // Assign role to user
            var roleAssigned = await AssignRoleToUserAsync(userId, userType);
            if (!roleAssigned)
            {
                _logger.LogWarning("Role assignment failed for user {UserId}, role {Role}", userId, userType);
                // Continue anyway since the user was created successfully
            }

            return (true, userId, null);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during user creation for {Email}", email);
            return (false, null, $"An error occurred during user creation: {ex.Message}");
        }
    }

    public async Task<(bool Success, string? UserId, string? Email, string? ErrorMessage)> ValidateUserCredentialsAsync(string email, string password)
    {
        var authResult = await AuthenticateAsync(email, password);
        return (authResult.Success, authResult.UserId, email, authResult.Success ? null : authResult.Message);
    }

    public async Task<bool> CheckEmailExistsAsync(string email)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var usersEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users?email={Uri.EscapeDataString(email)}";

            // Get admin token
            var adminToken = await GetAdminToken();
            if (string.IsNullOrEmpty(adminToken))
            {
                _logger.LogError("Failed to authenticate with admin credentials for email check");
                return false;
            }

            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var response = await _httpClient.GetAsync(usersEndpoint);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Email check failed. Status code: {StatusCode}", response.StatusCode);
                return false;
            }

            var users = await response.Content.ReadFromJsonAsync<List<KeycloakUser>>();
            return users != null && users.Any(u => u.Email?.Equals(email, StringComparison.OrdinalIgnoreCase) == true);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error checking email existence for {Email}", email);
            return false;
        }
    }

    public async Task<bool> ResetPasswordAsync(string email)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var resetEndpoint = $"{keycloakSettings["Authority"]}/realms/{keycloakSettings["Realm"]}/login-actions/reset-credentials";

            // In a real implementation, this would likely send an email through Keycloak
            // This is a simplified version
            var userId = await GetUserIdByEmail(email, await GetAdminToken());
            if (string.IsNullOrEmpty(userId))
            {
                _logger.LogWarning("User not found for reset password: {Email}", email);
                return false;
            }

            // For this sample, we'll just initiate the reset action
            // A proper implementation would involve Keycloak's email services
            _logger.LogInformation("Password reset initiated for user {Email}", email);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during password reset for {Email}", email);
            return false;
        }
    }

    public async Task<bool> ConfirmResetPasswordAsync(string email, string token, string newPassword)
    {
        try
        {
            // In a real implementation, this would verify the token and update the password
            // This is a simplified implementation
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var adminToken = await GetAdminToken();
            var userId = await GetUserIdByEmail(email, adminToken);

            if (string.IsNullOrEmpty(userId))
            {
                _logger.LogWarning("User not found for password reset confirmation: {Email}", email);
                return false;
            }

            var resetEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users/{userId}/reset-password";

            var passwordReset = new
            {
                type = "password",
                value = newPassword,
                temporary = false
            };

            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var response = await _httpClient.PutAsJsonAsync(resetEndpoint, passwordReset);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Password reset confirmation failed. Status code: {StatusCode}", response.StatusCode);
                return false;
            }

            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during password reset confirmation for {Email}", email);
            return false;
        }
    }

    public async Task<bool> ChangePasswordAsync(string userId, string currentPassword, string newPassword)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");

            // First verify the current password is correct by trying to authenticate
            // To do this, we need the user's email
            var userEmail = await GetUserEmailById(userId, await GetAdminToken());
            if (string.IsNullOrEmpty(userEmail))
            {
                _logger.LogWarning("Unable to find email for user {UserId}", userId);
                return false;
            }

            // Verify current password
            var authResult = await AuthenticateAsync(userEmail, currentPassword);
            if (!authResult.Success)
            {
                _logger.LogWarning("Current password verification failed for user {UserId}", userId);
                return false;
            }

            // Change password using admin API
            var adminToken = await GetAdminToken();
            var resetEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users/{userId}/reset-password";

            var passwordReset = new
            {
                type = "password",
                value = newPassword,
                temporary = false
            };

            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var response = await _httpClient.PutAsJsonAsync(resetEndpoint, passwordReset);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Password change failed. Status code: {StatusCode}", response.StatusCode);
                return false;
            }

            return true;
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
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var rolesEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users/{userId}/role-mappings/realm";

            var adminToken = await GetAdminToken();
            if (string.IsNullOrEmpty(adminToken))
            {
                _logger.LogError("Failed to authenticate with admin credentials");
                return new List<string>();
            }

            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var response = await _httpClient.GetAsync(rolesEndpoint);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Getting user roles failed. Status code: {StatusCode}", response.StatusCode);
                return new List<string>();
            }

            var roles = await response.Content.ReadFromJsonAsync<List<KeycloakRole>>() ?? new List<KeycloakRole>();
            return roles.Select(r => r.Name ?? string.Empty).Where(n => !string.IsNullOrEmpty(n)).ToList();
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
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var adminToken = await GetAdminToken();

            if (string.IsNullOrEmpty(adminToken))
            {
                _logger.LogError("Failed to authenticate with admin credentials");
                return false;
            }

            // First, get the role by name
            var roleId = await GetRoleId(role, adminToken);
            if (string.IsNullOrEmpty(roleId))
            {
                _logger.LogWarning("Role not found: {Role}", role);
                return false;
            }

            // Get the role details
            var roleDetailsEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/roles/{role}";
            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var roleResponse = await _httpClient.GetAsync(roleDetailsEndpoint);

            if (!roleResponse.IsSuccessStatusCode)
            {
                _logger.LogWarning("Getting role details failed. Status code: {StatusCode}", roleResponse.StatusCode);
                return false;
            }

            var roleDetails = await roleResponse.Content.ReadFromJsonAsync<KeycloakRole>();
            if (roleDetails == null)
            {
                _logger.LogWarning("Failed to deserialize role details for {Role}", role);
                return false;
            }

            // Assign role to user
            var assignRoleEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users/{userId}/role-mappings/realm";
            var roleAssignment = new List<KeycloakRole> { roleDetails };

            var assignResponse = await _httpClient.PostAsJsonAsync(assignRoleEndpoint, roleAssignment);

            if (!assignResponse.IsSuccessStatusCode)
            {
                var errorContent = await assignResponse.Content.ReadAsStringAsync();
                _logger.LogWarning("Role assignment failed. Status code: {StatusCode}, Response: {Response}",
                    assignResponse.StatusCode, errorContent);
                return false;
            }

            return true;
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
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var adminToken = await GetAdminToken();

            if (string.IsNullOrEmpty(adminToken))
            {
                _logger.LogError("Failed to authenticate with admin credentials");
                return false;
            }

            // First, get the role details
            var roleDetailsEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/roles/{role}";
            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var roleResponse = await _httpClient.GetAsync(roleDetailsEndpoint);

            if (!roleResponse.IsSuccessStatusCode)
            {
                _logger.LogWarning("Getting role details failed. Status code: {StatusCode}", roleResponse.StatusCode);
                return false;
            }

            var roleDetails = await roleResponse.Content.ReadFromJsonAsync<KeycloakRole>();
            if (roleDetails == null)
            {
                _logger.LogWarning("Failed to deserialize role details for {Role}", role);
                return false;
            }

            // Remove role from user
            var removeRoleEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users/{userId}/role-mappings/realm";
            var roleAssignment = new List<KeycloakRole> { roleDetails };

            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Delete,
                RequestUri = new Uri(removeRoleEndpoint),
                Content = JsonContent.Create(roleAssignment)
            };

            var removeResponse = await _httpClient.SendAsync(request);

            if (!removeResponse.IsSuccessStatusCode)
            {
                _logger.LogWarning("Role removal failed. Status code: {StatusCode}", removeResponse.StatusCode);
                return false;
            }

            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error removing role {Role} from user {UserId}", role, userId);
            return false;
        }
    }

    public async Task<(string Token, string RefreshToken)> GenerateTokensAsync(string userId, string email, List<string> roles)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var tokenEndpoint = $"{keycloakSettings["Authority"]}/realms/{keycloakSettings["Realm"]}/protocol/openid-connect/token";

            // In a proper implementation, we might use client_credentials grant_type with sufficient permissions
            // For this sample, we'll use the direct token endpoint with a service account
            var content = new FormUrlEncodedContent(new Dictionary<string, string>
            {
                { "client_id", keycloakSettings["ClientId"] ?? string.Empty },
                { "client_secret", keycloakSettings["ClientSecret"] ?? string.Empty },
                { "grant_type", "client_credentials" }
            });

            var response = await _httpClient.PostAsync(tokenEndpoint, content);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogError("Failed to generate tokens. Status: {Status}", response.StatusCode);
                return (string.Empty, string.Empty);
            }

            var tokenResponse = await response.Content.ReadFromJsonAsync<KeycloakTokenResponse>();
            return tokenResponse != null
                ? (tokenResponse.AccessToken, tokenResponse.RefreshToken)
                : (string.Empty, string.Empty);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating tokens for user {UserId}", userId);
            return (string.Empty, string.Empty);
        }
    }

    public async Task<(bool Success, string? UserId, string? Email, List<string>? Roles, string? ErrorMessage)> ValidateRefreshTokenAsync(string refreshToken)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var tokenEndpoint = $"{keycloakSettings["Authority"]}/realms/{keycloakSettings["Realm"]}/protocol/openid-connect/token";

            var content = new FormUrlEncodedContent(new Dictionary<string, string>
            {
                { "client_id", keycloakSettings["ClientId"] ?? string.Empty },
                { "client_secret", keycloakSettings["ClientSecret"] ?? string.Empty },
                { "grant_type", "refresh_token" },
                { "refresh_token", refreshToken }
            });

            var response = await _httpClient.PostAsync(tokenEndpoint, content);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Refresh token validation failed. Status code: {StatusCode}", response.StatusCode);
                return (false, null, null, null, "Invalid refresh token");
            }

            var tokenResponse = await response.Content.ReadFromJsonAsync<KeycloakTokenResponse>();
            if (tokenResponse == null)
            {
                return (false, null, null, null, "Failed to parse token response");
            }

            // Extract claims from the new access token
            var handler = new JwtSecurityTokenHandler();
            var jwtToken = handler.ReadJwtToken(tokenResponse.AccessToken);

            var userId = jwtToken.Claims.FirstOrDefault(c => c.Type == "sub")?.Value;
            var email = jwtToken.Claims.FirstOrDefault(c => c.Type == "email")?.Value;

            // Extract roles from the realm_access claim
            var realmAccess = jwtToken.Claims.FirstOrDefault(c => c.Type == "realm_access")?.Value;
            List<string> roles = new();

            if (!string.IsNullOrEmpty(realmAccess))
            {
                var realmAccessObj = JsonSerializer.Deserialize<JsonElement>(realmAccess);
                if (realmAccessObj.TryGetProperty("roles", out var rolesElement) && rolesElement.ValueKind == JsonValueKind.Array)
                {
                    roles = rolesElement.EnumerateArray()
                        .Select(r => r.GetString() ?? string.Empty)
                        .Where(r => !string.IsNullOrEmpty(r))
                        .ToList();
                }
            }

            // Save the new refresh token
            if (!string.IsNullOrEmpty(userId))
            {
                await _tokenService.SaveRefreshTokenAsync(userId, tokenResponse.RefreshToken, tokenResponse.RefreshExpiresIn);
            }

            return (true, userId, email, roles, null);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error validating refresh token");
            return (false, null, null, null, "Error validating refresh token");
        }
    }

    // Helper methods
    private async Task<string> GetAdminToken()
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var tokenEndpoint = $"{keycloakSettings["Authority"]}/realms/master/protocol/openid-connect/token";

            var content = new FormUrlEncodedContent(new Dictionary<string, string>
            {
                { "client_id", "admin-cli" },
                { "username", keycloakSettings["AdminUsername"] ?? string.Empty },
                { "password", keycloakSettings["AdminPassword"] ?? string.Empty },
                { "grant_type", "password" }
            });

            var response = await _httpClient.PostAsync(tokenEndpoint, content);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogError("Admin authentication failed. Status: {Status}", response.StatusCode);
                return string.Empty;
            }

            var tokenResponse = await response.Content.ReadFromJsonAsync<KeycloakTokenResponse>();
            return tokenResponse?.AccessToken ?? string.Empty;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting admin token");
            return string.Empty;
        }
    }

    private async Task<string> GetUserIdByEmail(string email, string adminToken)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var usersEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users?email={Uri.EscapeDataString(email)}";

            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var response = await _httpClient.GetAsync(usersEndpoint);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Getting user ID by email failed. Status code: {StatusCode}", response.StatusCode);
                return string.Empty;
            }

            var users = await response.Content.ReadFromJsonAsync<List<KeycloakUser>>();
            return users?.FirstOrDefault(u => u.Email?.Equals(email, StringComparison.OrdinalIgnoreCase) == true)?.Id ?? string.Empty;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting user ID by email for {Email}", email);
            return string.Empty;
        }
    }

    private async Task<string> GetUserEmailById(string userId, string adminToken)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var userEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/users/{userId}";

            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var response = await _httpClient.GetAsync(userEndpoint);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Getting user email by ID failed. Status code: {StatusCode}", response.StatusCode);
                return string.Empty;
            }

            var user = await response.Content.ReadFromJsonAsync<KeycloakUser>();
            return user?.Email ?? string.Empty;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting user email for ID {UserId}", userId);
            return string.Empty;
        }
    }

    private async Task<string> GetRoleId(string roleName, string adminToken)
    {
        try
        {
            var keycloakSettings = _configuration.GetSection("KeycloakSettings");
            var rolesEndpoint = $"{keycloakSettings["Authority"]}/admin/realms/{keycloakSettings["Realm"]}/roles/{roleName}";

            _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", adminToken);
            var response = await _httpClient.GetAsync(rolesEndpoint);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Getting role ID failed. Status code: {StatusCode}", response.StatusCode);
                return string.Empty;
            }

            var role = await response.Content.ReadFromJsonAsync<KeycloakRole>();
            return role?.Id ?? string.Empty;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting role ID for {RoleName}", roleName);
            return string.Empty;
        }
    }
}

// DTO classes for Keycloak
public class KeycloakTokenResponse
{
    public string AccessToken { get; set; } = string.Empty;
    public string RefreshToken { get; set; } = string.Empty;
    public int ExpiresIn { get; set; }
    public int RefreshExpiresIn { get; set; }
    public string TokenType { get; set; } = string.Empty;
}

public class KeycloakUser
{
    public string? Id { get; set; }
    public string? Username { get; set; }
    public string? Email { get; set; }
    public bool? Enabled { get; set; }
    public bool? EmailVerified { get; set; }
}

public class KeycloakRole
{
    public string? Id { get; set; }
    public string? Name { get; set; }
    public string? Description { get; set; }
    public bool? Composite { get; set; }
    public bool? ClientRole { get; set; }
    public string? ContainerId { get; set; }
}
