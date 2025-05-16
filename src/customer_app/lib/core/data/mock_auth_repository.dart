import 'package:dartz/dartz.dart';
import 'package:customer_app/domain/entities/user.dart';
import 'package:customer_app/domain/repositories/auth_repository.dart';
import 'package:customer_app/core/errors/failures.dart';

class MockAuthRepository implements AuthRepository {
  User? _currentUser;

  @override
  Future<bool> isAuthenticated() async {
    return _currentUser != null;
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    if (_currentUser != null) {
      return Right(_currentUser!);
    } else {
      return Left(ServerFailure('No user logged in'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _currentUser = User(
      id: 'mock-user-id',
      email: email,
      firstName: 'John',
      lastName: 'Doe',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      isEmailVerified: true,
    );
    return Right(_currentUser!);
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    _currentUser = User(
      id: 'mock-user-id',
      email: email,
      firstName: firstName,
      lastName: lastName,
      createdAt: DateTime.now(),
      isEmailVerified: false,
    );
    return Right(_currentUser!);
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    _currentUser = null;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    // Simulate success
    return const Right(null);
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImage,
  }) async {
    if (_currentUser == null) {
      return Left(ServerFailure('No user logged in'));
    }
    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      firstName: firstName ?? _currentUser!.firstName,
      lastName: lastName ?? _currentUser!.lastName,
      phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
      profileImage: profileImage ?? _currentUser!.profileImage,
      createdAt: _currentUser!.createdAt,
      isEmailVerified: _currentUser!.isEmailVerified,
    );
    return Right(_currentUser!);
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Simulate success
    return const Right(null);
  }
}
