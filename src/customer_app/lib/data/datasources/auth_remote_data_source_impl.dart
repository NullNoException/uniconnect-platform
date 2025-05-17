import 'package:dio/dio.dart';
import 'package:customer_app/core/errors/exceptions.dart';
import 'package:customer_app/core/network/api_client.dart';
import 'package:customer_app/data/models/user_model.dart';
import 'package:customer_app/data/datasources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final Response<dynamic> response = await client.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final Map<String, dynamic>? errorData =
          e.response?.data is Map<String, dynamic>
              ? e.response!.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: errorData?['message'] ?? 'Failed to sign in',
      );
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final Response<dynamic> response = await client.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
        },
      );

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final Map<String, dynamic>? errorData =
          e.response?.data is Map<String, dynamic>
              ? e.response!.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: errorData?['message'] ?? 'Failed to sign up',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final Response<dynamic> _ = await client.post('/auth/logout');
    } on DioException catch (e) {
      final Map<String, dynamic>? errorData =
          e.response?.data is Map<String, dynamic>
              ? e.response!.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: errorData?['message'] ?? 'Failed to sign out',
      );
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      final Response<dynamic> _ = await client.post(
        '/auth/password-reset',
        data: {'email': email},
      );
    } on DioException catch (e) {
      final Map<String, dynamic>? errorData =
          e.response?.data is Map<String, dynamic>
              ? e.response!.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: errorData?['message'] ?? 'Failed to send password reset email',
      );
    }
  }

  @override
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImage,
  }) async {
    try {
      final data = <String, dynamic>{};

      if (firstName != null) data['firstName'] = firstName;
      if (lastName != null) data['lastName'] = lastName;
      if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
      if (profileImage != null) data['profileImage'] = profileImage;

      final Response<dynamic> response = await client.patch(
        '/user/profile',
        data: data,
      );

      final Map<String, dynamic> respData =
          response.data as Map<String, dynamic>;
      return UserModel.fromJson(respData['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final Map<String, dynamic>? errorData =
          e.response?.data is Map<String, dynamic>
              ? e.response!.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: errorData?['message'] ?? 'Failed to update profile',
      );
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final Response<dynamic> _ = await client.post(
        '/auth/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
      );
    } on DioException catch (e) {
      final Map<String, dynamic>? errorData =
          e.response?.data is Map<String, dynamic>
              ? e.response!.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: errorData?['message'] ?? 'Failed to change password',
      );
    }
  }
}
