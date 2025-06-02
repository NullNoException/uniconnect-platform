import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/service_request.dart';
import '../../domain/repositories/service_request_repository.dart';
import '../../domain/usecases/service_request_usecases.dart';
import 'service_request_state.dart';

/// Main service request controller that manages the overall state
class ServiceRequestController extends StateNotifier<ServiceRequestState> {
  final ServiceRequestRepository _repository;
  final GetServiceRequestsUseCase _getServiceRequestsUseCase;
  final GetServiceRequestByIdUseCase _getServiceRequestByIdUseCase;
  final UpdateServiceRequestUseCase _updateServiceRequestUseCase;
  final GetServiceRequestStatsUseCase _getServiceRequestStatsUseCase;
  final GetPendingDocumentVerificationCountUseCase
  _getPendingDocumentCountUseCase;
  final GetOverdueServiceRequestsCountUseCase _getOverdueRequestsCountUseCase;

  ServiceRequestController(
    this._repository,
    this._getServiceRequestsUseCase,
    this._getServiceRequestByIdUseCase,
    this._updateServiceRequestUseCase,
    this._getServiceRequestStatsUseCase,
    this._getPendingDocumentCountUseCase,
    this._getOverdueRequestsCountUseCase,
  ) : super(const ServiceRequestState());

  /// Load service requests with filtering and pagination
  Future<void> loadServiceRequests({
    int? page,
    int? pageSize,
    String? searchQuery,
    ServiceRequestStatus? status,
    String? studentId,
    String? providerId,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    bool? sortDescending,
  }) async {
    state = state.copyWith(
      isLoading: true,
      hasError: false,
      errorMessage: null,
      currentPage: page ?? state.currentPage,
      pageSize: pageSize ?? state.pageSize,
      searchQuery: searchQuery ?? state.searchQuery,
      statusFilter: status ?? state.statusFilter,
      studentFilter: studentId ?? state.studentFilter,
      providerFilter: providerId ?? state.providerFilter,
      startDateFilter: startDate ?? state.startDateFilter,
      endDateFilter: endDate ?? state.endDateFilter,
      sortBy: sortBy ?? state.sortBy,
      sortDescending: sortDescending ?? state.sortDescending,
    );

    try {
      final serviceRequests = await _getServiceRequestsUseCase.call(
        page: state.currentPage,
        pageSize: state.pageSize,
        searchQuery: state.searchQuery,
        status: state.statusFilter,
        studentId: state.studentFilter,
        providerId: state.providerFilter,
        serviceId: null,
        startDate: state.startDateFilter,
        endDate: state.endDateFilter,
        sortBy: state.sortBy,
        sortDescending: state.sortDescending,
      );

      state = state.copyWith(
        isLoading: false,
        serviceRequests: serviceRequests,
        // Note: In a real implementation, you'd get totalCount from the repository
        totalCount: serviceRequests.length, // Placeholder
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// Load service request details
  Future<void> loadServiceRequestDetails(String id) async {
    state = state.copyWith(
      isLoading: true,
      hasError: false,
      errorMessage: null,
    );

    try {
      final serviceRequest = await _getServiceRequestByIdUseCase.call(id);
      state = state.copyWith(
        isLoading: false,
        selectedServiceRequest: serviceRequest,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// Update service request
  Future<bool> updateServiceRequest(
    String id,
    ServiceRequestUpdateRequest request,
  ) async {
    state = state.copyWith(
      isSubmitting: true,
      hasError: false,
      errorMessage: null,
    );

    try {
      final updatedRequest = await _updateServiceRequestUseCase.call(
        id,
        request,
      );
      state = state.copyWith(
        isSubmitting: false,
        selectedServiceRequest: updatedRequest,
      );

      // Refresh the list
      await loadServiceRequests();
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Load dashboard statistics
  Future<void> loadDashboardStats({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final stats = await _getServiceRequestStatsUseCase.call(
        startDate: startDate,
        endDate: endDate,
      );

      final pendingCount = await _getPendingDocumentCountUseCase.call();
      final overdueCount = await _getOverdueRequestsCountUseCase.call();

      state = state.copyWith(
        stats: stats,
        pendingDocumentCount: pendingCount,
        overdueRequestsCount: overdueCount,
      );
    } catch (e) {
      state = state.copyWith(hasError: true, errorMessage: e.toString());
    }
  }

  /// Filter methods
  void setSearchQuery(String query) {
    state = state.copyWith(
      searchQuery: query.isEmpty ? null : query,
      currentPage: 1,
    );
  }

  void setStatusFilter(ServiceRequestStatus? status) {
    state = state.copyWith(statusFilter: status, currentPage: 1);
  }

  void setStudentFilter(String? studentId) {
    state = state.copyWith(studentFilter: studentId, currentPage: 1);
  }

  void setProviderFilter(String? providerId) {
    state = state.copyWith(providerFilter: providerId, currentPage: 1);
  }

  void setDateFilter(DateTime? startDate, DateTime? endDate) {
    state = state.copyWith(
      startDateFilter: startDate,
      endDateFilter: endDate,
      currentPage: 1,
    );
  }

  void setSorting(String field, bool descending) {
    state = state.copyWith(sortBy: field, sortDescending: descending);
  }

  /// Pagination methods
  void nextPage() {
    final maxPage = (state.totalCount / state.pageSize).ceil();
    if (state.currentPage < maxPage) {
      loadServiceRequests(page: state.currentPage + 1);
    }
  }

  void previousPage() {
    if (state.currentPage > 1) {
      loadServiceRequests(page: state.currentPage - 1);
    }
  }

  void goToPage(int page) {
    final maxPage = (state.totalCount / state.pageSize).ceil();
    if (page >= 1 && page <= maxPage) {
      loadServiceRequests(page: page);
    }
  }

  void setPageSize(int size) {
    loadServiceRequests(pageSize: size, page: 1);
  }

  /// Clear all filters
  void clearFilters() {
    loadServiceRequests(
      searchQuery: null,
      status: null,
      studentId: null,
      providerId: null,
      startDate: null,
      endDate: null,
      page: 1,
    );
  }

  /// Refresh current page
  Future<void> refresh() async {
    await loadServiceRequests();
  }
}

/// Document verification controller
class DocumentVerificationController
    extends StateNotifier<DocumentVerificationState> {
  final VerifyDocumentUseCase _verifyDocumentUseCase;

  DocumentVerificationController(this._verifyDocumentUseCase)
    : super(const DocumentVerificationState());

  Future<bool> verifyDocument(DocumentVerificationRequest request) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _verifyDocumentUseCase.call(request);
      state = state.copyWith(
        isLoading: false,
        successMessage: 'Document verification completed successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  void updateVerificationNotes(String notes) {
    state = state.copyWith(verificationNotes: notes);
  }

  void setStatus(DocumentStatus status) {
    state = state.copyWith(status: status);
  }

  void clearState() {
    state = const DocumentVerificationState();
  }
}

/// Milestone update controller
class MilestoneUpdateController extends StateNotifier<MilestoneUpdateState> {
  final UpdateMilestoneUseCase _updateMilestoneUseCase;

  MilestoneUpdateController(this._updateMilestoneUseCase)
    : super(const MilestoneUpdateState());

  Future<bool> updateMilestone(MilestoneUpdateRequest request) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _updateMilestoneUseCase.call(request);
      state = state.copyWith(
        isLoading: false,
        successMessage: 'Milestone updated successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  void setStatus(MilestoneStatus status) {
    state = state.copyWith(status: status);
  }

  void setCompletionDate(DateTime? date) {
    state = state.copyWith(completionDate: date);
  }

  void setNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  void clearState() {
    state = const MilestoneUpdateState();
  }
}

/// Dispute resolution controller
class DisputeResolutionController
    extends StateNotifier<DisputeResolutionState> {
  final ResolveDisputeUseCase _resolveDisputeUseCase;
  final GetDisputedServiceRequestsUseCase _getDisputedRequestsUseCase;

  DisputeResolutionController(
    this._resolveDisputeUseCase,
    this._getDisputedRequestsUseCase,
  ) : super(const DisputeResolutionState());

  Future<bool> resolveDispute({
    required String requestId,
    required String resolution,
    required String resolvedBy,
    required String resolutionType,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _resolveDisputeUseCase.call(
        requestId: requestId,
        resolution: resolution,
        resolvedBy: resolvedBy,
        resolutionType: resolutionType,
      );

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Dispute resolved successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  void setResolution(String resolution) {
    state = state.copyWith(resolution: resolution);
  }

  void setResolutionType(String type) {
    state = state.copyWith(resolutionType: type);
  }

  void clearState() {
    state = const DisputeResolutionState();
  }
}
