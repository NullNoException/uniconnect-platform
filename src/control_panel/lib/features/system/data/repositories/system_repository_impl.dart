import '../../domain/datasources/system_data_source.dart';
import '../../domain/models/system.dart';
import '../../domain/repositories/system_repository.dart';

class SystemRepositoryImpl implements SystemRepository {
  final SystemDataSource _dataSource;

  SystemRepositoryImpl(this._dataSource);

  // UC-3.4.1: Platform Settings Configuration
  @override
  Future<List<PlatformSettingsListItem>> getSettings({
    required int page,
    required int pageSize,
    SettingCategory? category,
    String? searchQuery,
    bool? onlyEditable,
  }) async {
    return await _dataSource.getSettings(
      page: page,
      pageSize: pageSize,
      category: category,
      searchQuery: searchQuery,
      onlyEditable: onlyEditable,
    );
  }

  @override
  Future<PlatformSettings> getSettingById(String id) async {
    return await _dataSource.getSettingById(id);
  }

  @override
  Future<PlatformSettings> getSettingByKey(String key) async {
    return await _dataSource.getSettingByKey(key);
  }

  @override
  Future<PlatformSettings> updateSetting(
    String id,
    SettingsUpdateRequest request,
  ) async {
    return await _dataSource.updateSetting(id, request);
  }

  @override
  Future<SystemConfiguration> getSystemConfiguration() async {
    return await _dataSource.getSystemConfiguration();
  }

  @override
  Future<SystemConfiguration> updateSystemConfiguration(
    Map<String, dynamic> configuration,
  ) async {
    return await _dataSource.updateSystemConfiguration(configuration);
  }

  @override
  Future<Map<String, bool>> getFeatureFlags() async {
    return await _dataSource.getFeatureFlags();
  }

  @override
  Future<Map<String, bool>> updateFeatureFlags(
    Map<String, bool> featureFlags,
  ) async {
    return await _dataSource.updateFeatureFlags(featureFlags);
  }

  @override
  Future<bool> toggleMaintenanceMode(bool enabled, String? reason) async {
    return await _dataSource.toggleMaintenanceMode(enabled, reason);
  }

  // UC-3.4.2: University Data Management
  @override
  Future<List<UniversityListItem>> getUniversities({
    required int page,
    required int pageSize,
    String? searchQuery,
    String? country,
    bool? isActive,
    String? sortBy,
    bool? sortDescending,
  }) async {
    return await _dataSource.getUniversities(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      country: country,
      isActive: isActive,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }

  @override
  Future<University> getUniversityById(String id) async {
    return await _dataSource.getUniversityById(id);
  }

  @override
  Future<University> createUniversity(UniversityRequest request) async {
    return await _dataSource.createUniversity(request);
  }

  @override
  Future<University> updateUniversity(
    String id,
    UniversityRequest request,
  ) async {
    return await _dataSource.updateUniversity(id, request);
  }

  @override
  Future<void> deleteUniversity(String id) async {
    return await _dataSource.deleteUniversity(id);
  }

  @override
  Future<void> toggleUniversityStatus(String id, bool isActive) async {
    return await _dataSource.toggleUniversityStatus(id, isActive);
  }

  @override
  Future<List<String>> getCountries() async {
    return await _dataSource.getCountries();
  }

  @override
  Future<List<String>> getCities(String country) async {
    return await _dataSource.getCities(country);
  }

  @override
  Future<UniversityImportResult> importUniversities(
    UniversityImportRequest request,
  ) async {
    return await _dataSource.importUniversities(request);
  }

  @override
  Future<Map<String, int>> getUniversityStatistics() async {
    return await _dataSource.getUniversityStatistics();
  }

  @override
  Future<List<UniversityListItem>> searchUniversities({
    required String query,
    int? limit,
    String? country,
  }) async {
    return await _dataSource.searchUniversities(
      query: query,
      limit: limit,
      country: country,
    );
  }
}
