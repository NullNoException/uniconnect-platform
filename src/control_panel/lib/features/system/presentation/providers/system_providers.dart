import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/dependency_injection.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/system_api_data_source.dart';
import '../../data/repositories/system_repository_impl.dart';
import '../../domain/models/system.dart';
import '../../domain/repositories/system_repository.dart';
import '../../domain/usecases/configure_platform_settings_usecase.dart';
import '../../domain/usecases/manage_university_data_usecase.dart';
import '../controllers/system_controller.dart';

// Data Source Provider
final systemDataSourceProvider = Provider<SystemApiDataSource>((ref) {
  // Use dependency injection to get ApiClient
  final apiClient = locator<ApiClient>();
  return SystemApiDataSource(apiClient);
});

// Repository Provider
final systemRepositoryProvider = Provider<SystemRepository>((ref) {
  final dataSource = ref.watch(systemDataSourceProvider);
  return SystemRepositoryImpl(dataSource);
});

// Use Cases Providers
final configurePlatformSettingsUseCaseProvider =
    Provider<ConfigurePlatformSettingsUseCase>((ref) {
      final repository = ref.watch(systemRepositoryProvider);
      return ConfigurePlatformSettingsUseCase.create(repository);
    });

final manageUniversityDataUseCaseProvider =
    Provider<ManageUniversityDataUseCase>((ref) {
      final repository = ref.watch(systemRepositoryProvider);
      return ManageUniversityDataUseCase.create(repository);
    });

// Controllers Providers
final platformSettingsControllerProvider =
    StateNotifierProvider<PlatformSettingsController, PlatformSettingsState>((
      ref,
    ) {
      final useCase = ref.watch(configurePlatformSettingsUseCaseProvider);
      return PlatformSettingsController(useCase);
    });

final universityControllerProvider =
    StateNotifierProvider<UniversityController, UniversityState>((ref) {
      final useCase = ref.watch(manageUniversityDataUseCaseProvider);
      return UniversityController(useCase);
    });

// Additional Providers for System Configuration
final systemConfigurationProvider = FutureProvider<SystemConfiguration>((
  ref,
) async {
  final useCase = ref.watch(configurePlatformSettingsUseCaseProvider);
  return await useCase.getSystemConfiguration();
});

final featureFlagsProvider = FutureProvider<Map<String, bool>>((ref) async {
  final useCase = ref.watch(configurePlatformSettingsUseCaseProvider);
  return await useCase.getFeatureFlags();
});

final countriesProvider = FutureProvider<List<String>>((ref) async {
  final useCase = ref.watch(manageUniversityDataUseCaseProvider);
  return await useCase.getCountries();
});

final universitiesStatsProvider = FutureProvider<UniversityStats>((ref) async {
  final useCase = ref.watch(manageUniversityDataUseCaseProvider);
  return await useCase.getUniversityStats.call();
});
