# Keycloak Realm Configuration

This directory contains the Keycloak realm configuration for the UniConnect platform.

## Overview

The `realm-export.json` file contains a complete Keycloak realm configuration that implements authentication and authorization best practices for the UniConnect platform.

## Realm Features

### Authentication Flows

- **Username/Password**: Traditional authentication for Admins and Service Providers
- **Social Login**: Google, Facebook, and Apple login for Customers and Service Providers
- **Email Verification**: Required for all users
- **Passwordless**: Email magic link and OTP support
- **Brute Force Protection**: Automatic account lockout after failed attempts

### User Roles & Hierarchy

The realm implements a hierarchical role system:

```
SuperAdmin (includes all permissions below)
├── Admin (includes all permissions below)
│   ├── ServiceProvider (includes all permissions below)
│   │   └── Customer (basic permissions)
```

**Role Descriptions:**

- **SuperAdmin**: Full system access, can manage all users and system settings
- **Admin**: Can manage users, view analytics, configure system settings
- **ServiceProvider**: Can provide services, manage their own content and bookings
- **Customer**: Can book services, manage personal profile

### Client Applications

1. **uniconnect-api** (Backend Service)

   - Bearer-only client for API authentication
   - Service account enabled for service-to-service communication
   - Client credentials flow

2. **uniconnect-admin** (Admin Web Panel)

   - Confidential client for admin web application
   - Authorization code flow
   - Supports refresh tokens

3. **uniconnect-mobile** (Mobile App)
   - Public client for mobile applications
   - Authorization code flow with PKCE
   - Support for deep linking and offline access

### Security Features

#### Token Configuration

- **Access Token Lifetime**: 15 minutes (secure default)
- **Refresh Token Lifetime**: 90 days
- **Offline Token Support**: Enabled for mobile apps
- **Token Reuse**: Disabled for security

#### Session Management

- **SSO Session Idle**: 30 minutes
- **SSO Session Max**: 10 hours
- **Remember Me**: Disabled (can be enabled per client)

#### Password Policies

- Minimum 8 characters
- Email verification required
- Password reset flow enabled
- Brute force protection enabled

## Installation & Deployment

### Development Environment

1. **Import Realm**:

   ```bash
   # Using Keycloak Admin CLI
   kubectl exec -it keycloak-pod -- /opt/keycloak/bin/kc.sh import --file /tmp/realm-export.json

   # Or via Docker
   docker exec -it keycloak-container /opt/keycloak/bin/kc.sh import --file /opt/keycloak/data/import/realm-export.json
   ```

2. **Configure Secrets**:
   Update the following client secrets in production:

   - `uniconnect-api-secret-change-in-production`
   - `uniconnect-admin-secret-change-in-production`
   - `uniconnect-mobile-secret-change-in-production`

3. **Social Login Setup**:
   Configure the identity providers with your credentials:
   - Google: Set `clientId` and `clientSecret`
   - Facebook: Set `clientId` and `clientSecret`
   - Apple: Set `clientId`, `teamId`, `keyId`, and `privateKey`

### Production Environment

1. **Security Checklist**:

   - [ ] Change all default client secrets
   - [ ] Configure proper redirect URIs for production domains
   - [ ] Set up SSL/TLS certificates
   - [ ] Configure SMTP for email verification
   - [ ] Review and adjust token lifetimes
   - [ ] Enable audit logging
   - [ ] Configure backup strategy

2. **Environment Variables**:

   ```bash
   # Keycloak Database
   KC_DB_URL=jdbc:postgresql://postgres:5432/keycloak
   KC_DB_USERNAME=uniconnect
   KC_DB_PASSWORD=your_secure_password

   # Keycloak Admin
   KEYCLOAK_ADMIN=admin
   KEYCLOAK_ADMIN_PASSWORD=your_admin_password

   # Production Settings
   KC_HOSTNAME=auth.uniconnect.app
   KC_PROXY=edge
   KC_HEALTH_ENABLED=true
   ```

### CI/CD Integration

The realm configuration can be automatically deployed using CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Deploy Keycloak Realm
  run: |
    kubectl create configmap keycloak-realm --from-file=realm-export.json
    kubectl apply -f keycloak-deployment.yaml
```

## API Integration

The .NET Core API has been configured to use this Keycloak realm:

- **Authentication**: JWT Bearer tokens issued by Keycloak
- **Authorization**: Role-based access control using Keycloak roles
- **User Management**: Integrated with Keycloak user management APIs

## Mobile App Integration

The mobile applications should configure Keycloak integration:

```javascript
// Example React Native configuration
const keycloakConfig = {
  url: 'https://auth.uniconnect.app',
  realm: 'uniconnect',
  clientId: 'uniconnect-mobile',
};
```

## Admin Panel Integration

The admin web panel should use the authorization code flow:

```javascript
// Example configuration
const keycloakConfig = {
  url: 'https://auth.uniconnect.app',
  realm: 'uniconnect',
  clientId: 'uniconnect-admin',
};
```

## Monitoring & Maintenance

### Health Checks

- Monitor Keycloak health endpoint: `https://auth.uniconnect.app/health`
- Check database connectivity
- Verify social login providers

### Regular Tasks

- Review user accounts and clean up inactive users
- Monitor authentication failures and adjust brute force settings
- Update social login provider configurations
- Review and rotate client secrets
- Update realm configuration as needed

## Troubleshooting

### Common Issues

1. **Social Login Not Working**:

   - Verify client IDs and secrets
   - Check redirect URI configuration
   - Ensure proper scopes are requested

2. **Token Validation Failures**:

   - Verify JWT signature validation
   - Check token expiration settings
   - Ensure proper audience configuration

3. **Role Assignment Issues**:
   - Verify role mapping configuration
   - Check composite role inheritance
   - Ensure proper client scope configuration

## Support

For issues related to this Keycloak configuration:

1. Check the Keycloak server logs
2. Verify the realm configuration matches this export
3. Ensure all client applications are properly configured
4. Contact the DevOps team for infrastructure issues
