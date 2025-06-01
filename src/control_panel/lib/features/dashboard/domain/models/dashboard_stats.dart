import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_stats.freezed.dart';
part 'dashboard_stats.g.dart';

@freezed
abstract class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    required int totalUsers,
    required int activeProviders,
    required int pendingRequests,
    required double revenue,
    required DashboardTrends trends,
    required DateTime lastUpdated,
  }) = _DashboardStats;

  factory DashboardStats.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsFromJson(json);
}

@freezed
abstract class DashboardTrends with _$DashboardTrends {
  const factory DashboardTrends({
    required double usersTrend,
    required double providersTrend,
    required double requestsTrend,
    required double revenueTrend,
  }) = _DashboardTrends;

  factory DashboardTrends.fromJson(Map<String, dynamic> json) =>
      _$DashboardTrendsFromJson(json);
}

@freezed
abstract class ChartData with _$ChartData {
  const factory ChartData({
    required String label,
    required double value,
    DateTime? date,
  }) = _ChartData;

  factory ChartData.fromJson(Map<String, dynamic> json) =>
      _$ChartDataFromJson(json);
}

@freezed
abstract class ServiceRequestChart with _$ServiceRequestChart {
  const factory ServiceRequestChart({
    required List<ChartData> completed,
    required List<ChartData> pending,
    required List<ChartData> cancelled,
  }) = _ServiceRequestChart;

  factory ServiceRequestChart.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestChartFromJson(json);
}

@freezed
abstract class ServiceCategoryData with _$ServiceCategoryData {
  const factory ServiceCategoryData({
    required String category,
    required double percentage,
    required int count,
    required String color,
  }) = _ServiceCategoryData;

  factory ServiceCategoryData.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryDataFromJson(json);
}

@freezed
abstract class RecentServiceRequest with _$RecentServiceRequest {
  const factory RecentServiceRequest({
    required String id,
    required String studentName,
    required String serviceName,
    required String providerName,
    required String status,
    required DateTime createdAt,
    required double amount,
  }) = _RecentServiceRequest;

  factory RecentServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$RecentServiceRequestFromJson(json);
}

@freezed
abstract class DashboardData with _$DashboardData {
  const factory DashboardData({
    required DashboardStats stats,
    required ServiceRequestChart requestChart,
    required List<ServiceCategoryData> categoryData,
    required List<RecentServiceRequest> recentRequests,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
}
