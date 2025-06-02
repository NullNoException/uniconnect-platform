import '../../domain/models/dashboard_filter.dart';

abstract class DashboardRemoteDataSource {
  /// Get dashboard statistics and overview data
  Future<Map<String, dynamic>> getDashboardData({DashboardFilter? filter});

  /// Get chart data for service requests over time
  Future<Map<String, dynamic>> getServiceRequestChart({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get service category distribution data
  Future<List<Map<String, dynamic>>> getServiceCategoryData({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get recent service requests
  Future<List<Map<String, dynamic>>> getRecentServiceRequests({
    int limit = 10,
    int offset = 0,
  });

  /// Get real-time dashboard stats
  Future<Map<String, dynamic>> getDashboardStats();

  /// Export dashboard data
  Future<String> exportDashboardData({
    required DashboardFilter filter,
    required String format,
  });
}
