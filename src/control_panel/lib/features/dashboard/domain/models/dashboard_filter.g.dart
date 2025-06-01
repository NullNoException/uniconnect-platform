// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardFilter _$DashboardFilterFromJson(Map<String, dynamic> json) =>
    _DashboardFilter(
      timeRange:
          $enumDecodeNullable(_$DashboardTimeRangeEnumMap, json['timeRange']) ??
          DashboardTimeRange.thisMonth,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      serviceCategories:
          (json['serviceCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      providerIds:
          (json['providerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      searchQuery: json['searchQuery'] as String? ?? '',
    );

Map<String, dynamic> _$DashboardFilterToJson(_DashboardFilter instance) =>
    <String, dynamic>{
      'timeRange': _$DashboardTimeRangeEnumMap[instance.timeRange]!,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'serviceCategories': instance.serviceCategories,
      'providerIds': instance.providerIds,
      'searchQuery': instance.searchQuery,
    };

const _$DashboardTimeRangeEnumMap = {
  DashboardTimeRange.today: 'today',
  DashboardTimeRange.thisWeek: 'thisWeek',
  DashboardTimeRange.thisMonth: 'thisMonth',
  DashboardTimeRange.thisYear: 'thisYear',
  DashboardTimeRange.custom: 'custom',
};
