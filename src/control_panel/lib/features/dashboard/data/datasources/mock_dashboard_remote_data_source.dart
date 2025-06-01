import '../mock/mock_dashboard_data.dart';
import '../datasources/dashboard_remote_data_source.dart';
import '../../domain/models/dashboard_filter.dart';

class MockDashboardRemoteDataSource implements DashboardRemoteDataSource {
  @override
  Future<Map<String, dynamic>> getDashboardData({
    DashboardFilter? filter,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return MockDashboardData.sampleData.toJson();
  }

  @override
  Future<Map<String, dynamic>> getServiceRequestChart({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return MockDashboardData.sampleRequestChart.toJson();
  }

  @override
  Future<List<Map<String, dynamic>>> getServiceCategoryData({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    return MockDashboardData.sampleCategoryData
        .map((data) => data.toJson())
        .toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getRecentServiceRequests({
    int limit = 10,
    int offset = 0,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final requests = MockDashboardData.sampleRecentRequests;
    final endIndex = (offset + limit).clamp(0, requests.length);
    final paginatedRequests = requests.sublist(
      offset.clamp(0, requests.length),
      endIndex,
    );

    return paginatedRequests.map((request) => request.toJson()).toList();
  }

  @override
  Future<Map<String, dynamic>> getDashboardStats() async {
    await Future.delayed(const Duration(milliseconds: 200));

    return MockDashboardData.sampleStats.toJson();
  }

  @override
  Future<String> exportDashboardData({
    required DashboardFilter filter,
    required String format,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    // Return a mock download URL
    return 'https://example.com/downloads/dashboard_${DateTime.now().millisecondsSinceEpoch}.$format';
  }
}
