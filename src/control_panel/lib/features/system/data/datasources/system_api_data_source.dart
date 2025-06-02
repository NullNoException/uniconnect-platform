import '../../domain/datasources/system_data_source.dart';
import '../../domain/models/system.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';

class SystemApiDataSource implements SystemDataSource {
  final ApiClient _apiClient;

  SystemApiDataSource(this._apiClient);

  // UC-3.4.1: Platform Settings Configuration
  @override
  Future<List<PlatformSettingsListItem>> getSettings({
    required int page,
    required int pageSize,
    SettingCategory? category,
    String? searchQuery,
    bool? onlyEditable,
  }) async {
    final response = await _apiClient.get(
      ApiEndpoints.settings,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
        if (category != null) 'category': category.name,
        if (searchQuery != null) 'search': searchQuery,
        if (onlyEditable != null) 'onlyEditable': onlyEditable,
      },
    );

    final apiResponse = ApiResponse.fromJson(response.data);
    if (apiResponse.success) {
      final List<dynamic> data = apiResponse.data;
      return data
          .map((json) => PlatformSettingsListItem.fromJson(json))
          .toList();
    } else {
      throw Exception(apiResponse.message ?? 'Failed to fetch settings');
    }
  }

  @override
  Future<PlatformSettings> getSettingById(String id) async {
    final response = await _apiClient.get('${ApiEndpoints.settings}/$id');
    return PlatformSettings.fromJson(response.data);
  }

  @override
  Future<PlatformSettings> getSettingByKey(String key) async {
    final response = await _apiClient.get('${ApiEndpoints.settings}/key/$key');
    return PlatformSettings.fromJson(response.data);
  }

  @override
  Future<PlatformSettings> updateSetting(
    String id,
    SettingsUpdateRequest request,
  ) async {
    final response = await _apiClient.put(
      '${ApiEndpoints.settings}/$id',
      data: request.toJson(),
    );
    return PlatformSettings.fromJson(response.data);
  }

  @override
  Future<SystemConfiguration> getSystemConfiguration() async {
    final response = await _apiClient.get(ApiEndpoints.systemConfig);
    return SystemConfiguration.fromJson(response.data);
  }

  @override
  Future<SystemConfiguration> updateSystemConfiguration(
    Map<String, dynamic> configuration,
  ) async {
    final response = await _apiClient.put(
      ApiEndpoints.systemConfig,
      data: configuration,
    );
    return SystemConfiguration.fromJson(response.data);
  }

  @override
  Future<Map<String, bool>> getFeatureFlags() async {
    final response = await _apiClient.get(ApiEndpoints.featureFlags);
    return Map<String, bool>.from(response.data);
  }

  @override
  Future<Map<String, bool>> updateFeatureFlags(
    Map<String, bool> featureFlags,
  ) async {
    final response = await _apiClient.put(
      ApiEndpoints.featureFlags,
      data: featureFlags,
    );
    return Map<String, bool>.from(response.data);
  }

  @override
  Future<bool> toggleMaintenanceMode(bool enabled, String? reason) async {
    final response = await _apiClient.post(
      ApiEndpoints.maintenanceMode,
      data: {'enabled': enabled, if (reason != null) 'reason': reason},
    );
    return response.data['enabled'];
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
    final response = await _apiClient.get(
      ApiEndpoints.universities,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
        if (searchQuery != null) 'search': searchQuery,
        if (country != null) 'country': country,
        if (isActive != null) 'isActive': isActive,
        if (sortBy != null) 'sortBy': sortBy,
        if (sortDescending != null) 'sortDescending': sortDescending,
      },
    );

    final List<dynamic> data = response.data['data'];
    return data.map((json) => UniversityListItem.fromJson(json)).toList();
  }

  @override
  Future<University> getUniversityById(String id) async {
    final response = await _apiClient.get('${ApiEndpoints.universities}/$id');
    return University.fromJson(response.data);
  }

  @override
  Future<University> createUniversity(UniversityRequest request) async {
    final response = await _apiClient.post(
      ApiEndpoints.universities,
      data: request.toJson(),
    );
    return University.fromJson(response.data);
  }

  @override
  Future<University> updateUniversity(
    String id,
    UniversityRequest request,
  ) async {
    final response = await _apiClient.put(
      '${ApiEndpoints.universities}/$id',
      data: request.toJson(),
    );
    return University.fromJson(response.data);
  }

  @override
  Future<void> deleteUniversity(String id) async {
    await _apiClient.delete('${ApiEndpoints.universities}/$id');
  }

  @override
  Future<void> toggleUniversityStatus(String id, bool isActive) async {
    await _apiClient.patch(
      '${ApiEndpoints.universities}/$id/status',
      data: {'isActive': isActive},
    );
  }

  @override
  Future<List<String>> getCountries() async {
    final response = await _apiClient.get(ApiEndpoints.countries);
    return List<String>.from(response.data);
  }

  @override
  Future<List<String>> getCities(String country) async {
    final response = await _apiClient.get(
      ApiEndpoints.cities,
      queryParameters: {'country': country},
    );
    return List<String>.from(response.data);
  }

  @override
  Future<UniversityImportResult> importUniversities(
    UniversityImportRequest request,
  ) async {
    final response = await _apiClient.post(
      ApiEndpoints.universityImport,
      data: request.toJson(),
    );
    return UniversityImportResult.fromJson(response.data);
  }

  @override
  Future<Map<String, int>> getUniversityStatistics() async {
    final response = await _apiClient.get(ApiEndpoints.universityStats);
    return Map<String, int>.from(response.data);
  }

  @override
  Future<List<UniversityListItem>> searchUniversities({
    required String query,
    int? limit,
    String? country,
  }) async {
    final response = await _apiClient.get(
      ApiEndpoints.universitySearch,
      queryParameters: {
        'query': query,
        if (limit != null) 'limit': limit,
        if (country != null) 'country': country,
      },
    );

    final List<dynamic> data = response.data['data'];
    return data.map((json) => UniversityListItem.fromJson(json)).toList();
  }
}
