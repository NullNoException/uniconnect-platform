import '../models/dashboard_stats.dart';
import '../models/dashboard_filter.dart';

abstract class DashboardRepository {
  /// Get dashboard statistics and overview data
  Future<DashboardData> getDashboardData({DashboardFilter? filter});

  /// Get chart data for service requests over time
  Future<ServiceRequestChart> getServiceRequestChart({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get service category distribution data
  Future<List<ServiceCategoryData>> getServiceCategoryData({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get recent service requests
  Future<List<RecentServiceRequest>> getRecentServiceRequests({
    int limit = 10,
    int offset = 0,
  });

  /// Get real-time dashboard stats
  Future<DashboardStats> getDashboardStats();

  /// Export dashboard data as CSV/Excel
  Future<String> exportDashboardData({
    required DashboardFilter filter,
    required String format, // 'csv' or 'excel'
  });
}
