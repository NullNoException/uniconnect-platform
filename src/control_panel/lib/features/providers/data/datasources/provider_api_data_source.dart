import 'package:dio/dio.dart';
import '../../domain/datasources/provider_data_source.dart';
import '../../domain/models/provider.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_response.dart';

class ProviderApiDataSource implements ProviderDataSource {
  final ApiClient _apiClient;

  ProviderApiDataSource(this._apiClient);

  @override
  Future<List<ProviderListItem>> getProviders({
    required int page,
    required int pageSize,
    String? searchQuery,
    ProviderVerificationStatus? status,
    String? sortBy,
    bool? sortDescending,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': pageSize,
        if (status != null) 'status': status.name,
        if (searchQuery != null && searchQuery.isNotEmpty)
          'search': searchQuery,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortDescending != null) 'sort_desc': sortDescending,
      };

      final response = await _apiClient.get(
        ApiEndpoints.providers,
        queryParameters: queryParams,
      );

      // Handle direct array response or wrapped response
      if (response.data is List) {
        final List<dynamic> providersData = response.data;
        return providersData
            .map((json) => ProviderListItem.fromJson(json))
            .toList();
      } else if (response.data is Map<String, dynamic>) {
        final apiResponse = ApiResponse.fromJson(response.data);
        if (apiResponse.success) {
          final List<dynamic> providersData = apiResponse.data is List
              ? apiResponse.data
              : apiResponse.data['providers'] ?? [];
          return providersData
              .map((json) => ProviderListItem.fromJson(json))
              .toList();
        } else {
          throw Exception(apiResponse.message ?? 'Failed to fetch providers');
        }
      } else {
        throw Exception('Unexpected response format');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch providers: $e');
    }
  }

  @override
  Future<Provider> getProviderById(String providerId) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.providers}/$providerId',
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Provider.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to fetch provider');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch provider: $e');
    }
  }

  @override
  Future<Provider> createProvider(ProviderRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.providers,
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Provider.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to create provider');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create provider: $e');
    }
  }

  @override
  Future<Provider> updateProvider(
    String providerId,
    ProviderRequest request,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.providers}/$providerId',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Provider.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to update provider');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update provider: $e');
    }
  }

  @override
  Future<void> deleteProvider(String providerId) async {
    try {
      final response = await _apiClient.delete(
        '${ApiEndpoints.providers}/$providerId',
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Failed to delete provider');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete provider: $e');
    }
  }

  @override
  Future<Provider> verifyProvider(VerifyProviderRequest request) async {
    try {
      final response = await _apiClient.post(
        '${ApiEndpoints.providers}/${request.providerId}/verify',
        data: {
          'is_approved': request.isApproved,
          'comments': request.comments,
          'verified_by_admin_id': request.verifiedByAdminId,
        },
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Provider.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to verify provider');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to verify provider: $e');
    }
  }

  @override
  Future<ProviderPerformanceMetrics> getProviderPerformance(
    String providerId,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.providers}/$providerId/performance',
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ProviderPerformanceMetrics.fromJson(apiResponse.data);
      } else {
        throw Exception(
          apiResponse.message ?? 'Failed to fetch performance metrics',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch performance metrics: $e');
    }
  }

  @override
  Future<Provider> updateProviderStatus(
    String providerId,
    bool isActive,
  ) async {
    try {
      final response = await _apiClient.patch(
        '${ApiEndpoints.providers}/$providerId/status',
        data: {'is_active': isActive},
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Provider.fromJson(apiResponse.data);
      } else {
        throw Exception(
          apiResponse.message ?? 'Failed to update provider status',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update provider status: $e');
    }
  }

  @override
  Future<List<ProviderListItem>> getProvidersForVerification({
    required int page,
    required int pageSize,
  }) async {
    return getProviders(
      page: page,
      pageSize: pageSize,
      status: ProviderVerificationStatus.pending,
    );
  }

  @override
  Future<int> getVerificationQueueCount() async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.providers}/verification-queue-count',
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return apiResponse.data['count'] ?? 0;
      } else {
        throw Exception(apiResponse.message ?? 'Failed to fetch queue count');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch queue count: $e');
    }
  }
}
