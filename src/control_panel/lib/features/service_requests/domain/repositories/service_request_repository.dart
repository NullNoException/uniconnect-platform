import '../models/service_request.dart';

abstract class ServiceRequestRepository {
  /// Get service requests with filtering and pagination
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
  });

  /// Get a specific service request by ID
  Future<ServiceRequest> getServiceRequestById(String id);

  /// Update service request status and details
  Future<ServiceRequest> updateServiceRequest(
    String id,
    ServiceRequestUpdateRequest request,
  );

  /// Get service requests requiring admin action
  Future<List<ServiceRequestListItem>> getServiceRequestsForReview({
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
  });

  /// Get service requests requiring document verification
  Future<List<ServiceRequestListItem>> getServiceRequestsForDocumentReview({
    required int page,
    required int pageSize,
  });

  /// Verify or reject a document
  Future<RequestDocument> verifyDocument(DocumentVerificationRequest request);

  /// Update milestone status
  Future<RequestMilestone> updateMilestone(MilestoneUpdateRequest request);

  /// Get service request statistics for dashboard
  Future<Map<String, dynamic>> getServiceRequestStats({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get service request metrics for performance tracking
  Future<Map<String, dynamic>> getServiceRequestMetrics({
    required String timeRange,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Export service requests data
  Future<String> exportServiceRequests({
    required String format,
    String? searchQuery,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get service request timeline/history
  Future<List<Map<String, dynamic>>> getServiceRequestTimeline(String id);

  /// Send notification to stakeholders
  Future<void> sendServiceRequestNotification({
    required String requestId,
    required String recipientId,
    required String message,
    required String type,
  });

  /// Get pending document verification count
  Future<int> getPendingDocumentVerificationCount();

  /// Get overdue service requests count
  Future<int> getOverdueServiceRequestsCount();

  /// Get service requests by provider for performance monitoring
  Future<List<ServiceRequestListItem>> getServiceRequestsByProvider({
    required String providerId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get service requests by student for support purposes
  Future<List<ServiceRequestListItem>> getServiceRequestsByStudent({
    required String studentId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Assign admin to service request for escalated cases
  Future<ServiceRequest> assignAdminToServiceRequest({
    required String requestId,
    required String adminId,
    String? notes,
  });

  /// Get service requests assigned to specific admin
  Future<List<ServiceRequestListItem>> getServiceRequestsAssignedToAdmin({
    required String adminId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
  });

  /// Escalate service request to admin
  Future<ServiceRequest> escalateServiceRequest({
    required String requestId,
    required String reason,
    required String escalatedBy,
  });

  /// Get disputed service requests
  Future<List<ServiceRequestListItem>> getDisputedServiceRequests({
    required int page,
    required int pageSize,
  });

  /// Resolve dispute
  Future<ServiceRequest> resolveDispute({
    required String requestId,
    required String resolution,
    required String resolvedBy,
    required String resolutionType,
  });
}
