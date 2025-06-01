import 'package:dio/dio.dart';
import 'dashboard_remote_data_source.dart';
import '../../domain/models/dashboard_filter.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient _apiClient;

  DashboardRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Map<String, dynamic>> getDashboardData({
    DashboardFilter? filter,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (filter != null) {
        queryParams['timeRange'] = filter.timeRange.name;
        if (filter.startDate != null) {
          queryParams['startDate'] = filter.startDate!.toIso8601String();
        }
        if (filter.endDate != null) {
          queryParams['endDate'] = filter.endDate!.toIso8601String();
        }
        if (filter.serviceCategories != null &&
            filter.serviceCategories!.isNotEmpty) {
          queryParams['categories'] = filter.serviceCategories!.join(',');
        }
        if (filter.providerIds != null && filter.providerIds!.isNotEmpty) {
          queryParams['providers'] = filter.providerIds!.join(',');
        }
        if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
          queryParams['search'] = filter.searchQuery!;
        }
      }

      final response = await _apiClient.get(
        ApiEndpoints.dashboardData,
        queryParameters: queryParams,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('Failed to get dashboard data: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> getServiceRequestChart({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{'timeRange': timeRange.name};

      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }

      final response = await _apiClient.get(
        ApiEndpoints.dashboardChartData,
        queryParameters: queryParams,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('Failed to get chart data: ${e.message}');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getServiceCategoryData({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{'timeRange': timeRange.name};

      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }

      final response = await _apiClient.get(
        ApiEndpoints.dashboardCategoryData,
        queryParameters: queryParams,
      );

      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to get category data: ${e.message}');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getRecentServiceRequests({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.dashboardRecentRequests,
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to get recent requests: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.dashboardStats);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('Failed to get dashboard stats: ${e.message}');
    }
  }

  @override
  Future<String> exportDashboardData({
    required DashboardFilter filter,
    required String format,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'format': format,
        'timeRange': filter.timeRange.name,
      };

      if (filter.startDate != null) {
        queryParams['startDate'] = filter.startDate!.toIso8601String();
      }
      if (filter.endDate != null) {
        queryParams['endDate'] = filter.endDate!.toIso8601String();
      }
      if (filter.serviceCategories != null &&
          filter.serviceCategories!.isNotEmpty) {
        queryParams['categories'] = filter.serviceCategories!.join(',');
      }
      if (filter.providerIds != null && filter.providerIds!.isNotEmpty) {
        queryParams['providers'] = filter.providerIds!.join(',');
      }

      final response = await _apiClient.get(
        ApiEndpoints.dashboardExport,
        queryParameters: queryParams,
        options: Options(responseType: ResponseType.plain),
      );

      return response.data as String;
    } on DioException catch (e) {
      throw Exception('Failed to export dashboard data: ${e.message}');
    }
  }
}
