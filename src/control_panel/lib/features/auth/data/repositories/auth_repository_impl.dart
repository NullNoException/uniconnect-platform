import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/datasources/auth_data_source.dart';
import '../../domain/models/auth_state.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._dataSource, this._prefs);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dataSource.login(request);

    // Save auth data to shared preferences
    await _prefs.setString(PreferenceKeys.authToken, response.token);
    await _prefs.setString(PreferenceKeys.refreshToken, response.refreshToken);
    await _prefs.setString(PreferenceKeys.userId, response.userId);
    await _prefs.setString(PreferenceKeys.userEmail, response.email);
    await _prefs.setStringList(PreferenceKeys.userRole, response.roles);
    await _prefs.setString(PreferenceKeys.tokenExpiresAt, response.expiresAt);

    return response;
  }

  @override
  Future<void> logout() async {
    // Clear auth data from shared preferences
    await _prefs.remove(PreferenceKeys.authToken);
    await _prefs.remove(PreferenceKeys.refreshToken);
    await _prefs.remove(PreferenceKeys.userId);
    await _prefs.remove(PreferenceKeys.userName);
    await _prefs.remove(PreferenceKeys.userEmail);
    await _prefs.remove(PreferenceKeys.userRole);
    await _prefs.remove(PreferenceKeys.tokenExpiresAt);

    return;
  }

  @override
  Future<void> forgotPassword(ForgotPasswordRequest request) {
    return _dataSource.forgotPassword(request);
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) {
    return _dataSource.resetPassword(request);
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) {
    return _dataSource.changePassword(request);
  }

  @override
  Future<User> getCurrentUser() async {
    final userId = _prefs.getString(PreferenceKeys.userId);
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return _dataSource.getCurrentUser(userId);
  }

  @override
  Future<bool> refreshToken() async {
    final refreshToken = _prefs.getString(PreferenceKeys.refreshToken);
    if (refreshToken == null) {
      return false;
    }

    try {
      final response = await _dataSource.refreshToken(refreshToken);

      // Update auth data in shared preferences
      await _prefs.setString(PreferenceKeys.authToken, response.token);
      await _prefs.setString(
        PreferenceKeys.refreshToken,
        response.refreshToken,
      );
      await _prefs.setString(PreferenceKeys.userId, response.userId);
      await _prefs.setString(PreferenceKeys.userEmail, response.email);
      await _prefs.setStringList(PreferenceKeys.userRole, response.roles);
      await _prefs.setString(PreferenceKeys.tokenExpiresAt, response.expiresAt);

      return true;
    } catch (e) {
      // If refresh token fails, clear all auth data
      await logout();
      return false;
    }
  }
}
