import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_injection.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/universities/domain/repositories/university_repository.dart';

// Core providers
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  return locator<SharedPreferences>();
});

// Auth providers
final authDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return locator<AuthRemoteDataSource>();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return locator<AuthRepository>();
});

// User management providers
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return locator<UserRepository>();
});

// University management providers
final universityRepositoryProvider = Provider<UniversityRepository>((ref) {
  return locator<UniversityRepository>();
});

// Initialize all providers
void setupProviders() {
  // This ensures that dependency injection is properly set up before
  // providers are used
}
