import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_injection.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/universities/domain/repositories/university_repository.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/datasources/mock_dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/models/dashboard_state.dart';
import '../../features/dashboard/presentation/controllers/dashboard_controller.dart';

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

// Dashboard providers
final dashboardDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  // For now, use mock data source for testing
  // In production, replace with: DashboardRemoteDataSourceImpl(apiClient)
  return MockDashboardRemoteDataSource();

  // Uncomment when backend is ready:
  // final apiClient = locator<ApiClient>();
  // return DashboardRemoteDataSourceImpl(apiClient);
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final dataSource = ref.read(dashboardDataSourceProvider);
  return DashboardRepositoryImpl(dataSource);
});

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
      final repository = ref.read(dashboardRepositoryProvider);
      return DashboardController(repository);
    });

// Initialize all providers
void setupProviders() {
  // This ensures that dependency injection is properly set up before
  // providers are used
}
