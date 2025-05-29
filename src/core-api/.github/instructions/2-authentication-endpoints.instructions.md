---
applyTo: '**'
---

Coding standards, domain knowledge, and preferences that AI should follow.

### 4.1 Authentication Endpoints

The UniConnect Core API implements authentication endpoints that integrate with Keycloak for identity and access management. These endpoints handle user authentication, token validation, and user session management.

#### 4.1.1 Authenticate User

- **Endpoint**: POST /api/v1/auth/login
- **Method**: POST
- **Content-Type**: application/json
- **Description**: Authenticates user with Keycloak and returns application tokens
- **Request Body**:
  ```json
  {
    "email": "john.doe@example.com",
    "password": "userPassword123",
    "clientId": "uniconnect-admin-panel",
    "rememberMe": true
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "data": {
      "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "expiresIn": 3600,
      "tokenType": "Bearer",
      "user": {
        "id": "user-uuid",
        "email": "john.doe@example.com",
        "firstName": "John",
        "lastName": "Doe",
        "userType": "Student",
        "roles": ["student", "user"],
        "isEmailVerified": true
      }
    }
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized, 422 Unprocessable Entity

#### 4.1.2 OAuth Callback Handler

- **Endpoint**: POST /api/v1/auth/oauth/callback
- **Method**: POST
- **Content-Type**: application/json
- **Description**: Handles OAuth callback from Keycloak and processes authorization code
- **Request Body**:
  ```json
  {
    "code": "authorization_code_from_keycloak",
    "state": "csrf_protection_state",
    "clientId": "uniconnect-admin-panel",
    "redirectUri": "https://admin.uniconnect.com/callback"
  }
  ```
- **Response**: Same as Authenticate User response
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

#### 4.1.3 Refresh Access Token

- **Endpoint**: POST /api/v1/auth/refresh
- **Method**: POST
- **Content-Type**: application/json
- **Authorization**: Bearer refresh_token (or in request body)
- **Description**: Refreshes access token using refresh token
- **Request Body**:
  ```json
  {
    "refreshToken": "refresh_token_value",
    "clientId": "uniconnect-admin-panel"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "data": {
      "accessToken": "new_access_token",
      "refreshToken": "new_refresh_token",
      "expiresIn": 3600,
      "tokenType": "Bearer"
    }
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

#### 4.1.4 Validate Token

- **Endpoint**: POST /api/v1/auth/validate
- **Method**: POST
- **Content-Type**: application/json
- **Authorization**: Bearer access_token
- **Description**: Validates access token with Keycloak and returns user info
- **Request Body**:
  ```json
  {
    "token": "access_token_to_validate"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "data": {
      "isValid": true,
      "user": {
        "id": "user-uuid",
        "email": "john.doe@example.com",
        "firstName": "John",
        "lastName": "Doe",
        "userType": "Student",
        "roles": ["student", "user"],
        "permissions": ["read:profile", "write:profile"]
      },
      "expiresAt": "2024-01-01T12:00:00Z"
    }
  }
  ```
- **Status Codes**: 200 OK, 401 Unauthorized

#### 4.1.5 Get Current User

- **Endpoint**: GET /api/v1/auth/me
- **Method**: GET
- **Authorization**: Bearer access_token required
- **Description**: Returns current authenticated user information
- **Response**:
  ```json
  {
    "success": true,
    "data": {
      "id": "user-uuid",
      "email": "john.doe@example.com",
      "firstName": "John",
      "lastName": "Doe",
      "userType": "Student",
      "status": "Active",
      "roles": ["student", "user"],
      "permissions": ["read:profile", "write:profile"],
      "lastLoginDate": "2024-01-01T10:00:00Z",
      "profilePictureUrl": "https://storage.uniconnect.com/avatars/user-uuid.jpg"
    }
  }
  ```
- **Status Codes**: 200 OK, 401 Unauthorized

#### 4.1.6 Logout User

- **Endpoint**: POST /api/v1/auth/logout
- **Method**: POST
- **Authorization**: Bearer access_token required
- **Content-Type**: application/json
- **Description**: Logs out user from Keycloak and invalidates tokens
- **Request Body**:
  ```json
  {
    "refreshToken": "refresh_token_value",
    "logoutFromKeycloak": true
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "User logged out successfully"
  }
  ```
- **Status Codes**: 200 OK, 401 Unauthorized

#### 4.1.7 Register User

- **Endpoint**: POST /api/v1/auth/register
- **Method**: POST
- **Content-Type**: application/json
- **Description**: Registers new user in Keycloak and local database
- **Request Body**:
  ```json
  {
    "email": "john.doe@example.com",
    "password": "userPassword123",
    "confirmPassword": "userPassword123",
    "firstName": "John",
    "lastName": "Doe",
    "userType": "Student",
    "phoneNumber": "+1234567890",
    "preferredLanguage": "en",
    "agreeToTerms": true
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "data": {
      "userId": "user-uuid",
      "email": "john.doe@example.com",
      "emailVerificationRequired": true,
      "message": "Registration successful. Please check your email for verification."
    }
  }
  ```
- **Status Codes**: 201 Created, 400 Bad Request, 409 Conflict

#### 4.1.8 Verify Email

- **Endpoint**: POST /api/v1/auth/verify-email
- **Method**: POST
- **Content-Type**: application/json
- **Description**: Verifies user email using verification token
- **Request Body**:
  ```json
  {
    "token": "email_verification_token",
    "email": "john.doe@example.com"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "Email verified successfully"
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 404 Not Found

#### 4.1.9 Forgot Password

- **Endpoint**: POST /api/v1/auth/forgot-password
- **Method**: POST
- **Content-Type**: application/json
- **Description**: Initiates password reset process via Keycloak
- **Request Body**:
  ```json
  {
    "email": "john.doe@example.com",
    "clientId": "uniconnect-admin-panel"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "Password reset email sent successfully"
  }
  ```
- **Status Codes**: 200 OK, 404 Not Found

#### 4.1.10 Reset Password

- **Endpoint**: POST /api/v1/auth/reset-password
- **Method**: POST
- **Content-Type**: application/json
- **Description**: Resets user password using reset token
- **Request Body**:
  ```json
  {
    "token": "password_reset_token",
    "newPassword": "newPassword123",
    "confirmPassword": "newPassword123"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "Password reset successfully"
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 404 Not Found

#### 4.1.11 Change Password

- **Endpoint**: POST /api/v1/auth/change-password
- **Method**: POST
- **Authorization**: Bearer access_token required
- **Content-Type**: application/json
- **Description**: Changes user password (requires current password)
- **Request Body**:
  ```json
  {
    "currentPassword": "currentPassword123",
    "newPassword": "newPassword123",
    "confirmPassword": "newPassword123"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "Password changed successfully"
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

#### 4.1.12 Revoke Token

- **Endpoint**: POST /api/v1/auth/revoke
- **Method**: POST
- **Authorization**: Bearer access_token required
- **Content-Type**: application/json
- **Description**: Revokes refresh token in Keycloak
- **Request Body**:
  ```json
  {
    "refreshToken": "refresh_token_to_revoke"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "Token revoked successfully"
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

#### 4.1.13 Get User Sessions

- **Endpoint**: GET /api/v1/auth/sessions
- **Method**: GET
- **Authorization**: Bearer access_token required
- **Description**: Returns active user sessions from Keycloak
- **Response**:
  ```json
  {
    "success": true,
    "data": [
      {
        "sessionId": "session-uuid",
        "clientId": "uniconnect-admin-panel",
        "ipAddress": "192.168.1.1",
        "userAgent": "Mozilla/5.0...",
        "lastAccess": "2024-01-01T11:00:00Z",
        "started": "2024-01-01T10:00:00Z",
        "isCurrent": true
      }
    ]
  }
  ```
- **Status Codes**: 200 OK, 401 Unauthorized

#### 4.1.14 Terminate Session

- **Endpoint**: DELETE /api/v1/auth/sessions/{sessionId}
- **Method**: DELETE
- **Authorization**: Bearer access_token required
- **Description**: Terminates specific user session in Keycloak
- **Response**:
  ```json
  {
    "success": true,
    "message": "Session terminated successfully"
  }
  ```
- **Status Codes**: 200 OK, 401 Unauthorized, 404 Not Found

#### 4.1.15 Enable Two-Factor Authentication

- **Endpoint**: POST /api/v1/auth/2fa/enable
- **Method**: POST
- **Authorization**: Bearer access_token required
- **Content-Type**: application/json
- **Description**: Enables 2FA for user account
- **Request Body**:
  ```json
  {
    "password": "currentPassword123"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "data": {
      "qrCodeUrl": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...",
      "secretKey": "JBSWY3DPEHPK3PXP",
      "backupCodes": ["12345678", "87654321", "11111111"]
    }
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

#### 4.1.16 Verify Two-Factor Authentication Setup

- **Endpoint**: POST /api/v1/auth/2fa/verify-setup
- **Method**: POST
- **Authorization**: Bearer access_token required
- **Content-Type**: application/json
- **Description**: Verifies 2FA setup with TOTP code
- **Request Body**:
  ```json
  {
    "totpCode": "123456"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "Two-factor authentication enabled successfully"
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

#### 4.1.17 Disable Two-Factor Authentication

- **Endpoint**: POST /api/v1/auth/2fa/disable
- **Method**: POST
- **Authorization**: Bearer access_token required
- **Content-Type**: application/json
- **Description**: Disables 2FA for user account
- **Request Body**:
  ```json
  {
    "password": "currentPassword123",
    "totpCode": "123456"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "Two-factor authentication disabled successfully"
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

#### 4.1.18 Social Login Initiation

- **Endpoint**: GET /api/v1/auth/social/{provider}
- **Method**: GET
- **Description**: Initiates social login flow (Google, Facebook, etc.)
- **Path Parameters**:
  - provider: string (google, facebook, github, linkedin)
- **Query Parameters**:
  - redirect_uri: string (optional)
  - state: string (optional)
- **Response**: 302 Redirect to social provider
- **Status Codes**: 302 Found, 400 Bad Request

#### 4.1.19 Social Login Callback

- **Endpoint**: POST /api/v1/auth/social/{provider}/callback
- **Method**: POST
- **Content-Type**: application/json
- **Description**: Handles social login callback
- **Path Parameters**:
  - provider: string (google, facebook, github, linkedin)
- **Request Body**:
  ```json
  {
    "code": "authorization_code_from_provider",
    "state": "csrf_protection_state"
  }
  ```
- **Response**: Same as Authenticate User response
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

#### 4.1.20 Link Social Account

- **Endpoint**: POST /api/v1/auth/social/{provider}/link
- **Method**: POST
- **Authorization**: Bearer access_token required
- **Content-Type**: application/json
- **Description**: Links social account to existing user account
- **Path Parameters**:
  - provider: string (google, facebook, github, linkedin)
- **Request Body**:
  ```json
  {
    "code": "authorization_code_from_provider",
    "state": "csrf_protection_state"
  }
  ```
- **Response**:
  ```json
  {
    "success": true,
    "message": "Social account linked successfully"
  }
  ```
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized, 409 Conflict

#### 4.1.21 Unlink Social Account

- **Endpoint**: DELETE /api/v1/auth/social/{provider}
- **Method**: DELETE
- **Authorization**: Bearer access_token required
- **Description**: Unlinks social account from user account
- **Path Parameters**:
  - provider: string (google, facebook, github, linkedin)
- **Response**:
  ```json
  {
    "success": true,
    "message": "Social account unlinked successfully"
  }
  ```
- **Status Codes**: 200 OK, 401 Unauthorized, 404 Not Found

### 4.1.22 Keycloak Integration Configuration

#### Backend Service Configuration

- **Keycloak Server URL**: https://keycloak.uniconnect.com/auth
- **Realm**: uniconnect
- **Client ID**: uniconnect-core-api
- **Client Secret**: Configured via environment variables
- **Grant Types**: authorization_code, refresh_token, client_credentials

#### API Client Roles Mapping

- **admin**: Maps to Keycloak admin role
- **service-provider**: Maps to Keycloak service-provider role
- **provider-staff**: Maps to Keycloak provider-staff role
- **student**: Maps to Keycloak student role
- **moderator**: Maps to Keycloak moderator role

#### Token Validation

- **JWT Signature Verification**: Using Keycloak's public keys (JWKS)
- **Token Introspection**: For detailed token validation
- **Role and Permission Mapping**: From Keycloak claims to application permissions

#### Error Handling

All authentication endpoints follow consistent error response format:

```json
{
  "success": false,
  "error": {
    "code": "AUTHENTICATION_FAILED",
    "message": "Invalid credentials provided",
    "details": {
      "field": "password",
      "reason": "Password does not meet requirements"
    }
  },
  "timestamp": "2024-01-01T12:00:00Z",
  "traceId": "trace-uuid"
}
```

#### Rate Limiting

- **Login attempts**: 5 attempts per 15 minutes per IP
- **Password reset**: 3 requests per hour per email
- **Token refresh**: 10 requests per minute per user
- **Registration**: 3 registrations per hour per IP
