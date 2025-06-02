import '../models/system.dart';

abstract class SystemDataSource {
  // UC-3.4.1: Platform Settings Configuration
  Future<List<PlatformSettingsListItem>> getSettings({
    required int page,
    required int pageSize,
    SettingCategory? category,
    String? searchQuery,
    bool? onlyEditable,
  });

  Future<PlatformSettings> getSettingById(String id);

  Future<PlatformSettings> getSettingByKey(String key);

  Future<PlatformSettings> updateSetting(
    String id,
    SettingsUpdateRequest request,
  );

  Future<SystemConfiguration> getSystemConfiguration();

  Future<SystemConfiguration> updateSystemConfiguration(
    Map<String, dynamic> configuration,
  );

  Future<Map<String, bool>> getFeatureFlags();

  Future<Map<String, bool>> updateFeatureFlags(Map<String, bool> featureFlags);

  Future<bool> toggleMaintenanceMode(bool enabled, String? reason);

  // UC-3.4.2: University Data Management
  Future<List<UniversityListItem>> getUniversities({
    required int page,
    required int pageSize,
    String? searchQuery,
    String? country,
    bool? isActive,
    String? sortBy,
    bool? sortDescending,
  });

  Future<University> getUniversityById(String id);

  Future<University> createUniversity(UniversityRequest request);

  Future<University> updateUniversity(String id, UniversityRequest request);

  Future<void> deleteUniversity(String id);

  Future<void> toggleUniversityStatus(String id, bool isActive);

  Future<List<String>> getCountries();

  Future<List<String>> getCities(String country);

  Future<UniversityImportResult> importUniversities(
    UniversityImportRequest request,
  );

  Future<Map<String, int>> getUniversityStatistics();

  Future<List<UniversityListItem>> searchUniversities({
    required String query,
    int? limit,
    String? country,
  });
}
