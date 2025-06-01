# Authentication System Integration Guide

This guide helps you test and integrate the enhanced authentication system with the actual API server.

## Quick Start

### 1. Access the Auth Demo Screen

Navigate to `/auth-demo` in your browser when running the control panel application to access the comprehensive authentication demo screen.

### 2. Demo Features Available

The auth demo screen provides interactive testing for:

- **Login Flow** - Test login with email/password
- **Token Management** - View current auth state and token info
- **Token Refresh** - Manually trigger token refresh
- **Role-Based Access** - Test different user roles
- **Password Management** - Change password functionality
- **Logout** - Complete logout and session cleanup

### 3. API Configuration

The system is configured to use these endpoints:

```dart
// Control Panel Authentication Endpoints
static const String login = '/api/control-panel/v1/auth/login';
static const String refreshToken = '/api/control-panel/v1/auth/refresh';
static const String forgotPassword = '/api/control-panel/v1/auth/forgot-password';
static const String resetPassword = '/api/control-panel/v1/auth/reset-password';
static const String changePassword = '/api/control-panel/v1/auth/change-password';
```

## Integration Steps

### Step 1: Configure Base URL

Update the base URL in your main.dart or environment configuration:

```dart
// For development
const String API_BASE_URL = 'http://localhost:3000';

// For production
const String API_BASE_URL = 'https://api.uniconnect.com';
```

### Step 2: Test Login Flow

1. Start your API server
2. Run the Flutter control panel application
3. Navigate to `/auth-demo`
4. Enter valid credentials and test login

### Step 3: Verify Token Management

The system automatically:

- ✅ Stores auth tokens in SharedPreferences
- ✅ Adds Authorization header to all API requests
- ✅ Detects 401 errors and attempts token refresh
- ✅ Retries failed requests with new tokens
- ✅ Clears auth data when refresh fails

### Step 4: Test Role-Based Authorization

The system supports these roles:

- `Admin` - Full system access
- `ServiceProvider` - Provider-specific access
- `ProviderStaff` - Limited provider access
- `Moderator` - Content moderation access
- `Student` - Read-only access for testing

## API Response Format

Ensure your API returns responses in this format:

### Login Response

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "userId": "user-uuid-here",
  "email": "user@example.com",
  "roles": ["Admin", "Moderator"],
  "expiresAt": "2024-01-15T10:30:00.000Z"
}
```

### Refresh Token Response

```json
{
  "token": "new-jwt-token",
  "refreshToken": "new-refresh-token",
  "userId": "user-uuid-here",
  "email": "user@example.com",
  "roles": ["Admin", "Moderator"],
  "expiresAt": "2024-01-15T11:30:00.000Z"
}
```

## Testing Scenarios

### Scenario 1: Successful Login

1. Use valid credentials
2. Verify token storage
3. Check automatic header injection
4. Confirm role-based UI updates

### Scenario 2: Token Expiration

1. Login successfully
2. Wait for token to expire (or modify expiry for testing)
3. Make an API request
4. Verify automatic refresh attempt
5. Confirm request retry with new token

### Scenario 3: Invalid Refresh Token

1. Login successfully
2. Manually corrupt refresh token in SharedPreferences
3. Make an API request after token expiry
4. Verify automatic logout and redirect to login

### Scenario 4: Network Errors

1. Disconnect network
2. Attempt login
3. Verify proper error handling
4. Reconnect and verify recovery

## Debugging

### Enable Debug Logging

The system uses Flutter's `kDebugMode` for logging. Key debug information includes:

- API request/response details
- Token expiration checks
- Refresh token attempts
- Authentication state changes

### Monitor SharedPreferences

Check these keys for stored auth data:

- `auth_token` - Current JWT token
- `refresh_token` - Refresh token
- `user_id` - User UUID
- `user_email` - User email address
- `user_role` - List of user roles
- `token_expires_at` - Token expiration timestamp

### Common Issues

**Issue**: 401 errors not triggering refresh

- **Solution**: Ensure API returns proper 401 status code

**Issue**: Refresh loop

- **Solution**: Check that refresh endpoint returns new tokens

**Issue**: Navigation issues after logout

- **Solution**: Verify router redirect logic

## Production Checklist

- [ ] Update API base URL for production
- [ ] Configure proper CORS settings on API server
- [ ] Test token refresh mechanism thoroughly
- [ ] Verify role-based access control
- [ ] Test session timeout handling
- [ ] Confirm logout clears all sensitive data
- [ ] Test with various network conditions

## Security Considerations

1. **Token Storage**: Tokens are stored in SharedPreferences (encrypted on device)
2. **HTTPS Only**: Ensure all API communication uses HTTPS in production
3. **Token Expiry**: Implement reasonable token expiry times (recommended: 15-60 minutes)
4. **Refresh Token Rotation**: Consider rotating refresh tokens on each use
5. **Logout**: Always clear tokens on logout or suspicious activity

## Support

If you encounter issues during integration:

1. Check the auth demo screen for visual debugging
2. Review Flutter debug logs for authentication errors
3. Verify API server logs for request/response details
4. Test with the provided test suite
5. Refer to the main AUTHENTICATION.md documentation for technical details
