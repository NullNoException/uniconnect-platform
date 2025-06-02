import 'package:dio/dio.dart';
import '../../domain/datasources/service_data_source.dart';
import '../../domain/models/service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_response.dart';

class ServiceApiDataSource implements ServiceDataSource {
  final ApiClient _apiClient;

  ServiceApiDataSource(this._apiClient);

  @override
  Future<List<ServiceListItem>> getServices({
    required int page,
    required int pageSize,
    String? searchQuery,
    ServiceApprovalStatus? status,
    String? categoryId,
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
        if (categoryId != null) 'category_id': categoryId,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortDescending != null) 'sort_desc': sortDescending,
      };

      final response = await _apiClient.get(
        ApiEndpoints.services,
        queryParameters: queryParams,
      );

      if (response.data is List) {
        final List<dynamic> servicesData = response.data;
        return servicesData
            .map((json) => ServiceListItem.fromJson(json))
            .toList();
      } else if (response.data is Map<String, dynamic>) {
        final apiResponse = ApiResponse.fromJson(response.data);
        if (apiResponse.success) {
          final List<dynamic> servicesData = apiResponse.data is List
              ? apiResponse.data
              : apiResponse.data['services'] ?? [];
          return servicesData
              .map((json) => ServiceListItem.fromJson(json))
              .toList();
        } else {
          throw Exception(apiResponse.message ?? 'Failed to fetch services');
        }
      } else {
        throw Exception('Unexpected response format');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }

  @override
  Future<Service> getServiceById(String id) async {
    try {
      final response = await _apiClient.get('${ApiEndpoints.services}/$id');

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Service.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to fetch service');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch service: $e');
    }
  }

  @override
  Future<Service> createService(ServiceRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.services,
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Service.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to create service');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create service: $e');
    }
  }

  @override
  Future<Service> updateService(String id, ServiceRequest request) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.services}/$id',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Service.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to update service');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update service: $e');
    }
  }

  @override
  Future<void> deleteService(String id) async {
    try {
      final response = await _apiClient.delete('${ApiEndpoints.services}/$id');

      final apiResponse = ApiResponse.fromJson(response.data);
      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Failed to delete service');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete service: $e');
    }
  }

  @override
  Future<Service> approveService(ApproveServiceRequest request) async {
    try {
      final response = await _apiClient.post(
        '${ApiEndpoints.services}/${request.serviceId}/approve',
        data: {
          'is_approved': request.isApproved,
          'rejection_reason': request.rejectionReason,
          'notes': request.notes,
          'approved_by_admin_id': request.approvedByAdminId,
          'is_featured': request.isFeatured,
        },
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Service.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to approve service');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to approve service: $e');
    }
  }

  @override
  Future<List<ServiceListItem>> getServicesForApproval({
    required int page,
    required int pageSize,
  }) async {
    return getServices(
      page: page,
      pageSize: pageSize,
      status: ServiceApprovalStatus.pending,
    );
  }

  @override
  Future<int> getApprovalQueueCount() async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.services}/approval-queue-count',
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

  @override
  Future<Service> updateServiceStatus(String id, bool isActive) async {
    try {
      final response = await _apiClient.patch(
        '${ApiEndpoints.services}/$id/status',
        data: {'is_active': isActive},
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Service.fromJson(apiResponse.data);
      } else {
        throw Exception(
          apiResponse.message ?? 'Failed to update service status',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update service status: $e');
    }
  }

  @override
  Future<Service> updateServiceFeatured(String id, bool isFeatured) async {
    try {
      final response = await _apiClient.patch(
        '${ApiEndpoints.services}/$id/featured',
        data: {'is_featured': isFeatured},
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Service.fromJson(apiResponse.data);
      } else {
        throw Exception(
          apiResponse.message ?? 'Failed to update service featured status',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update service featured status: $e');
    }
  }

  // Category Management Methods
  @override
  Future<List<ServiceCategory>> getCategories({bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{
        if (isActive != null) 'is_active': isActive,
      };

      final response = await _apiClient.get(
        ApiEndpoints.serviceCategories,
        queryParameters: queryParams,
      );

      if (response.data is List) {
        final List<dynamic> categoriesData = response.data;
        return categoriesData
            .map((json) => ServiceCategory.fromJson(json))
            .toList();
      } else if (response.data is Map<String, dynamic>) {
        final apiResponse = ApiResponse.fromJson(response.data);
        if (apiResponse.success) {
          final List<dynamic> categoriesData = apiResponse.data is List
              ? apiResponse.data
              : apiResponse.data['categories'] ?? [];
          return categoriesData
              .map((json) => ServiceCategory.fromJson(json))
              .toList();
        } else {
          throw Exception(apiResponse.message ?? 'Failed to fetch categories');
        }
      } else {
        throw Exception('Unexpected response format');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<ServiceCategory> getCategoryById(String id) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.serviceCategories}/$id',
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceCategory.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to fetch category');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch category: $e');
    }
  }

  @override
  Future<ServiceCategory> createCategory(ServiceCategoryRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.serviceCategories,
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceCategory.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to create category');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }

  @override
  Future<ServiceCategory> updateCategory(
    String id,
    ServiceCategoryRequest request,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.serviceCategories}/$id',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceCategory.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to update category');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      final response = await _apiClient.delete(
        '${ApiEndpoints.serviceCategories}/$id',
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Failed to delete category');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }

  @override
  Future<List<ServiceSubcategory>> getSubcategories(String categoryId) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.serviceCategories}/$categoryId/subcategories',
      );

      if (response.data is List) {
        final List<dynamic> subcategoriesData = response.data;
        return subcategoriesData
            .map((json) => ServiceSubcategory.fromJson(json))
            .toList();
      } else if (response.data is Map<String, dynamic>) {
        final apiResponse = ApiResponse.fromJson(response.data);
        if (apiResponse.success) {
          final List<dynamic> subcategoriesData = apiResponse.data is List
              ? apiResponse.data
              : apiResponse.data['subcategories'] ?? [];
          return subcategoriesData
              .map((json) => ServiceSubcategory.fromJson(json))
              .toList();
        } else {
          throw Exception(
            apiResponse.message ?? 'Failed to fetch subcategories',
          );
        }
      } else {
        throw Exception('Unexpected response format');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch subcategories: $e');
    }
  }

  @override
  Future<ServiceSubcategory> createSubcategory(
    ServiceSubcategoryRequest request,
  ) async {
    try {
      final response = await _apiClient.post(
        '${ApiEndpoints.serviceCategories}/${request.categoryId}/subcategories',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceSubcategory.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to create subcategory');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create subcategory: $e');
    }
  }

  @override
  Future<ServiceSubcategory> updateSubcategory(
    String id,
    ServiceSubcategoryRequest request,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.serviceCategories}/subcategories/$id',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceSubcategory.fromJson(apiResponse.data);
      } else {
        throw Exception(apiResponse.message ?? 'Failed to update subcategory');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update subcategory: $e');
    }
  }

  @override
  Future<void> deleteSubcategory(String id) async {
    try {
      final response = await _apiClient.delete(
        '${ApiEndpoints.serviceCategories}/subcategories/$id',
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (!apiResponse.success) {
        throw Exception(apiResponse.message ?? 'Failed to delete subcategory');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete subcategory: $e');
    }
  }
}
