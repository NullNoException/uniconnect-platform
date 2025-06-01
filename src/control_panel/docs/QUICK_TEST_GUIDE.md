# Quick Authentication Test Guide

## 🚀 Quick Start

### 1. Run the Application

```bash
cd /path/to/control_panel
flutter run -d chrome
```

### 2. Access Auth Demo

Navigate to: `http://localhost:PORT/auth-demo`

### 3. Test Basic Flow

1. **Login**: Enter credentials and click "Login"
2. **View Status**: Check token info in "Authentication Status" section
3. **Test Refresh**: Click "Refresh Token" button
4. **Logout**: Click "Logout" to clear session

## 🧪 Test Scenarios

### Scenario A: Successful Authentication

- ✅ Login with valid credentials
- ✅ Verify tokens are stored
- ✅ Check user roles are displayed
- ✅ Confirm API calls include Authorization header

### Scenario B: Token Management

- ✅ Manual token refresh works
- ✅ Token expiration time is tracked
- ✅ Automatic refresh on API calls (when implemented with real server)

### Scenario C: Session Cleanup

- ✅ Logout clears all authentication data
- ✅ Redirects to login screen
- ✅ No auth headers on subsequent requests

## 🔧 Demo Screen Features

The auth demo screen (`/auth-demo`) provides:

- **Interactive Login Form**: Test login with any credentials
- **Real-time Auth Status**: View current authentication state
- **Token Information**: Display token, expiry, roles, etc.
- **Manual Actions**: Refresh tokens, logout, etc.
- **Role Testing**: Verify role-based access methods
- **Password Management**: Test password change functionality

## 📱 Next Steps

Once the demo works locally:

1. **Configure API Base URL**: Update for your backend server
2. **Test with Real API**: Replace demo with actual authentication server
3. **Verify Network Scenarios**: Test offline/online transitions
4. **Check Role Permissions**: Ensure role-based access works as expected

## 🆘 Troubleshooting

**Issue**: Demo screen not loading

- **Solution**: Check route is added to router (`/auth-demo`)

**Issue**: Login not working

- **Solution**: This is expected without real API - check auth state updates

**Issue**: Navigation problems

- **Solution**: Verify router configuration includes auth demo route

## 📚 Full Documentation

- **Technical Details**: `docs/AUTHENTICATION.md`
- **Integration Guide**: `docs/AUTH_INTEGRATION_GUIDE.md`
- **Implementation Status**: `docs/AUTH_IMPLEMENTATION_STATUS.md`

---

**Ready to go!** 🎉 The authentication system is fully implemented and ready for testing.
