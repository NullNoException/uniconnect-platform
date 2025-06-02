import 'package:freezed_annotation/freezed_annotation.dart';

part 'system.freezed.dart';
part 'system.g.dart';

// UC-3.4.1: Platform Settings Configuration
@freezed
abstract class PlatformSettings with _$PlatformSettings {
  const factory PlatformSettings({
    required String id,
    required String settingKey,
    required String settingValue,
    required SettingCategory category,
    required SettingType type,
    required String displayName,
    required String description,
    required bool isPublic,
    required bool isEditable,
    String? defaultValue,
    String? validationRules,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? updatedBy,
  }) = _PlatformSettings;

  factory PlatformSettings.fromJson(Map<String, dynamic> json) =>
      _$PlatformSettingsFromJson(json);
}

@freezed
abstract class PlatformSettingsListItem with _$PlatformSettingsListItem {
  const factory PlatformSettingsListItem({
    required String id,
    required String settingKey,
    required String settingValue,
    required SettingCategory category,
    required SettingType type,
    required String displayName,
    required bool isEditable,
    required DateTime updatedAt,
  }) = _PlatformSettingsListItem;

  factory PlatformSettingsListItem.fromJson(Map<String, dynamic> json) =>
      _$PlatformSettingsListItemFromJson(json);
}

@freezed
abstract class SettingsUpdateRequest with _$SettingsUpdateRequest {
  const factory SettingsUpdateRequest({
    required String settingValue,
    String? reason,
  }) = _SettingsUpdateRequest;

  factory SettingsUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$SettingsUpdateRequestFromJson(json);
}

@freezed
abstract class SystemConfiguration with _$SystemConfiguration {
  const factory SystemConfiguration({
    required String version,
    required Map<String, String> settings,
    required Map<String, bool> featureFlags,
    required bool maintenanceMode,
    required DateTime lastUpdated,
    required String environment,
  }) = _SystemConfiguration;

  factory SystemConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SystemConfigurationFromJson(json);
}

// UC-3.4.2: University Data Management
@freezed
abstract class University with _$University {
  const factory University({
    required String id,
    required String name,
    required String country,
    required String city,
    String? website,
    String? logoUrl,
    String? description,
    required bool isActive,
    int? rankingNational,
    int? rankingInternational,
    int? establishedYear,
    int? studentCount,
    String? contactEmail,
    String? contactPhone,
    required List<String> programs,
    required List<String> faculties,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? createdBy,
  }) = _University;

  factory University.fromJson(Map<String, dynamic> json) =>
      _$UniversityFromJson(json);
}

@freezed
abstract class UniversityListItem with _$UniversityListItem {
  const factory UniversityListItem({
    required String id,
    required String name,
    required String country,
    required String city,
    required bool isActive,
    int? rankingNational,
    int? studentCount,
    required int programsCount,
    required DateTime updatedAt,
    required String type,
    required String description,
  }) = _UniversityListItem;

  factory UniversityListItem.fromJson(Map<String, dynamic> json) =>
      _$UniversityListItemFromJson(json);
}

@freezed
abstract class UniversityRequest with _$UniversityRequest {
  const factory UniversityRequest({
    required String name,
    required String country,
    required String city,
    String? website,
    String? logoUrl,
    String? description,
    bool? isActive,
    int? rankingNational,
    int? rankingInternational,
    int? establishedYear,
    int? studentCount,
    String? contactEmail,
    String? contactPhone,
    List<String>? programs,
    List<String>? faculties,
  }) = _UniversityRequest;

  factory UniversityRequest.fromJson(Map<String, dynamic> json) =>
      _$UniversityRequestFromJson(json);
}

@freezed
abstract class UniversityImportRequest with _$UniversityImportRequest {
  const factory UniversityImportRequest({
    required String source,
    required Map<String, dynamic> mappings,
    bool? validateOnly,
    bool? updateExisting,
  }) = _UniversityImportRequest;

  factory UniversityImportRequest.fromJson(Map<String, dynamic> json) =>
      _$UniversityImportRequestFromJson(json);
}

@freezed
abstract class UniversityImportResult with _$UniversityImportResult {
  const factory UniversityImportResult({
    required int totalProcessed,
    required int successfulImports,
    required int failedImports,
    required int updatedRecords,
    required List<String> errors,
    required List<String> warnings,
  }) = _UniversityImportResult;

  factory UniversityImportResult.fromJson(Map<String, dynamic> json) =>
      _$UniversityImportResultFromJson(json);
}

// Additional support models
@freezed
abstract class Country with _$Country {
  const factory Country({
    required String code,
    required String name,
    required String region,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@freezed
abstract class City with _$City {
  const factory City({
    required String name,
    required String country,
    required String region,
    int? population,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@freezed
abstract class UniversityStats with _$UniversityStats {
  const factory UniversityStats({
    required int totalUniversities,
    required int activeUniversities,
    required int inactiveUniversities,
    required int pendingUniversities,
    required Map<String, int> byCountry,
    required Map<String, int> byRegion,
  }) = _UniversityStats;

  factory UniversityStats.fromJson(Map<String, dynamic> json) =>
      _$UniversityStatsFromJson(json);
}

// Enums
enum SettingCategory {
  @JsonValue('general')
  general,
  @JsonValue('payment')
  payment,
  @JsonValue('notification')
  notification,
  @JsonValue('security')
  security,
  @JsonValue('integration')
  integration,
  @JsonValue('ui')
  ui,
  @JsonValue('business')
  business,
  @JsonValue('email')
  email,
  @JsonValue('analytics')
  analytics,
}

enum SettingType {
  @JsonValue('string')
  string,
  @JsonValue('number')
  number,
  @JsonValue('boolean')
  boolean,
  @JsonValue('json')
  json,
  @JsonValue('email')
  email,
  @JsonValue('url')
  url,
  @JsonValue('password')
  password,
}

enum UniversityStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('pending')
  pending,
  @JsonValue('suspended')
  suspended,
}
