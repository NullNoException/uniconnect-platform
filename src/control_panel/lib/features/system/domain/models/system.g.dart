// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlatformSettings _$PlatformSettingsFromJson(Map<String, dynamic> json) =>
    _PlatformSettings(
      id: json['id'] as String,
      settingKey: json['settingKey'] as String,
      settingValue: json['settingValue'] as String,
      category: $enumDecode(_$SettingCategoryEnumMap, json['category']),
      type: $enumDecode(_$SettingTypeEnumMap, json['type']),
      displayName: json['displayName'] as String,
      description: json['description'] as String,
      isPublic: json['isPublic'] as bool,
      isEditable: json['isEditable'] as bool,
      defaultValue: json['defaultValue'] as String?,
      validationRules: json['validationRules'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      updatedBy: json['updatedBy'] as String?,
    );

Map<String, dynamic> _$PlatformSettingsToJson(_PlatformSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'settingKey': instance.settingKey,
      'settingValue': instance.settingValue,
      'category': _$SettingCategoryEnumMap[instance.category]!,
      'type': _$SettingTypeEnumMap[instance.type]!,
      'displayName': instance.displayName,
      'description': instance.description,
      'isPublic': instance.isPublic,
      'isEditable': instance.isEditable,
      'defaultValue': instance.defaultValue,
      'validationRules': instance.validationRules,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'updatedBy': instance.updatedBy,
    };

const _$SettingCategoryEnumMap = {
  SettingCategory.general: 'general',
  SettingCategory.payment: 'payment',
  SettingCategory.notification: 'notification',
  SettingCategory.security: 'security',
  SettingCategory.integration: 'integration',
  SettingCategory.ui: 'ui',
  SettingCategory.business: 'business',
  SettingCategory.email: 'email',
  SettingCategory.analytics: 'analytics',
};

const _$SettingTypeEnumMap = {
  SettingType.string: 'string',
  SettingType.number: 'number',
  SettingType.boolean: 'boolean',
  SettingType.json: 'json',
  SettingType.email: 'email',
  SettingType.url: 'url',
  SettingType.password: 'password',
};

_PlatformSettingsListItem _$PlatformSettingsListItemFromJson(
  Map<String, dynamic> json,
) => _PlatformSettingsListItem(
  id: json['id'] as String,
  settingKey: json['settingKey'] as String,
  settingValue: json['settingValue'] as String,
  category: $enumDecode(_$SettingCategoryEnumMap, json['category']),
  type: $enumDecode(_$SettingTypeEnumMap, json['type']),
  displayName: json['displayName'] as String,
  isEditable: json['isEditable'] as bool,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PlatformSettingsListItemToJson(
  _PlatformSettingsListItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'settingKey': instance.settingKey,
  'settingValue': instance.settingValue,
  'category': _$SettingCategoryEnumMap[instance.category]!,
  'type': _$SettingTypeEnumMap[instance.type]!,
  'displayName': instance.displayName,
  'isEditable': instance.isEditable,
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_SettingsUpdateRequest _$SettingsUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _SettingsUpdateRequest(
  settingValue: json['settingValue'] as String,
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$SettingsUpdateRequestToJson(
  _SettingsUpdateRequest instance,
) => <String, dynamic>{
  'settingValue': instance.settingValue,
  'reason': instance.reason,
};

_SystemConfiguration _$SystemConfigurationFromJson(Map<String, dynamic> json) =>
    _SystemConfiguration(
      version: json['version'] as String,
      settings: Map<String, String>.from(json['settings'] as Map),
      featureFlags: Map<String, bool>.from(json['featureFlags'] as Map),
      maintenanceMode: json['maintenanceMode'] as bool,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      environment: json['environment'] as String,
    );

Map<String, dynamic> _$SystemConfigurationToJson(
  _SystemConfiguration instance,
) => <String, dynamic>{
  'version': instance.version,
  'settings': instance.settings,
  'featureFlags': instance.featureFlags,
  'maintenanceMode': instance.maintenanceMode,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
  'environment': instance.environment,
};

_University _$UniversityFromJson(Map<String, dynamic> json) => _University(
  id: json['id'] as String,
  name: json['name'] as String,
  country: json['country'] as String,
  city: json['city'] as String,
  website: json['website'] as String?,
  logoUrl: json['logoUrl'] as String?,
  description: json['description'] as String?,
  isActive: json['isActive'] as bool,
  rankingNational: (json['rankingNational'] as num?)?.toInt(),
  rankingInternational: (json['rankingInternational'] as num?)?.toInt(),
  establishedYear: (json['establishedYear'] as num?)?.toInt(),
  studentCount: (json['studentCount'] as num?)?.toInt(),
  contactEmail: json['contactEmail'] as String?,
  contactPhone: json['contactPhone'] as String?,
  programs: (json['programs'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  faculties: (json['faculties'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  createdBy: json['createdBy'] as String?,
);

Map<String, dynamic> _$UniversityToJson(_University instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'city': instance.city,
      'website': instance.website,
      'logoUrl': instance.logoUrl,
      'description': instance.description,
      'isActive': instance.isActive,
      'rankingNational': instance.rankingNational,
      'rankingInternational': instance.rankingInternational,
      'establishedYear': instance.establishedYear,
      'studentCount': instance.studentCount,
      'contactEmail': instance.contactEmail,
      'contactPhone': instance.contactPhone,
      'programs': instance.programs,
      'faculties': instance.faculties,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdBy': instance.createdBy,
    };

_UniversityListItem _$UniversityListItemFromJson(Map<String, dynamic> json) =>
    _UniversityListItem(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      isActive: json['isActive'] as bool,
      rankingNational: (json['rankingNational'] as num?)?.toInt(),
      studentCount: (json['studentCount'] as num?)?.toInt(),
      programsCount: (json['programsCount'] as num).toInt(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      type: json['type'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$UniversityListItemToJson(_UniversityListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'city': instance.city,
      'isActive': instance.isActive,
      'rankingNational': instance.rankingNational,
      'studentCount': instance.studentCount,
      'programsCount': instance.programsCount,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'type': instance.type,
      'description': instance.description,
    };

_UniversityRequest _$UniversityRequestFromJson(Map<String, dynamic> json) =>
    _UniversityRequest(
      name: json['name'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      website: json['website'] as String?,
      logoUrl: json['logoUrl'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      rankingNational: (json['rankingNational'] as num?)?.toInt(),
      rankingInternational: (json['rankingInternational'] as num?)?.toInt(),
      establishedYear: (json['establishedYear'] as num?)?.toInt(),
      studentCount: (json['studentCount'] as num?)?.toInt(),
      contactEmail: json['contactEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
      programs: (json['programs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      faculties: (json['faculties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UniversityRequestToJson(_UniversityRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'city': instance.city,
      'website': instance.website,
      'logoUrl': instance.logoUrl,
      'description': instance.description,
      'isActive': instance.isActive,
      'rankingNational': instance.rankingNational,
      'rankingInternational': instance.rankingInternational,
      'establishedYear': instance.establishedYear,
      'studentCount': instance.studentCount,
      'contactEmail': instance.contactEmail,
      'contactPhone': instance.contactPhone,
      'programs': instance.programs,
      'faculties': instance.faculties,
    };

_UniversityImportRequest _$UniversityImportRequestFromJson(
  Map<String, dynamic> json,
) => _UniversityImportRequest(
  source: json['source'] as String,
  mappings: json['mappings'] as Map<String, dynamic>,
  validateOnly: json['validateOnly'] as bool?,
  updateExisting: json['updateExisting'] as bool?,
);

Map<String, dynamic> _$UniversityImportRequestToJson(
  _UniversityImportRequest instance,
) => <String, dynamic>{
  'source': instance.source,
  'mappings': instance.mappings,
  'validateOnly': instance.validateOnly,
  'updateExisting': instance.updateExisting,
};

_UniversityImportResult _$UniversityImportResultFromJson(
  Map<String, dynamic> json,
) => _UniversityImportResult(
  totalProcessed: (json['totalProcessed'] as num).toInt(),
  successfulImports: (json['successfulImports'] as num).toInt(),
  failedImports: (json['failedImports'] as num).toInt(),
  updatedRecords: (json['updatedRecords'] as num).toInt(),
  errors: (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
  warnings: (json['warnings'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$UniversityImportResultToJson(
  _UniversityImportResult instance,
) => <String, dynamic>{
  'totalProcessed': instance.totalProcessed,
  'successfulImports': instance.successfulImports,
  'failedImports': instance.failedImports,
  'updatedRecords': instance.updatedRecords,
  'errors': instance.errors,
  'warnings': instance.warnings,
};

_Country _$CountryFromJson(Map<String, dynamic> json) => _Country(
  code: json['code'] as String,
  name: json['name'] as String,
  region: json['region'] as String,
);

Map<String, dynamic> _$CountryToJson(_Country instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'region': instance.region,
};

_City _$CityFromJson(Map<String, dynamic> json) => _City(
  name: json['name'] as String,
  country: json['country'] as String,
  region: json['region'] as String,
  population: (json['population'] as num?)?.toInt(),
);

Map<String, dynamic> _$CityToJson(_City instance) => <String, dynamic>{
  'name': instance.name,
  'country': instance.country,
  'region': instance.region,
  'population': instance.population,
};

_UniversityStats _$UniversityStatsFromJson(Map<String, dynamic> json) =>
    _UniversityStats(
      totalUniversities: (json['totalUniversities'] as num).toInt(),
      activeUniversities: (json['activeUniversities'] as num).toInt(),
      inactiveUniversities: (json['inactiveUniversities'] as num).toInt(),
      pendingUniversities: (json['pendingUniversities'] as num).toInt(),
      byCountry: Map<String, int>.from(json['byCountry'] as Map),
      byRegion: Map<String, int>.from(json['byRegion'] as Map),
    );

Map<String, dynamic> _$UniversityStatsToJson(_UniversityStats instance) =>
    <String, dynamic>{
      'totalUniversities': instance.totalUniversities,
      'activeUniversities': instance.activeUniversities,
      'inactiveUniversities': instance.inactiveUniversities,
      'pendingUniversities': instance.pendingUniversities,
      'byCountry': instance.byCountry,
      'byRegion': instance.byRegion,
    };
