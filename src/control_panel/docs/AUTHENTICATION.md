# Enhanced Authentication System - UniConnect Control Panel

## Overview

The UniConnect control panel now has a robust JWT-based authentication system with automatic token refresh, role-based access control, and proper token expiration handling.

## Key Features

### ✅ JWT Authentication

- Secure token-based authentication using Bearer tokens
- Automatic token refresh to maintain user sessions
- Token expiration tracking with 5-minute buffer for auto-refresh

### ✅ Role-Based Access Control

- Support for multiple user roles: Admin, ServiceProvider, ProviderStaff, Moderator, Student
- Helper methods for checking user permissions
- Future-ready for implementing granular access controls

### ✅ API Integration

- Updated API endpoints to use control panel specific routes (`/api/control-panel/v1/auth/*`)
- Automatic token injection in API requests
- Transparent token refresh on 401 errors
- Proper error handling and user feedback

### ✅ Persistent Authentication

- Secure storage of authentication data using SharedPreferences
- Automatic restoration of user sessions on app restart
- Token expiration validation on app initialization

## Implementation Details

### Authentication Models

```dart
// AuthState - Main authentication state
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? token;
  final String? refreshToken;
  final String? userId;
  final String? email;
  final List<String>? roles;
  final DateTime? expiresAt;
  final String? error;
}

// LoginRequest - Login credentials
class LoginRequest {
  final String email;
  final String password;
}

// LoginResponse - API response with auth data
class LoginResponse {
  final String token;
  final String refreshToken;
  final String userId;
  final String email;
  final List<String> roles;
  final String expiresAt; // ISO string format
}
```

### API Endpoints

All authentication endpoints now use the control panel specific base path:

- Login: `POST /api/control-panel/v1/auth/login`
- Token Refresh: `POST /api/control-panel/v1/auth/refresh`
- Forgot Password: `POST /api/control-panel/v1/auth/forgot-password`
- Reset Password: `POST /api/control-panel/v1/auth/reset-password`
- Change Password: `POST /api/control-panel/v1/auth/change-password`

### Automatic Token Refresh

The API client now automatically handles token refresh:

1. Detects 401 Unauthorized responses
2. Attempts to refresh the token using the stored refresh token
3. Retries the original request with the new token
4. Clears authentication data if refresh fails

```dart
// Example usage - no manual token management needed
final response = await apiClient.get('/api/v1/users');
// Token refresh happens automatically if needed
```

### Authentication Controller

The `AuthController` provides comprehensive authentication management:

```dart
// Login
final success = await authController.login(email, password);

// Check authentication state
final isLoggedIn = authController.state.isAuthenticated;

// Role-based checks
final isAdmin = authController.isAdmin();
final hasRole = authController.hasRole('Moderator');

// Token validation
final isValid = await authController.ensureValidToken();

// Logout
await authController.logout();
```

### Persistence Configuration

Authentication data is stored using these preference keys:

```dart
class PreferenceKeys {
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userRole = 'user_role';
  static const String tokenExpiresAt = 'token_expires_at';
}
```

## Security Features

### Token Expiration

- Tokens include expiration timestamps
- Automatic validation on app startup
- Proactive refresh with 5-minute buffer
- Graceful handling of expired tokens

### Error Handling

- Comprehensive error messages for different failure scenarios
- Automatic cleanup on authentication failures
- User-friendly error feedback

### API Security

- Bearer token authentication for all API requests
- Automatic token injection via interceptors
- Secure token storage using platform-specific secure storage

## Testing

Comprehensive test suite covers:

- Authentication state management
- Model serialization/deserialization
- Login/logout flows
- Token refresh mechanics
- Role-based access control

Run tests with:

```bash
flutter test test/features/auth/auth_test.dart
```

## Router Integration

The authentication system is fully integrated with GoRouter:

- Automatic redirects to login when unauthenticated
- Protected routes that require authentication
- Persistent navigation state across app restarts
- Seamless user experience with automatic route management

## Usage Examples

### Basic Login Flow

```dart
// In your login screen
final authController = ref.read(authControllerProvider.notifier);
final success = await authController.login(email, password);

if (success) {
  // User is automatically redirected to dashboard
  context.go(AppRoutes.dashboard);
} else {
  // Show error message
  final error = ref.read(authControllerProvider).error;
  showSnackBar(error ?? 'Login failed');
}
```

### Role-Based UI

```dart
// Show admin-only features
Consumer(
  builder: (context, ref, child) {
    final authController = ref.watch(authControllerProvider.notifier);

    if (authController.isAdmin()) {
      return AdminPanel();
    } else {
      return RegularUserPanel();
    }
  },
)
```

### API Calls with Automatic Auth

```dart
// API calls automatically include authentication
final apiClient = ref.read(apiClientProvider);
final response = await apiClient.get('/api/v1/users');
// Token refresh happens automatically if needed
```

## Future Enhancements

- [ ] Biometric authentication support
- [ ] Multi-factor authentication (MFA)
- [ ] Session management with multiple devices
- [ ] Advanced role-based permissions with granular access control
- [ ] OAuth2 integration for third-party authentication
- [ ] Audit logging for authentication events

## Troubleshooting

### Common Issues

1. **Token Refresh Fails**

   - Check network connectivity
   - Verify refresh token validity
   - Ensure API endpoints are correct

2. **Authentication State Not Persisting**

   - Verify SharedPreferences permissions
   - Check for app data clearing

3. **Role Checks Not Working**
   - Ensure roles are properly set in API response
   - Verify role constants match API values

### Debug Information

Enable debug logging to track authentication flow:

```dart
// In debug mode, authentication events are logged
if (kDebugMode) {
  print('Token expired, refreshing...');
  print('Authentication state: ${authState.isAuthenticated}');
}
```

## Migration Notes

This update maintains backward compatibility while adding new features:

- Existing authentication flows continue to work
- New fields are optional and have sensible defaults
- API endpoints are updated but old flows remain functional
- No breaking changes to existing user sessions
