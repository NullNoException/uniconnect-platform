import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../domain/datasources/service_request_data_source.dart';
import '../../domain/models/service_request.dart';

class ServiceRequestApiDataSource implements ServiceRequestDataSource {
  final ApiClient _apiClient;

  ServiceRequestApiDataSource(this._apiClient);

  @override
  Future<List<ServiceRequestListItem>> getServiceRequests({
    required int page,
    required int pageSize,
    String? searchQuery,
    ServiceRequestStatus? status,
    String? studentId,
    String? providerId,
    String? serviceId,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    bool? sortDescending,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        if (searchQuery != null) 'search': searchQuery,
        if (status != null) 'status': status.toString().split('.').last,
        if (studentId != null) 'studentId': studentId,
        if (providerId != null) 'providerId': providerId,
        if (serviceId != null) 'serviceId': serviceId,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        if (sortBy != null) 'sortBy': sortBy,
        if (sortDescending != null) 'sortDesc': sortDescending.toString(),
      };

      final response = await _apiClient.get(
        '/service-requests',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final List<dynamic> requestsJson = apiResponse.data;
        return requestsJson
            .map((json) => ServiceRequestListItem.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message: apiResponse.message ?? 'Failed to fetch service requests',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(message: 'Failed to fetch service requests: $e');
    }
  }

  @override
  Future<ServiceRequest> getServiceRequestById(String id) async {
    try {
      final response = await _apiClient.get('/service-requests/$id');

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceRequest.fromJson(apiResponse.data);
      } else {
        throw ServerException(
          message: apiResponse.message ?? 'Failed to fetch service request',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(message: 'Failed to fetch service request: $e');
    }
  }

  @override
  Future<ServiceRequest> updateServiceRequest(
    String id,
    ServiceRequestUpdateRequest request,
  ) async {
    try {
      final response = await _apiClient.patch(
        '/service-requests/$id',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceRequest.fromJson(apiResponse.data);
      } else {
        throw ServerException(
          message: apiResponse.message ?? 'Failed to update service request',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(message: 'Failed to update service request: $e');
    }
  }

  @override
  Future<List<ServiceRequestListItem>> getServiceRequestsForReview({
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'requiresReview': 'true',
        if (status != null) 'status': status.toString().split('.').last,
      };

      final response = await _apiClient.get(
        '/service-requests',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final List<dynamic> requestsJson = apiResponse.data;
        return requestsJson
            .map((json) => ServiceRequestListItem.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to fetch service requests for review',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch service requests for review: $e',
      );
    }
  }

  @override
  Future<List<ServiceRequestListItem>> getServiceRequestsForDocumentReview({
    required int page,
    required int pageSize,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'requiresDocumentReview': 'true',
      };

      final response = await _apiClient.get(
        '/service-requests',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final List<dynamic> requestsJson = apiResponse.data;
        return requestsJson
            .map((json) => ServiceRequestListItem.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to fetch service requests for document review',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch service requests for document review: $e',
      );
    }
  }

  @override
  Future<RequestDocument> verifyDocument(
    DocumentVerificationRequest request,
  ) async {
    try {
      final response = await _apiClient.patch(
        '/service-requests/documents/${request.documentId}/verify',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return RequestDocument.fromJson(apiResponse.data);
      } else {
        throw ServerException(
          message: apiResponse.message ?? 'Failed to verify document',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(message: 'Failed to verify document: $e');
    }
  }

  @override
  Future<RequestMilestone> updateMilestone(
    MilestoneUpdateRequest request,
  ) async {
    try {
      final String endpoint =
          '/service-requests/${request.requestId}/milestones/${request.id}';

      final response = await _apiClient.patch(endpoint, data: request.toJson());

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return RequestMilestone.fromJson(apiResponse.data);
      } else {
        throw ServerException(
          message: apiResponse.message ?? 'Failed to update milestone',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(message: 'Failed to update milestone: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getServiceRequestStats({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final response = await _apiClient.get(
        '/service-requests/stats',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Map<String, dynamic>.from(apiResponse.data as Map);
      } else {
        throw ServerException(
          message:
              apiResponse.message ?? 'Failed to fetch service request stats',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch service request stats: $e',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getServiceRequestMetrics({
    required String timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        'timeRange': timeRange,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final response = await _apiClient.get(
        '/service-requests/metrics',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return Map<String, dynamic>.from(apiResponse.data as Map);
      } else {
        throw ServerException(
          message:
              apiResponse.message ?? 'Failed to fetch service request metrics',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch service request metrics: $e',
      );
    }
  }

  @override
  Future<String> exportServiceRequests({
    required String format,
    String? searchQuery,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        'format': format,
        if (searchQuery != null) 'search': searchQuery,
        if (status != null) 'status': status.toString().split('.').last,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final response = await _apiClient.get(
        '/service-requests/export',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final data = apiResponse.data as Map<String, dynamic>;
        return data['downloadUrl'] as String;
      } else {
        throw ServerException(
          message: apiResponse.message ?? 'Failed to export service requests',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(message: 'Failed to export service requests: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getServiceRequestTimeline(
    String id,
  ) async {
    try {
      final response = await _apiClient.get('/service-requests/$id/timeline');

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return List<Map<String, dynamic>>.from(apiResponse.data);
      } else {
        throw ServerException(
          message:
              apiResponse.message ?? 'Failed to fetch service request timeline',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch service request timeline: $e',
      );
    }
  }

  @override
  Future<void> sendServiceRequestNotification({
    required String requestId,
    required String recipientId,
    required String message,
    required String type,
  }) async {
    try {
      final response = await _apiClient.post(
        '/service-requests/$requestId/notifications',
        data: {'recipientId': recipientId, 'message': message, 'type': type},
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (!apiResponse.success) {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to send service request notification',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to send service request notification: $e',
      );
    }
  }

  @override
  Future<int> getPendingDocumentVerificationCount() async {
    try {
      final response = await _apiClient.get(
        '/service-requests/pending-document-count',
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final data = apiResponse.data as Map<String, dynamic>;
        return data['count'] as int;
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to fetch pending document verification count',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch pending document verification count: $e',
      );
    }
  }

  @override
  Future<int> getOverdueServiceRequestsCount() async {
    try {
      final response = await _apiClient.get('/service-requests/overdue-count');

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final data = apiResponse.data as Map<String, dynamic>;
        return data['count'] as int;
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to fetch overdue service requests count',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch overdue service requests count: $e',
      );
    }
  }

  @override
  Future<List<ServiceRequestListItem>> getServiceRequestsByProvider({
    required String providerId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'providerId': providerId,
        if (status != null) 'status': status.toString().split('.').last,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final response = await _apiClient.get(
        '/service-requests',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final List<dynamic> requestsJson = apiResponse.data;
        return requestsJson
            .map((json) => ServiceRequestListItem.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to fetch service requests by provider',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch service requests by provider: $e',
      );
    }
  }

  @override
  Future<List<ServiceRequestListItem>> getServiceRequestsByStudent({
    required String studentId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'studentId': studentId,
        if (status != null) 'status': status.toString().split('.').last,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final response = await _apiClient.get(
        '/service-requests',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final List<dynamic> requestsJson = apiResponse.data;
        return requestsJson
            .map((json) => ServiceRequestListItem.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to fetch service requests by student',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch service requests by student: $e',
      );
    }
  }

  @override
  Future<ServiceRequest> assignAdminToServiceRequest({
    required String requestId,
    required String adminId,
    String? notes,
  }) async {
    try {
      final response = await _apiClient.patch(
        '/service-requests/$requestId/assign',
        data: {'adminId': adminId, if (notes != null) 'notes': notes},
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceRequest.fromJson(apiResponse.data);
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to assign admin to service request',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to assign admin to service request: $e',
      );
    }
  }

  @override
  Future<List<ServiceRequestListItem>> getServiceRequestsAssignedToAdmin({
    required String adminId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'assignedAdminId': adminId,
        if (status != null) 'status': status.toString().split('.').last,
      };

      final response = await _apiClient.get(
        '/service-requests',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final List<dynamic> requestsJson = apiResponse.data;
        return requestsJson
            .map((json) => ServiceRequestListItem.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to fetch service requests assigned to admin',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch service requests assigned to admin: $e',
      );
    }
  }

  @override
  Future<ServiceRequest> escalateServiceRequest({
    required String requestId,
    required String reason,
    required String escalatedBy,
  }) async {
    try {
      final response = await _apiClient.post(
        '/service-requests/$requestId/escalate',
        data: {'reason': reason, 'escalatedBy': escalatedBy},
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceRequest.fromJson(apiResponse.data);
      } else {
        throw ServerException(
          message: apiResponse.message ?? 'Failed to escalate service request',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(message: 'Failed to escalate service request: $e');
    }
  }

  @override
  Future<List<ServiceRequestListItem>> getDisputedServiceRequests({
    required int page,
    required int pageSize,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'status': 'disputed',
      };

      final response = await _apiClient.get(
        '/service-requests',
        queryParameters: queryParams,
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        final List<dynamic> requestsJson = apiResponse.data;
        return requestsJson
            .map((json) => ServiceRequestListItem.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message:
              apiResponse.message ??
              'Failed to fetch disputed service requests',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(
        message: 'Failed to fetch disputed service requests: $e',
      );
    }
  }

  @override
  Future<ServiceRequest> resolveDispute({
    required String requestId,
    required String resolution,
    required String resolvedBy,
    required String resolutionType,
  }) async {
    try {
      final response = await _apiClient.post(
        '/service-requests/$requestId/resolve-dispute',
        data: {
          'resolution': resolution,
          'resolvedBy': resolvedBy,
          'resolutionType': resolutionType,
        },
      );

      final apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        return ServiceRequest.fromJson(apiResponse.data);
      } else {
        throw ServerException(
          message: apiResponse.message ?? 'Failed to resolve dispute',
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerException(
          message: 'Network error: ${e.message}',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException(message: 'Failed to resolve dispute: $e');
    }
  }
}
