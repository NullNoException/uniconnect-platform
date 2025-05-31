
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/datasources/auth_data_source.dart';
import '../../domain/models/auth_state.dart';
import '../../domain/models/user.dart';

class AuthRemoteDataSource implements AuthDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSource(this._apiClient);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  @override
  Future<void> logout() async {
    // No explicit logout endpoint in the API, usually handled client-side
    // by removing the token
    return;
  }

  @override
  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    await _apiClient.post(ApiEndpoints.forgotPassword, data: request.toJson());
    return;
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _apiClient.post(ApiEndpoints.resetPassword, data: request.toJson());
    return;
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    await _apiClient.post(ApiEndpoints.changePassword, data: request.toJson());
    return;
  }

  @override
  Future<User> getCurrentUser(String userId) async {
    final response = await _apiClient.get('${ApiEndpoints.userById}$userId');
    return User.fromJson(response.data);
  }

  @override
  Future<LoginResponse> refreshToken(String refreshToken) async {
    final response = await _apiClient.post(
      ApiEndpoints.refreshToken,
      data: {'refreshToken': refreshToken},
    );
    return LoginResponse.fromJson(response.data);
  }
}
