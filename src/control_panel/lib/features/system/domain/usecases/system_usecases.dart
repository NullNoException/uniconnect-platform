import '../models/system.dart';
import '../repositories/system_repository.dart';

// UC-3.4.1: Platform Settings Configuration
class GetSettingsUseCase {
  final SystemRepository _repository;

  GetSettingsUseCase(this._repository);

  Future<List<PlatformSettingsListItem>> call({
    required int page,
    required int pageSize,
    SettingCategory? category,
    String? searchQuery,
    bool? onlyEditable,
  }) async {
    return await _repository.getSettings(
      page: page,
      pageSize: pageSize,
      category: category,
      searchQuery: searchQuery,
      onlyEditable: onlyEditable,
    );
  }
}

class GetSettingByIdUseCase {
  final SystemRepository _repository;

  GetSettingByIdUseCase(this._repository);

  Future<PlatformSettings> call(String id) async {
    return await _repository.getSettingById(id);
  }
}

class GetSettingByKeyUseCase {
  final SystemRepository _repository;

  GetSettingByKeyUseCase(this._repository);

  Future<PlatformSettings> call(String key) async {
    return await _repository.getSettingByKey(key);
  }
}

class UpdateSettingUseCase {
  final SystemRepository _repository;

  UpdateSettingUseCase(this._repository);

  Future<PlatformSettings> call(
    String id,
    SettingsUpdateRequest request,
  ) async {
    return await _repository.updateSetting(id, request);
  }
}

class GetSystemConfigurationUseCase {
  final SystemRepository _repository;

  GetSystemConfigurationUseCase(this._repository);

  Future<SystemConfiguration> call() async {
    return await _repository.getSystemConfiguration();
  }
}

class UpdateSystemConfigurationUseCase {
  final SystemRepository _repository;

  UpdateSystemConfigurationUseCase(this._repository);

  Future<SystemConfiguration> call(Map<String, dynamic> configuration) async {
    return await _repository.updateSystemConfiguration(configuration);
  }
}

class GetFeatureFlagsUseCase {
  final SystemRepository _repository;

  GetFeatureFlagsUseCase(this._repository);

  Future<Map<String, bool>> call() async {
    return await _repository.getFeatureFlags();
  }
}

class UpdateFeatureFlagsUseCase {
  final SystemRepository _repository;

  UpdateFeatureFlagsUseCase(this._repository);

  Future<Map<String, bool>> call(Map<String, bool> featureFlags) async {
    return await _repository.updateFeatureFlags(featureFlags);
  }
}

class ToggleMaintenanceModeUseCase {
  final SystemRepository _repository;

  ToggleMaintenanceModeUseCase(this._repository);

  Future<bool> call(bool enabled, String? reason) async {
    return await _repository.toggleMaintenanceMode(enabled, reason);
  }
}

// UC-3.4.2: University Data Management
class GetUniversitiesUseCase {
  final SystemRepository _repository;

  GetUniversitiesUseCase(this._repository);

  Future<List<UniversityListItem>> call({
    required int page,
    required int pageSize,
    String? searchQuery,
    String? country,
    bool? isActive,
    String? sortBy,
    bool? sortDescending,
  }) async {
    return await _repository.getUniversities(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      country: country,
      isActive: isActive,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }
}

class GetUniversityByIdUseCase {
  final SystemRepository _repository;

  GetUniversityByIdUseCase(this._repository);

  Future<University> call(String id) async {
    return await _repository.getUniversityById(id);
  }
}

class CreateUniversityUseCase {
  final SystemRepository _repository;

  CreateUniversityUseCase(this._repository);

  Future<University> call(UniversityRequest request) async {
    return await _repository.createUniversity(request);
  }
}

class UpdateUniversityUseCase {
  final SystemRepository _repository;

  UpdateUniversityUseCase(this._repository);

  Future<University> call(String id, UniversityRequest request) async {
    return await _repository.updateUniversity(id, request);
  }
}

class DeleteUniversityUseCase {
  final SystemRepository _repository;

  DeleteUniversityUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteUniversity(id);
  }
}

class ToggleUniversityStatusUseCase {
  final SystemRepository _repository;

  ToggleUniversityStatusUseCase(this._repository);

  Future<void> call(String id, bool isActive) async {
    return await _repository.toggleUniversityStatus(id, isActive);
  }
}

class GetCountriesUseCase {
  final SystemRepository _repository;

  GetCountriesUseCase(this._repository);

  Future<List<String>> call() async {
    return await _repository.getCountries();
  }
}

class GetCitiesUseCase {
  final SystemRepository _repository;

  GetCitiesUseCase(this._repository);

  Future<List<String>> call(String country) async {
    return await _repository.getCities(country);
  }
}

class ImportUniversitiesUseCase {
  final SystemRepository _repository;

  ImportUniversitiesUseCase(this._repository);

  Future<UniversityImportResult> call(UniversityImportRequest request) async {
    return await _repository.importUniversities(request);
  }
}

class GetUniversityStatisticsUseCase {
  final SystemRepository _repository;

  GetUniversityStatisticsUseCase(this._repository);

  Future<Map<String, int>> call() async {
    return await _repository.getUniversityStatistics();
  }
}

class SearchUniversitiesUseCase {
  final SystemRepository _repository;

  SearchUniversitiesUseCase(this._repository);

  Future<List<UniversityListItem>> call({
    required String query,
    int? limit,
    String? country,
  }) async {
    return await _repository.searchUniversities(
      query: query,
      limit: limit,
      country: country,
    );
  }
}

class ExportUniversitiesUseCase {
  final SystemRepository _repository;

  ExportUniversitiesUseCase(this._repository);

  Future<List<University>> call({
    String? format,
    List<String>? fields,
    String? country,
    bool? isActive,
  }) async {
    // For now, return all universities - can be enhanced to support filtering
    final universities = await _repository.getUniversities(
      page: 1,
      pageSize: 10000, // Large number to get all
      country: country,
      isActive: isActive,
    );

    // Convert list items to full university objects
    final List<University> fullUniversities = [];
    for (final item in universities) {
      final university = await _repository.getUniversityById(item.id);
      fullUniversities.add(university);
    }

    return fullUniversities;
  }
}

class GetUniversityStatsUseCase {
  final SystemRepository _repository;

  GetUniversityStatsUseCase(this._repository);

  Future<UniversityStats> call() async {
    final stats = await _repository.getUniversityStatistics();

    return UniversityStats(
      totalUniversities: stats['total'] ?? 0,
      activeUniversities: stats['active'] ?? 0,
      inactiveUniversities: stats['inactive'] ?? 0,
      pendingUniversities: stats['pending'] ?? 0,
      byCountry: stats['byCountry'] != null
          ? Map<String, int>.from(stats['byCountry'] as Map)
          : {},
      byRegion: stats['byRegion'] != null
          ? Map<String, int>.from(stats['byRegion'] as Map)
          : {},
    );
  }
}
