import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_request.freezed.dart';
part 'service_request.g.dart';

@freezed
abstract class ServiceRequest with _$ServiceRequest {
  const factory ServiceRequest({
    required String id,
    required String studentId,
    required String serviceId,
    required String serviceName,
    required String studentName,
    required String providerName,
    required ServiceRequestStatus status,
    required DateTime initiatedDate,
    DateTime? requiredByDate,
    DateTime? expectedCompletionDate,
    DateTime? completedDate,
    DateTime? cancelledDate,
    String? cancellationReason,
    String? description,
    String? notes,
    String? assignedAdminId,
    required double totalAmount,
    required String currency,
    @Default([]) List<RequestDocument> documents,
    @Default([]) List<RequestMilestone> milestones,
    @Default([]) List<ServiceRequestTransaction> transactions,
    @Default([]) List<ServiceRequestReview> reviews,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ServiceRequest;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);
}

@freezed
abstract class ServiceRequestListItem with _$ServiceRequestListItem {
  const factory ServiceRequestListItem({
    required String id,
    required String studentId,
    required String serviceId,
    required String serviceName,
    required String studentName,
    required String providerName,
    required ServiceRequestStatus status,
    required DateTime initiatedDate,
    DateTime? requiredByDate,
    DateTime? completedDate,
    required double totalAmount,
    required String currency,
    required int documentsCount,
    required int milestonesCount,
    required bool hasUnreadMessages,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ServiceRequestListItem;

  factory ServiceRequestListItem.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestListItemFromJson(json);
}

@freezed
abstract class RequestDocument with _$RequestDocument {
  const factory RequestDocument({
    required String id,
    required String requestId,
    required String documentTypeId,
    required String documentName,
    required String fileUrl,
    required int fileSize,
    required DateTime uploadDate,
    required DocumentStatus status,
    String? verifiedById,
    DateTime? verificationDate,
    String? verificationNotes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RequestDocument;

  factory RequestDocument.fromJson(Map<String, dynamic> json) =>
      _$RequestDocumentFromJson(json);
}

// Extension to provide additional getters for compatibility
extension RequestDocumentExtension on RequestDocument {
  String get fileName => documentName;
  String get documentType =>
      documentTypeId; // This might need mapping to actual type name
  DateTime get submissionDate => uploadDate;
}

@freezed
abstract class RequestMilestone with _$RequestMilestone {
  const factory RequestMilestone({
    required String id,
    required String requestId,
    required String milestoneName,
    String? description,
    DateTime? dueDate,
    DateTime? completionDate,
    required MilestoneStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RequestMilestone;

  factory RequestMilestone.fromJson(Map<String, dynamic> json) =>
      _$RequestMilestoneFromJson(json);
}

// Extension to provide additional getters for compatibility
extension RequestMilestoneExtension on RequestMilestone {
  String get title => milestoneName;
  DateTime? get targetDate => dueDate;
  double get progress {
    switch (status) {
      case MilestoneStatus.pending:
        return 0.0;
      case MilestoneStatus.inProgress:
        return 0.5;
      case MilestoneStatus.completed:
        return 1.0;
      case MilestoneStatus.overdue:
        return 0.3; // Partially complete but overdue
      case MilestoneStatus.cancelled:
        return 0.0; // Cancelled milestones have no progress
    }
  }

  String? get notes => description;
}

@freezed
abstract class ServiceRequestTransaction with _$ServiceRequestTransaction {
  const factory ServiceRequestTransaction({
    required String id,
    required String requestId,
    required TransactionType type,
    required double amount,
    required String currency,
    required TransactionStatus status,
    String? description,
    required DateTime createdAt,
  }) = _ServiceRequestTransaction;

  factory ServiceRequestTransaction.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestTransactionFromJson(json);
}

@freezed
abstract class ServiceRequestReview with _$ServiceRequestReview {
  const factory ServiceRequestReview({
    required String id,
    required String requestId,
    required String reviewerId,
    required String reviewerName,
    required int rating,
    String? comment,
    required DateTime reviewDate,
    String? response,
    DateTime? responseDate,
    required DateTime createdAt,
  }) = _ServiceRequestReview;

  factory ServiceRequestReview.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestReviewFromJson(json);
}

// Request DTOs
@freezed
abstract class ServiceRequestUpdateRequest with _$ServiceRequestUpdateRequest {
  const factory ServiceRequestUpdateRequest({
    ServiceRequestStatus? status,
    DateTime? requiredByDate,
    DateTime? completedDate,
    String? cancellationReason,
    String? notes,
  }) = _ServiceRequestUpdateRequest;

  factory ServiceRequestUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestUpdateRequestFromJson(json);
}

@freezed
abstract class DocumentVerificationRequest with _$DocumentVerificationRequest {
  const factory DocumentVerificationRequest({
    required String documentId,
    required DocumentStatus status,
    String? verificationNotes,
    required String verifiedBy,
  }) = _DocumentVerificationRequest;

  factory DocumentVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$DocumentVerificationRequestFromJson(json);
}

@freezed
abstract class MilestoneUpdateRequest with _$MilestoneUpdateRequest {
  const factory MilestoneUpdateRequest({
    required String milestoneId,
    required MilestoneStatus status,
    DateTime? completionDate,
    String? notes,
  }) = _MilestoneUpdateRequest;

  factory MilestoneUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$MilestoneUpdateRequestFromJson(json);
}

// Extension to provide additional getters for compatibility with the API
extension MilestoneUpdateRequestExtension on MilestoneUpdateRequest {
  String get id => milestoneId;
  String get requestId =>
      milestoneId.split('_').first; // Assuming ID format includes request ID
}

// Enums
enum ServiceRequestStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('submitted')
  submitted,
  @JsonValue('under_review')
  underReview,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('waiting_for_documents')
  waitingForDocuments,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('disputed')
  disputed,
  @JsonValue('refunded')
  refunded,
}

enum DocumentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('pending_verification')
  pendingVerification,
  @JsonValue('verified')
  verified,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('requires_resubmission')
  requiresResubmission,
}

enum MilestoneStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('overdue')
  overdue,
  @JsonValue('cancelled')
  cancelled,
}

enum TransactionType {
  @JsonValue('payment')
  payment,
  @JsonValue('escrow')
  escrow,
  @JsonValue('release')
  release,
  @JsonValue('refund')
  refund,
  @JsonValue('fee')
  fee,
}

enum TransactionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
}

// Extension methods for UI display
extension ServiceRequestStatusExtension on ServiceRequestStatus {
  String get displayName {
    switch (this) {
      case ServiceRequestStatus.draft:
        return 'Draft';
      case ServiceRequestStatus.submitted:
        return 'Submitted';
      case ServiceRequestStatus.underReview:
        return 'Under Review';
      case ServiceRequestStatus.inProgress:
        return 'In Progress';
      case ServiceRequestStatus.waitingForDocuments:
        return 'Waiting for Documents';
      case ServiceRequestStatus.completed:
        return 'Completed';
      case ServiceRequestStatus.cancelled:
        return 'Cancelled';
      case ServiceRequestStatus.disputed:
        return 'Disputed';
      case ServiceRequestStatus.refunded:
        return 'Refunded';
    }
  }

  bool get isActive {
    return this != ServiceRequestStatus.completed &&
        this != ServiceRequestStatus.cancelled &&
        this != ServiceRequestStatus.refunded;
  }

  bool get requiresAction {
    return this == ServiceRequestStatus.submitted ||
        this == ServiceRequestStatus.underReview ||
        this == ServiceRequestStatus.waitingForDocuments ||
        this == ServiceRequestStatus.disputed;
  }
}

extension DocumentStatusExtension on DocumentStatus {
  String get displayName {
    switch (this) {
      case DocumentStatus.pending:
        return 'Pending Review';
      case DocumentStatus.pendingVerification:
        return 'Pending Verification';
      case DocumentStatus.verified:
        return 'Verified';
      case DocumentStatus.approved:
        return 'Approved';
      case DocumentStatus.rejected:
        return 'Rejected';
      case DocumentStatus.requiresResubmission:
        return 'Requires Resubmission';
    }
  }

  bool get isActionRequired {
    return this == DocumentStatus.pending;
  }
}

extension MilestoneStatusExtension on MilestoneStatus {
  String get displayName {
    switch (this) {
      case MilestoneStatus.pending:
        return 'Pending';
      case MilestoneStatus.inProgress:
        return 'In Progress';
      case MilestoneStatus.completed:
        return 'Completed';
      case MilestoneStatus.overdue:
        return 'Overdue';
      case MilestoneStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isOverdue {
    return this == MilestoneStatus.overdue;
  }

  bool get isActive {
    return this == MilestoneStatus.pending ||
        this == MilestoneStatus.inProgress;
  }
}

extension TransactionTypeExtension on TransactionType {
  String get displayName {
    switch (this) {
      case TransactionType.payment:
        return 'Payment';
      case TransactionType.escrow:
        return 'Escrow';
      case TransactionType.release:
        return 'Release';
      case TransactionType.refund:
        return 'Refund';
      case TransactionType.fee:
        return 'Fee';
    }
  }

  bool get isPositive {
    return this == TransactionType.payment ||
        this == TransactionType.escrow ||
        this == TransactionType.release;
  }

  bool get isNegative {
    return this == TransactionType.refund || this == TransactionType.fee;
  }
}

extension TransactionStatusExtension on TransactionStatus {
  String get displayName {
    switch (this) {
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.processing:
        return 'Processing';
      case TransactionStatus.completed:
        return 'Completed';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isSuccessful {
    return this == TransactionStatus.completed;
  }

  bool get isFinalState {
    return this == TransactionStatus.completed ||
        this == TransactionStatus.failed ||
        this == TransactionStatus.cancelled;
  }

  bool get canBeRetried {
    return this == TransactionStatus.failed;
  }
}

// Service Request Statistics Model
@freezed
abstract class ServiceRequestStats with _$ServiceRequestStats {
  const factory ServiceRequestStats({
    @Default(0) int totalRequests,
    @Default(0) int pendingRequests,
    @Default(0) int inProgressRequests,
    @Default(0) int completedRequests,
    @Default(0) int cancelledRequests,
    @Default(0) int disputedRequests,
    @Default(0.0) double totalRevenue,
    @Default(0.0) double pendingRevenue,
    @Default(0.0) double completedRevenue,
    @Default(0.0) double averageCompletionTime, // in days
    @Default(0.0) double customerSatisfactionRate,
  }) = _ServiceRequestStats;

  factory ServiceRequestStats.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestStatsFromJson(json);
}

extension ServiceRequestStatsExtension on ServiceRequestStats {
  double get completionRate {
    if (totalRequests == 0) return 0.0;
    return completedRequests / totalRequests;
  }

  double get cancellationRate {
    if (totalRequests == 0) return 0.0;
    return cancelledRequests / totalRequests;
  }

  int get activeRequests => pendingRequests + inProgressRequests;
}
