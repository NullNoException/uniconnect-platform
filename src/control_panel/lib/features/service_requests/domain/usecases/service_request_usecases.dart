import '../models/service_request.dart';
import '../repositories/service_request_repository.dart';

/// UC-3.3.1: Monitor and manage service requests
class GetServiceRequestsUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestsUseCase(this._repository);

  Future<List<ServiceRequestListItem>> call({
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
    return await _repository.getServiceRequests(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      status: status,
      studentId: studentId,
      providerId: providerId,
      serviceId: serviceId,
      startDate: startDate,
      endDate: endDate,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }
}

/// Get service request details
class GetServiceRequestByIdUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestByIdUseCase(this._repository);

  Future<ServiceRequest> call(String id) async {
    return await _repository.getServiceRequestById(id);
  }
}

/// Update service request status and details
class UpdateServiceRequestUseCase {
  final ServiceRequestRepository _repository;

  UpdateServiceRequestUseCase(this._repository);

  Future<ServiceRequest> call(
    String id,
    ServiceRequestUpdateRequest request,
  ) async {
    return await _repository.updateServiceRequest(id, request);
  }
}

/// Get service requests requiring admin review
class GetServiceRequestsForReviewUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestsForReviewUseCase(this._repository);

  Future<List<ServiceRequestListItem>> call({
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
  }) async {
    return await _repository.getServiceRequestsForReview(
      page: page,
      pageSize: pageSize,
      status: status,
    );
  }
}

/// UC-3.3.2: Document verification and milestone tracking
class GetServiceRequestsForDocumentReviewUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestsForDocumentReviewUseCase(this._repository);

  Future<List<ServiceRequestListItem>> call({
    required int page,
    required int pageSize,
  }) async {
    return await _repository.getServiceRequestsForDocumentReview(
      page: page,
      pageSize: pageSize,
    );
  }
}

/// Verify or reject documents
class VerifyDocumentUseCase {
  final ServiceRequestRepository _repository;

  VerifyDocumentUseCase(this._repository);

  Future<RequestDocument> call(DocumentVerificationRequest request) async {
    return await _repository.verifyDocument(request);
  }
}

/// Update milestone status
class UpdateMilestoneUseCase {
  final ServiceRequestRepository _repository;

  UpdateMilestoneUseCase(this._repository);

  Future<RequestMilestone> call(MilestoneUpdateRequest request) async {
    return await _repository.updateMilestone(request);
  }
}

/// Get service request statistics for dashboard
class GetServiceRequestStatsUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestStatsUseCase(this._repository);

  Future<Map<String, dynamic>> call({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _repository.getServiceRequestStats(
      startDate: startDate,
      endDate: endDate,
    );
  }
}

/// Get service request metrics for performance tracking
class GetServiceRequestMetricsUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestMetricsUseCase(this._repository);

  Future<Map<String, dynamic>> call({
    required String timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _repository.getServiceRequestMetrics(
      timeRange: timeRange,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

/// Export service requests data
class ExportServiceRequestsUseCase {
  final ServiceRequestRepository _repository;

  ExportServiceRequestsUseCase(this._repository);

  Future<String> call({
    required String format,
    String? searchQuery,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _repository.exportServiceRequests(
      format: format,
      searchQuery: searchQuery,
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

/// Get service request timeline/history
class GetServiceRequestTimelineUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestTimelineUseCase(this._repository);

  Future<List<Map<String, dynamic>>> call(String id) async {
    return await _repository.getServiceRequestTimeline(id);
  }
}

/// Send notification to stakeholders
class SendServiceRequestNotificationUseCase {
  final ServiceRequestRepository _repository;

  SendServiceRequestNotificationUseCase(this._repository);

  Future<void> call({
    required String requestId,
    required String recipientId,
    required String message,
    required String type,
  }) async {
    return await _repository.sendServiceRequestNotification(
      requestId: requestId,
      recipientId: recipientId,
      message: message,
      type: type,
    );
  }
}

/// Get pending document verification count
class GetPendingDocumentVerificationCountUseCase {
  final ServiceRequestRepository _repository;

  GetPendingDocumentVerificationCountUseCase(this._repository);

  Future<int> call() async {
    return await _repository.getPendingDocumentVerificationCount();
  }
}

/// Get overdue service requests count
class GetOverdueServiceRequestsCountUseCase {
  final ServiceRequestRepository _repository;

  GetOverdueServiceRequestsCountUseCase(this._repository);

  Future<int> call() async {
    return await _repository.getOverdueServiceRequestsCount();
  }
}

/// Get service requests by provider for performance monitoring
class GetServiceRequestsByProviderUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestsByProviderUseCase(this._repository);

  Future<List<ServiceRequestListItem>> call({
    required String providerId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _repository.getServiceRequestsByProvider(
      providerId: providerId,
      page: page,
      pageSize: pageSize,
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

/// Get service requests by student for support purposes
class GetServiceRequestsByStudentUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestsByStudentUseCase(this._repository);

  Future<List<ServiceRequestListItem>> call({
    required String studentId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _repository.getServiceRequestsByStudent(
      studentId: studentId,
      page: page,
      pageSize: pageSize,
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

/// Assign admin to service request for escalated cases
class AssignAdminToServiceRequestUseCase {
  final ServiceRequestRepository _repository;

  AssignAdminToServiceRequestUseCase(this._repository);

  Future<ServiceRequest> call({
    required String requestId,
    required String adminId,
    String? notes,
  }) async {
    return await _repository.assignAdminToServiceRequest(
      requestId: requestId,
      adminId: adminId,
      notes: notes,
    );
  }
}

/// Get service requests assigned to specific admin
class GetServiceRequestsAssignedToAdminUseCase {
  final ServiceRequestRepository _repository;

  GetServiceRequestsAssignedToAdminUseCase(this._repository);

  Future<List<ServiceRequestListItem>> call({
    required String adminId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
  }) async {
    return await _repository.getServiceRequestsAssignedToAdmin(
      adminId: adminId,
      page: page,
      pageSize: pageSize,
      status: status,
    );
  }
}

/// Escalate service request to admin
class EscalateServiceRequestUseCase {
  final ServiceRequestRepository _repository;

  EscalateServiceRequestUseCase(this._repository);

  Future<ServiceRequest> call({
    required String requestId,
    required String reason,
    required String escalatedBy,
  }) async {
    return await _repository.escalateServiceRequest(
      requestId: requestId,
      reason: reason,
      escalatedBy: escalatedBy,
    );
  }
}

/// Get disputed service requests
class GetDisputedServiceRequestsUseCase {
  final ServiceRequestRepository _repository;

  GetDisputedServiceRequestsUseCase(this._repository);

  Future<List<ServiceRequestListItem>> call({
    required int page,
    required int pageSize,
  }) async {
    return await _repository.getDisputedServiceRequests(
      page: page,
      pageSize: pageSize,
    );
  }
}

/// Resolve dispute
class ResolveDisputeUseCase {
  final ServiceRequestRepository _repository;

  ResolveDisputeUseCase(this._repository);

  Future<ServiceRequest> call({
    required String requestId,
    required String resolution,
    required String resolvedBy,
    required String resolutionType,
  }) async {
    return await _repository.resolveDispute(
      requestId: requestId,
      resolution: resolution,
      resolvedBy: resolvedBy,
      resolutionType: resolutionType,
    );
  }
}
