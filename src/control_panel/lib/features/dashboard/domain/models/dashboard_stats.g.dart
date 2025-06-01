// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardStats _$DashboardStatsFromJson(Map<String, dynamic> json) =>
    _DashboardStats(
      totalUsers: (json['totalUsers'] as num).toInt(),
      activeProviders: (json['activeProviders'] as num).toInt(),
      pendingRequests: (json['pendingRequests'] as num).toInt(),
      revenue: (json['revenue'] as num).toDouble(),
      trends: DashboardTrends.fromJson(json['trends'] as Map<String, dynamic>),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$DashboardStatsToJson(_DashboardStats instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'activeProviders': instance.activeProviders,
      'pendingRequests': instance.pendingRequests,
      'revenue': instance.revenue,
      'trends': instance.trends,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

_DashboardTrends _$DashboardTrendsFromJson(Map<String, dynamic> json) =>
    _DashboardTrends(
      usersTrend: (json['usersTrend'] as num).toDouble(),
      providersTrend: (json['providersTrend'] as num).toDouble(),
      requestsTrend: (json['requestsTrend'] as num).toDouble(),
      revenueTrend: (json['revenueTrend'] as num).toDouble(),
    );

Map<String, dynamic> _$DashboardTrendsToJson(_DashboardTrends instance) =>
    <String, dynamic>{
      'usersTrend': instance.usersTrend,
      'providersTrend': instance.providersTrend,
      'requestsTrend': instance.requestsTrend,
      'revenueTrend': instance.revenueTrend,
    };

_ChartData _$ChartDataFromJson(Map<String, dynamic> json) => _ChartData(
  label: json['label'] as String,
  value: (json['value'] as num).toDouble(),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$ChartDataToJson(_ChartData instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'date': instance.date?.toIso8601String(),
    };

_ServiceRequestChart _$ServiceRequestChartFromJson(Map<String, dynamic> json) =>
    _ServiceRequestChart(
      completed: (json['completed'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pending: (json['pending'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      cancelled: (json['cancelled'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceRequestChartToJson(
  _ServiceRequestChart instance,
) => <String, dynamic>{
  'completed': instance.completed,
  'pending': instance.pending,
  'cancelled': instance.cancelled,
};

_ServiceCategoryData _$ServiceCategoryDataFromJson(Map<String, dynamic> json) =>
    _ServiceCategoryData(
      category: json['category'] as String,
      percentage: (json['percentage'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$ServiceCategoryDataToJson(
  _ServiceCategoryData instance,
) => <String, dynamic>{
  'category': instance.category,
  'percentage': instance.percentage,
  'count': instance.count,
  'color': instance.color,
};

_RecentServiceRequest _$RecentServiceRequestFromJson(
  Map<String, dynamic> json,
) => _RecentServiceRequest(
  id: json['id'] as String,
  studentName: json['studentName'] as String,
  serviceName: json['serviceName'] as String,
  providerName: json['providerName'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$RecentServiceRequestToJson(
  _RecentServiceRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'studentName': instance.studentName,
  'serviceName': instance.serviceName,
  'providerName': instance.providerName,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
  'amount': instance.amount,
};

_DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    _DashboardData(
      stats: DashboardStats.fromJson(json['stats'] as Map<String, dynamic>),
      requestChart: ServiceRequestChart.fromJson(
        json['requestChart'] as Map<String, dynamic>,
      ),
      categoryData: (json['categoryData'] as List<dynamic>)
          .map((e) => ServiceCategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentRequests: (json['recentRequests'] as List<dynamic>)
          .map((e) => RecentServiceRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataToJson(_DashboardData instance) =>
    <String, dynamic>{
      'stats': instance.stats,
      'requestChart': instance.requestChart,
      'categoryData': instance.categoryData,
      'recentRequests': instance.recentRequests,
    };
