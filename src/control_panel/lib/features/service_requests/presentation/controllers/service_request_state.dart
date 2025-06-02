import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/service_request.dart';

part 'service_request_state.freezed.dart';

@freezed
abstract class ServiceRequestState with _$ServiceRequestState {
  const factory ServiceRequestState({
    @Default(false) bool isLoading,
    @Default(false) bool isSubmitting,
    @Default([]) List<ServiceRequestListItem> serviceRequests,
    ServiceRequest? selectedServiceRequest,
    @Default(1) int currentPage,
    @Default(10) int pageSize,
    @Default(0) int totalCount,
    String? searchQuery,
    ServiceRequestStatus? statusFilter,
    String? studentFilter,
    String? providerFilter,
    DateTime? startDateFilter,
    DateTime? endDateFilter,
    String? sortBy,
    @Default(true) bool sortDescending,
    @Default(false) bool hasError,
    String? errorMessage,

    // Document verification state
    @Default(false) bool isVerifyingDocument,
    @Default([]) List<RequestDocument> documentsForReview,
    @Default(0) int pendingDocumentCount,

    // Milestone tracking state
    @Default(false) bool isUpdatingMilestone,
    @Default([]) List<RequestMilestone> milestones,

    // Dispute resolution state
    @Default(false) bool isResolvingDispute,
    @Default([]) List<ServiceRequestListItem> disputedRequests,

    // Dashboard statistics
    Map<String, dynamic>? stats,
    Map<String, dynamic>? metrics,
    @Default(0) int overdueRequestsCount,
  }) = _ServiceRequestState;
}

@freezed
abstract class ServiceRequestFormState with _$ServiceRequestFormState {
  const factory ServiceRequestFormState({
    @Default(false) bool isLoading,
    @Default(false) bool isValid,
    ServiceRequestStatus? status,
    DateTime? requiredByDate,
    DateTime? completedDate,
    String? cancellationReason,
    String? notes,
    String? errorMessage,
    String? successMessage,
  }) = _ServiceRequestFormState;
}

@freezed
abstract class DocumentVerificationState with _$DocumentVerificationState {
  const factory DocumentVerificationState({
    @Default(false) bool isLoading,
    DocumentStatus? status,
    String? verificationNotes,
    String? errorMessage,
    String? successMessage,
  }) = _DocumentVerificationState;
}

@freezed
abstract class MilestoneUpdateState with _$MilestoneUpdateState {
  const factory MilestoneUpdateState({
    @Default(false) bool isLoading,
    MilestoneStatus? status,
    DateTime? completionDate,
    String? notes,
    String? errorMessage,
    String? successMessage,
  }) = _MilestoneUpdateState;
}

@freezed
abstract class DisputeResolutionState with _$DisputeResolutionState {
  const factory DisputeResolutionState({
    @Default(false) bool isLoading,
    String? resolution,
    String? resolutionType,
    String? errorMessage,
    String? successMessage,
  }) = _DisputeResolutionState;
}
