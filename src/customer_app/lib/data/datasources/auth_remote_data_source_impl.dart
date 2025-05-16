import 'package:dio/dio.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/api_client.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      return UserModel.fromJson(response.data['user']);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to sign in',
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
      final response = await client.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
        },
      );

      return UserModel.fromJson(response.data['user']);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to sign up',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await client.post('/auth/logout');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to sign out',
      );
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await client.post('/auth/password-reset', data: {'email': email});
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data?['message'] ??
            'Failed to send password reset email',
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

      final response = await client.patch('/user/profile', data: data);

      return UserModel.fromJson(response.data['user']);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to update profile',
      );
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await client.post(
        '/auth/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
      );
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to change password',
      );
    }
  }
}
