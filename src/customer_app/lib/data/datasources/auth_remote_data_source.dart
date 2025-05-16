import 'package:customer_app/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Signs in a user with email and password
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs up a new user with email and password
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  /// Signs out the current user
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<void> signOut();

  /// Sends a password reset email to the specified email
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<void> sendPasswordResetEmail(String email);

  /// Updates the user profile
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImage,
  });

  /// Changes the user's password
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
