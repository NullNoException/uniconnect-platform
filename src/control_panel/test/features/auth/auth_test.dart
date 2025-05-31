import 'package:flutter_test/flutter_test.dart';
import 'package:control_panel/features/auth/domain/models/auth_state.dart';

void main() {
  group('AuthState Tests', () {
    test('AuthState.initial() should create initial state', () {
      const authState = AuthState(isAuthenticated: false, isLoading: false);
      
      expect(authState.isAuthenticated, false);
      expect(authState.isLoading, false);
      expect(authState.token, null);
      expect(authState.refreshToken, null);
      expect(authState.userId, null);
      expect(authState.email, null);
      expect(authState.roles, null);
      expect(authState.expiresAt, null);
      expect(authState.error, null);
    });

    test('AuthState should handle authentication state', () {
      final expiresAt = DateTime.now().add(const Duration(hours: 1));
      final authState = AuthState(
        isAuthenticated: true,
        isLoading: false,
        token: 'test_token',
        refreshToken: 'test_refresh_token',
        userId: 'user_123',
        email: 'test@example.com',
        roles: ['Admin'],
        expiresAt: expiresAt,
      );
      
      expect(authState.isAuthenticated, true);
      expect(authState.isLoading, false);
      expect(authState.token, 'test_token');
      expect(authState.refreshToken, 'test_refresh_token');
      expect(authState.userId, 'user_123');
      expect(authState.email, 'test@example.com');
      expect(authState.roles, ['Admin']);
      expect(authState.expiresAt, expiresAt);
    });
  });

  group('LoginRequest Tests', () {
    test('LoginRequest should create with email and password', () {
      const loginRequest = LoginRequest(
        email: 'test@example.com',
        password: 'password123',
      );
      
      expect(loginRequest.email, 'test@example.com');
      expect(loginRequest.password, 'password123');
    });

    test('LoginRequest should serialize to JSON', () {
      const loginRequest = LoginRequest(
        email: 'test@example.com',
        password: 'password123',
      );
      
      final json = loginRequest.toJson();
      expect(json['email'], 'test@example.com');
      expect(json['password'], 'password123');
    });

    test('LoginRequest should deserialize from JSON', () {
      final json = {
        'email': 'test@example.com',
        'password': 'password123',
      };
      
      final loginRequest = LoginRequest.fromJson(json);
      expect(loginRequest.email, 'test@example.com');
      expect(loginRequest.password, 'password123');
    });
  });

  group('LoginResponse Tests', () {
    test('LoginResponse should create with all required fields', () {
      const loginResponse = LoginResponse(
        token: 'test_token',
        refreshToken: 'test_refresh_token',
        userId: 'user_123',
        email: 'test@example.com',
        roles: ['Admin'],
        expiresAt: '2024-12-31T23:59:59Z',
      );
      
      expect(loginResponse.token, 'test_token');
      expect(loginResponse.refreshToken, 'test_refresh_token');
      expect(loginResponse.userId, 'user_123');
      expect(loginResponse.email, 'test@example.com');
      expect(loginResponse.roles, ['Admin']);
      expect(loginResponse.expiresAt, '2024-12-31T23:59:59Z');
    });

    test('LoginResponse should serialize to JSON', () {
      const loginResponse = LoginResponse(
        token: 'test_token',
        refreshToken: 'test_refresh_token',
        userId: 'user_123',
        email: 'test@example.com',
        roles: ['Admin'],
        expiresAt: '2024-12-31T23:59:59Z',
      );
      
      final json = loginResponse.toJson();
      expect(json['token'], 'test_token');
      expect(json['refreshToken'], 'test_refresh_token');
      expect(json['userId'], 'user_123');
      expect(json['email'], 'test@example.com');
      expect(json['roles'], ['Admin']);
      expect(json['expiresAt'], '2024-12-31T23:59:59Z');
    });

    test('LoginResponse should deserialize from JSON', () {
      final json = {
        'token': 'test_token',
        'refreshToken': 'test_refresh_token',
        'userId': 'user_123',
        'email': 'test@example.com',
        'roles': ['Admin'],
        'expiresAt': '2024-12-31T23:59:59Z',
      };
      
      final loginResponse = LoginResponse.fromJson(json);
      expect(loginResponse.token, 'test_token');
      expect(loginResponse.refreshToken, 'test_refresh_token');
      expect(loginResponse.userId, 'user_123');
      expect(loginResponse.email, 'test@example.com');
      expect(loginResponse.roles, ['Admin']);
      expect(loginResponse.expiresAt, '2024-12-31T23:59:59Z');
    });
  });

  group('Password Request Tests', () {
    test('ForgotPasswordRequest should work correctly', () {
      const request = ForgotPasswordRequest(email: 'test@example.com');
      expect(request.email, 'test@example.com');
      
      final json = request.toJson();
      expect(json['email'], 'test@example.com');
      
      final fromJson = ForgotPasswordRequest.fromJson({'email': 'test@example.com'});
      expect(fromJson.email, 'test@example.com');
    });

    test('ResetPasswordRequest should work correctly', () {
      const request = ResetPasswordRequest(
        token: 'reset_token',
        newPassword: 'new_password',
        confirmPassword: 'new_password',
      );
      
      expect(request.token, 'reset_token');
      expect(request.newPassword, 'new_password');
      expect(request.confirmPassword, 'new_password');
      
      final json = request.toJson();
      expect(json['token'], 'reset_token');
      expect(json['newPassword'], 'new_password');
      expect(json['confirmPassword'], 'new_password');
    });

    test('ChangePasswordRequest should work correctly', () {
      const request = ChangePasswordRequest(
        currentPassword: 'current_password',
        newPassword: 'new_password',
        confirmPassword: 'new_password',
      );
      
      expect(request.currentPassword, 'current_password');
      expect(request.newPassword, 'new_password');
      expect(request.confirmPassword, 'new_password');
      
      final json = request.toJson();
      expect(json['currentPassword'], 'current_password');
      expect(json['newPassword'], 'new_password');
      expect(json['confirmPassword'], 'new_password');
    });
  });
}
