import '../../domain/datasources/service_request_data_source.dart';
import '../../domain/models/service_request.dart';
import '../../domain/repositories/service_request_repository.dart';

class ServiceRequestRepositoryImpl implements ServiceRequestRepository {
  final ServiceRequestDataSource _dataSource;

  ServiceRequestRepositoryImpl(this._dataSource);

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
    return await _dataSource.getServiceRequests(
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

  @override
  Future<ServiceRequest> getServiceRequestById(String id) async {
    return await _dataSource.getServiceRequestById(id);
  }

  @override
  Future<ServiceRequest> updateServiceRequest(
    String id,
    ServiceRequestUpdateRequest request,
  ) async {
    return await _dataSource.updateServiceRequest(id, request);
  }

  @override
  Future<List<ServiceRequestListItem>> getServiceRequestsForReview({
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
  }) async {
    return await _dataSource.getServiceRequestsForReview(
      page: page,
      pageSize: pageSize,
      status: status,
    );
  }

  @override
  Future<List<ServiceRequestListItem>> getServiceRequestsForDocumentReview({
    required int page,
    required int pageSize,
  }) async {
    return await _dataSource.getServiceRequestsForDocumentReview(
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<RequestDocument> verifyDocument(
    DocumentVerificationRequest request,
  ) async {
    return await _dataSource.verifyDocument(request);
  }

  @override
  Future<RequestMilestone> updateMilestone(
    MilestoneUpdateRequest request,
  ) async {
    return await _dataSource.updateMilestone(request);
  }

  @override
  Future<Map<String, dynamic>> getServiceRequestStats({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _dataSource.getServiceRequestStats(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<Map<String, dynamic>> getServiceRequestMetrics({
    required String timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _dataSource.getServiceRequestMetrics(
      timeRange: timeRange,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<String> exportServiceRequests({
    required String format,
    String? searchQuery,
    ServiceRequestStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _dataSource.exportServiceRequests(
      format: format,
      searchQuery: searchQuery,
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getServiceRequestTimeline(
    String id,
  ) async {
    return await _dataSource.getServiceRequestTimeline(id);
  }

  @override
  Future<void> sendServiceRequestNotification({
    required String requestId,
    required String recipientId,
    required String message,
    required String type,
  }) async {
    await _dataSource.sendServiceRequestNotification(
      requestId: requestId,
      recipientId: recipientId,
      message: message,
      type: type,
    );
  }

  @override
  Future<int> getPendingDocumentVerificationCount() async {
    return await _dataSource.getPendingDocumentVerificationCount();
  }

  @override
  Future<int> getOverdueServiceRequestsCount() async {
    return await _dataSource.getOverdueServiceRequestsCount();
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
    return await _dataSource.getServiceRequestsByProvider(
      providerId: providerId,
      page: page,
      pageSize: pageSize,
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
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
    return await _dataSource.getServiceRequestsByStudent(
      studentId: studentId,
      page: page,
      pageSize: pageSize,
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<ServiceRequest> assignAdminToServiceRequest({
    required String requestId,
    required String adminId,
    String? notes,
  }) async {
    return await _dataSource.assignAdminToServiceRequest(
      requestId: requestId,
      adminId: adminId,
      notes: notes,
    );
  }

  @override
  Future<List<ServiceRequestListItem>> getServiceRequestsAssignedToAdmin({
    required String adminId,
    required int page,
    required int pageSize,
    ServiceRequestStatus? status,
  }) async {
    return await _dataSource.getServiceRequestsAssignedToAdmin(
      adminId: adminId,
      page: page,
      pageSize: pageSize,
      status: status,
    );
  }

  @override
  Future<ServiceRequest> escalateServiceRequest({
    required String requestId,
    required String reason,
    required String escalatedBy,
  }) async {
    return await _dataSource.escalateServiceRequest(
      requestId: requestId,
      reason: reason,
      escalatedBy: escalatedBy,
    );
  }

  @override
  Future<List<ServiceRequestListItem>> getDisputedServiceRequests({
    required int page,
    required int pageSize,
  }) async {
    return await _dataSource.getDisputedServiceRequests(
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<ServiceRequest> resolveDispute({
    required String requestId,
    required String resolution,
    required String resolvedBy,
    required String resolutionType,
  }) async {
    return await _dataSource.resolveDispute(
      requestId: requestId,
      resolution: resolution,
      resolvedBy: resolvedBy,
      resolutionType: resolutionType,
    );
  }
}
