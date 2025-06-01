import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/dashboard_stats.dart';
import '../models/dashboard_filter.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isExporting,
    DashboardData? data,
    DashboardStats? stats,
    ServiceRequestChart? chartData,
    List<ServiceCategoryData>? categoryData,
    List<RecentServiceRequest>? recentRequests,
    @Default(DashboardFilter()) DashboardFilter filter,
    String? error,
    String? exportUrl,
  }) = _DashboardState;

  const DashboardState._();

  bool get hasData => data != null;
  bool get hasError => error != null;
  bool get hasStats => stats != null;
  bool get hasChartData => chartData != null;
  bool get hasCategoryData => categoryData != null && categoryData!.isNotEmpty;
  bool get hasRecentRequests =>
      recentRequests != null && recentRequests!.isNotEmpty;
}
