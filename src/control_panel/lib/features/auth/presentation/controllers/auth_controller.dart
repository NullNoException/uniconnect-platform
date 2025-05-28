import 'package:control_panel/core/utils/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/models/auth_state.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late final AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.read(authRepositoryProvider);

    // Check if user is already logged in
    final prefs = ref.read(sharedPreferencesProvider);
    final token = prefs.getString(PreferenceKeys.authToken);
    final refreshToken = prefs.getString(PreferenceKeys.refreshToken);
    final userId = prefs.getString(PreferenceKeys.userId);
    final roles = prefs.getStringList(PreferenceKeys.userRole);

    if (token != null &&
        refreshToken != null &&
        userId != null &&
        roles != null) {
      return AuthState(
        isAuthenticated: true,
        isLoading: false,
        token: token,
        refreshToken: refreshToken,
        userId: userId,
        roles: roles,
      );
    }

    return AuthState.initial();
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _repository.login(request);

      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        token: response.token,
        refreshToken: response.refreshToken,
        userId: response.userId,
        roles: response.roles,
      );

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.logout();

      state = AuthState.initial();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> forgotPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = ForgotPasswordRequest(email: email);
      await _repository.forgotPassword(request);

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> resetPassword(
    String token,
    String newPassword,
    String confirmPassword,
  ) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = ResetPasswordRequest(
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      await _repository.resetPassword(request);

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = ChangePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      await _repository.changePassword(request);

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> refreshAuthToken() async {
    if (state.refreshToken == null) {
      return false;
    }

    try {
      final result = await _repository.refreshToken();

      if (result) {
        // Update the state with the new token (repository already updated preferences)
        final prefs = ref.read(sharedPreferencesProvider);
        final newToken = prefs.getString(PreferenceKeys.authToken);
        final newRefreshToken = prefs.getString(PreferenceKeys.refreshToken);

        if (newToken != null && newRefreshToken != null) {
          state = state.copyWith(
            token: newToken,
            refreshToken: newRefreshToken,
          );
          return true;
        }
      }

      // If refresh failed, set state to unauthenticated
      state = AuthState.initial();
      return false;
    } catch (e) {
      state = AuthState.initial();
      return false;
    }
  }

  bool hasRole(String role) {
    return state.roles?.contains(role) ?? false;
  }

  bool isAdmin() {
    return hasRole(Roles.admin);
  }

  bool isProvider() {
    return hasRole(Roles.provider);
  }

  bool isProviderStaff() {
    return hasRole(Roles.providerStaff);
  }

  bool isModerator() {
    return hasRole(Roles.moderator);
  }
}

@riverpod
Future<User> currentUser(CurrentUserRef ref) async {
  final authState = ref.watch(authControllerProvider);
  if (!authState.isAuthenticated) {
    throw Exception('User not authenticated');
  }

  final repository = ref.read(authRepositoryProvider);
  return repository.getCurrentUser();
}
