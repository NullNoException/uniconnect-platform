import '../models/auth_state.dart';
import '../models/user.dart';

abstract class AuthDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<void> logout();
  Future<void> forgotPassword(ForgotPasswordRequest request);
  Future<void> resetPassword(ResetPasswordRequest request);
  Future<void> changePassword(ChangePasswordRequest request);
  Future<User> getCurrentUser(String userId);
  Future<LoginResponse> refreshToken(String refreshToken);
}
