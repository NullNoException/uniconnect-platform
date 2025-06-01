import '../datasources/dashboard_remote_data_source.dart';
import '../../domain/models/dashboard_stats.dart';
import '../../domain/models/dashboard_filter.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<DashboardData> getDashboardData({DashboardFilter? filter}) async {
    try {
      final data = await _remoteDataSource.getDashboardData(filter: filter);
      return DashboardData.fromJson(data);
    } catch (e) {
      throw Exception('Failed to get dashboard data: $e');
    }
  }

  @override
  Future<ServiceRequestChart> getServiceRequestChart({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final data = await _remoteDataSource.getServiceRequestChart(
        timeRange: timeRange,
        startDate: startDate,
        endDate: endDate,
      );
      return ServiceRequestChart.fromJson(data);
    } catch (e) {
      throw Exception('Failed to get chart data: $e');
    }
  }

  @override
  Future<List<ServiceCategoryData>> getServiceCategoryData({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final data = await _remoteDataSource.getServiceCategoryData(
        timeRange: timeRange,
        startDate: startDate,
        endDate: endDate,
      );
      return data.map((json) => ServiceCategoryData.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get category data: $e');
    }
  }

  @override
  Future<List<RecentServiceRequest>> getRecentServiceRequests({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final data = await _remoteDataSource.getRecentServiceRequests(
        limit: limit,
        offset: offset,
      );
      return data.map((json) => RecentServiceRequest.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get recent requests: $e');
    }
  }

  @override
  Future<DashboardStats> getDashboardStats() async {
    try {
      final data = await _remoteDataSource.getDashboardStats();
      return DashboardStats.fromJson(data);
    } catch (e) {
      throw Exception('Failed to get dashboard stats: $e');
    }
  }

  @override
  Future<String> exportDashboardData({
    required DashboardFilter filter,
    required String format,
  }) async {
    try {
      return await _remoteDataSource.exportDashboardData(
        filter: filter,
        format: format,
      );
    } catch (e) {
      throw Exception('Failed to export dashboard data: $e');
    }
  }
}
