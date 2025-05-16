import 'dart:async';

import '../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';
import 'auth_local_data_source.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  // Mock user data
  final Map<String, UserModel> _users = {
    'user@example.com': UserModel(
      id: '1',
      email: 'user@example.com',
      firstName: 'John',
      lastName: 'Doe',
      phoneNumber: '123-456-7890',
      profileImage: 'https://ui-avatars.com/api/?name=John+Doe',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      isEmailVerified: true,
    ),
  };

  UserModel? _currentUser;

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Check if user exists with the email
    final user = _users[email.toLowerCase()];
    if (user == null) {
      throw ServerException(message: 'User not found with this email');
    }

    // In a real app, we would verify the password hash
    // For mock, we'll just check if the password is 'password'
    if (password != 'password') {
      throw ServerException(message: 'Invalid password');
    }

    _currentUser = user;
    return user;
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Check if user already exists
    if (_users.containsKey(email.toLowerCase())) {
      throw ServerException(message: 'User already exists with this email');
    }

    // Create new user
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      firstName: firstName,
      lastName: lastName,
      profileImage: 'https://ui-avatars.com/api/?name=$firstName+$lastName',
      createdAt: DateTime.now(),
      isEmailVerified: false,
    );

    // Add user to mock database
    _users[email.toLowerCase()] = newUser;
    _currentUser = newUser;

    return newUser;
  }

  @override
  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if user exists with the email
    final user = _users[email.toLowerCase()];
    if (user == null) {
      throw ServerException(message: 'User not found with this email');
    }

    // In a real app, this would send an email
  }

  @override
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImage,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 700));

    if (_currentUser == null) {
      throw ServerException(message: 'User not authenticated');
    }

    // Update user profile
    final updatedUser = UserModel(
      id: _currentUser!.id,
      email: _currentUser!.email,
      firstName: firstName ?? _currentUser!.firstName,
      lastName: lastName ?? _currentUser!.lastName,
      phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
      profileImage: profileImage ?? _currentUser!.profileImage,
      createdAt: _currentUser!.createdAt,
      isEmailVerified: _currentUser!.isEmailVerified,
    );

    // Update in mock database
    _users[_currentUser!.email.toLowerCase()] = updatedUser;
    _currentUser = updatedUser;

    return updatedUser;
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    if (_currentUser == null) {
      throw ServerException(message: 'User not authenticated');
    }

    // In a real app, we would verify the current password
    if (currentPassword != 'password') {
      throw ServerException(message: 'Current password is incorrect');
    }

    // Password would be updated in a real database
  }
}

class MockAuthLocalDataSource implements AuthLocalDataSource {
  UserModel? _cachedUser;

  @override
  Future<UserModel?> getLastUser() async {
    return _cachedUser;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    _cachedUser = user;
  }

  @override
  Future<void> clearUser() async {
    _cachedUser = null;
  }
}
