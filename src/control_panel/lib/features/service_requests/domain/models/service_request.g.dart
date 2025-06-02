// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceRequest _$ServiceRequestFromJson(
  Map<String, dynamic> json,
) => _ServiceRequest(
  id: json['id'] as String,
  studentId: json['studentId'] as String,
  serviceId: json['serviceId'] as String,
  serviceName: json['serviceName'] as String,
  studentName: json['studentName'] as String,
  providerName: json['providerName'] as String,
  status: $enumDecode(_$ServiceRequestStatusEnumMap, json['status']),
  initiatedDate: DateTime.parse(json['initiatedDate'] as String),
  requiredByDate: json['requiredByDate'] == null
      ? null
      : DateTime.parse(json['requiredByDate'] as String),
  expectedCompletionDate: json['expectedCompletionDate'] == null
      ? null
      : DateTime.parse(json['expectedCompletionDate'] as String),
  completedDate: json['completedDate'] == null
      ? null
      : DateTime.parse(json['completedDate'] as String),
  cancelledDate: json['cancelledDate'] == null
      ? null
      : DateTime.parse(json['cancelledDate'] as String),
  cancellationReason: json['cancellationReason'] as String?,
  description: json['description'] as String?,
  notes: json['notes'] as String?,
  assignedAdminId: json['assignedAdminId'] as String?,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  currency: json['currency'] as String,
  documents:
      (json['documents'] as List<dynamic>?)
          ?.map((e) => RequestDocument.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  milestones:
      (json['milestones'] as List<dynamic>?)
          ?.map((e) => RequestMilestone.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  transactions:
      (json['transactions'] as List<dynamic>?)
          ?.map(
            (e) =>
                ServiceRequestTransaction.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => ServiceRequestReview.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ServiceRequestToJson(
  _ServiceRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'studentId': instance.studentId,
  'serviceId': instance.serviceId,
  'serviceName': instance.serviceName,
  'studentName': instance.studentName,
  'providerName': instance.providerName,
  'status': _$ServiceRequestStatusEnumMap[instance.status]!,
  'initiatedDate': instance.initiatedDate.toIso8601String(),
  'requiredByDate': instance.requiredByDate?.toIso8601String(),
  'expectedCompletionDate': instance.expectedCompletionDate?.toIso8601String(),
  'completedDate': instance.completedDate?.toIso8601String(),
  'cancelledDate': instance.cancelledDate?.toIso8601String(),
  'cancellationReason': instance.cancellationReason,
  'description': instance.description,
  'notes': instance.notes,
  'assignedAdminId': instance.assignedAdminId,
  'totalAmount': instance.totalAmount,
  'currency': instance.currency,
  'documents': instance.documents,
  'milestones': instance.milestones,
  'transactions': instance.transactions,
  'reviews': instance.reviews,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$ServiceRequestStatusEnumMap = {
  ServiceRequestStatus.draft: 'draft',
  ServiceRequestStatus.submitted: 'submitted',
  ServiceRequestStatus.underReview: 'under_review',
  ServiceRequestStatus.inProgress: 'in_progress',
  ServiceRequestStatus.waitingForDocuments: 'waiting_for_documents',
  ServiceRequestStatus.completed: 'completed',
  ServiceRequestStatus.cancelled: 'cancelled',
  ServiceRequestStatus.disputed: 'disputed',
  ServiceRequestStatus.refunded: 'refunded',
};

_ServiceRequestListItem _$ServiceRequestListItemFromJson(
  Map<String, dynamic> json,
) => _ServiceRequestListItem(
  id: json['id'] as String,
  studentId: json['studentId'] as String,
  serviceId: json['serviceId'] as String,
  serviceName: json['serviceName'] as String,
  studentName: json['studentName'] as String,
  providerName: json['providerName'] as String,
  status: $enumDecode(_$ServiceRequestStatusEnumMap, json['status']),
  initiatedDate: DateTime.parse(json['initiatedDate'] as String),
  requiredByDate: json['requiredByDate'] == null
      ? null
      : DateTime.parse(json['requiredByDate'] as String),
  completedDate: json['completedDate'] == null
      ? null
      : DateTime.parse(json['completedDate'] as String),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  currency: json['currency'] as String,
  documentsCount: (json['documentsCount'] as num).toInt(),
  milestonesCount: (json['milestonesCount'] as num).toInt(),
  hasUnreadMessages: json['hasUnreadMessages'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ServiceRequestListItemToJson(
  _ServiceRequestListItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'studentId': instance.studentId,
  'serviceId': instance.serviceId,
  'serviceName': instance.serviceName,
  'studentName': instance.studentName,
  'providerName': instance.providerName,
  'status': _$ServiceRequestStatusEnumMap[instance.status]!,
  'initiatedDate': instance.initiatedDate.toIso8601String(),
  'requiredByDate': instance.requiredByDate?.toIso8601String(),
  'completedDate': instance.completedDate?.toIso8601String(),
  'totalAmount': instance.totalAmount,
  'currency': instance.currency,
  'documentsCount': instance.documentsCount,
  'milestonesCount': instance.milestonesCount,
  'hasUnreadMessages': instance.hasUnreadMessages,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_RequestDocument _$RequestDocumentFromJson(Map<String, dynamic> json) =>
    _RequestDocument(
      id: json['id'] as String,
      requestId: json['requestId'] as String,
      documentTypeId: json['documentTypeId'] as String,
      documentName: json['documentName'] as String,
      fileUrl: json['fileUrl'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      uploadDate: DateTime.parse(json['uploadDate'] as String),
      status: $enumDecode(_$DocumentStatusEnumMap, json['status']),
      verifiedById: json['verifiedById'] as String?,
      verificationDate: json['verificationDate'] == null
          ? null
          : DateTime.parse(json['verificationDate'] as String),
      verificationNotes: json['verificationNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RequestDocumentToJson(_RequestDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestId': instance.requestId,
      'documentTypeId': instance.documentTypeId,
      'documentName': instance.documentName,
      'fileUrl': instance.fileUrl,
      'fileSize': instance.fileSize,
      'uploadDate': instance.uploadDate.toIso8601String(),
      'status': _$DocumentStatusEnumMap[instance.status]!,
      'verifiedById': instance.verifiedById,
      'verificationDate': instance.verificationDate?.toIso8601String(),
      'verificationNotes': instance.verificationNotes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$DocumentStatusEnumMap = {
  DocumentStatus.pending: 'pending',
  DocumentStatus.pendingVerification: 'pending_verification',
  DocumentStatus.verified: 'verified',
  DocumentStatus.approved: 'approved',
  DocumentStatus.rejected: 'rejected',
  DocumentStatus.requiresResubmission: 'requires_resubmission',
};

_RequestMilestone _$RequestMilestoneFromJson(Map<String, dynamic> json) =>
    _RequestMilestone(
      id: json['id'] as String,
      requestId: json['requestId'] as String,
      milestoneName: json['milestoneName'] as String,
      description: json['description'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      completionDate: json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String),
      status: $enumDecode(_$MilestoneStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RequestMilestoneToJson(_RequestMilestone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestId': instance.requestId,
      'milestoneName': instance.milestoneName,
      'description': instance.description,
      'dueDate': instance.dueDate?.toIso8601String(),
      'completionDate': instance.completionDate?.toIso8601String(),
      'status': _$MilestoneStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$MilestoneStatusEnumMap = {
  MilestoneStatus.pending: 'pending',
  MilestoneStatus.inProgress: 'in_progress',
  MilestoneStatus.completed: 'completed',
  MilestoneStatus.overdue: 'overdue',
  MilestoneStatus.cancelled: 'cancelled',
};

_ServiceRequestTransaction _$ServiceRequestTransactionFromJson(
  Map<String, dynamic> json,
) => _ServiceRequestTransaction(
  id: json['id'] as String,
  requestId: json['requestId'] as String,
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ServiceRequestTransactionToJson(
  _ServiceRequestTransaction instance,
) => <String, dynamic>{
  'id': instance.id,
  'requestId': instance.requestId,
  'type': _$TransactionTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': _$TransactionStatusEnumMap[instance.status]!,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$TransactionTypeEnumMap = {
  TransactionType.payment: 'payment',
  TransactionType.escrow: 'escrow',
  TransactionType.release: 'release',
  TransactionType.refund: 'refund',
  TransactionType.fee: 'fee',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.processing: 'processing',
  TransactionStatus.completed: 'completed',
  TransactionStatus.failed: 'failed',
  TransactionStatus.cancelled: 'cancelled',
};

_ServiceRequestReview _$ServiceRequestReviewFromJson(
  Map<String, dynamic> json,
) => _ServiceRequestReview(
  id: json['id'] as String,
  requestId: json['requestId'] as String,
  reviewerId: json['reviewerId'] as String,
  reviewerName: json['reviewerName'] as String,
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
  reviewDate: DateTime.parse(json['reviewDate'] as String),
  response: json['response'] as String?,
  responseDate: json['responseDate'] == null
      ? null
      : DateTime.parse(json['responseDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ServiceRequestReviewToJson(
  _ServiceRequestReview instance,
) => <String, dynamic>{
  'id': instance.id,
  'requestId': instance.requestId,
  'reviewerId': instance.reviewerId,
  'reviewerName': instance.reviewerName,
  'rating': instance.rating,
  'comment': instance.comment,
  'reviewDate': instance.reviewDate.toIso8601String(),
  'response': instance.response,
  'responseDate': instance.responseDate?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
};

_ServiceRequestUpdateRequest _$ServiceRequestUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _ServiceRequestUpdateRequest(
  status: $enumDecodeNullable(_$ServiceRequestStatusEnumMap, json['status']),
  requiredByDate: json['requiredByDate'] == null
      ? null
      : DateTime.parse(json['requiredByDate'] as String),
  completedDate: json['completedDate'] == null
      ? null
      : DateTime.parse(json['completedDate'] as String),
  cancellationReason: json['cancellationReason'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$ServiceRequestUpdateRequestToJson(
  _ServiceRequestUpdateRequest instance,
) => <String, dynamic>{
  'status': _$ServiceRequestStatusEnumMap[instance.status],
  'requiredByDate': instance.requiredByDate?.toIso8601String(),
  'completedDate': instance.completedDate?.toIso8601String(),
  'cancellationReason': instance.cancellationReason,
  'notes': instance.notes,
};

_DocumentVerificationRequest _$DocumentVerificationRequestFromJson(
  Map<String, dynamic> json,
) => _DocumentVerificationRequest(
  documentId: json['documentId'] as String,
  status: $enumDecode(_$DocumentStatusEnumMap, json['status']),
  verificationNotes: json['verificationNotes'] as String?,
  verifiedBy: json['verifiedBy'] as String,
);

Map<String, dynamic> _$DocumentVerificationRequestToJson(
  _DocumentVerificationRequest instance,
) => <String, dynamic>{
  'documentId': instance.documentId,
  'status': _$DocumentStatusEnumMap[instance.status]!,
  'verificationNotes': instance.verificationNotes,
  'verifiedBy': instance.verifiedBy,
};

_MilestoneUpdateRequest _$MilestoneUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _MilestoneUpdateRequest(
  milestoneId: json['milestoneId'] as String,
  status: $enumDecode(_$MilestoneStatusEnumMap, json['status']),
  completionDate: json['completionDate'] == null
      ? null
      : DateTime.parse(json['completionDate'] as String),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$MilestoneUpdateRequestToJson(
  _MilestoneUpdateRequest instance,
) => <String, dynamic>{
  'milestoneId': instance.milestoneId,
  'status': _$MilestoneStatusEnumMap[instance.status]!,
  'completionDate': instance.completionDate?.toIso8601String(),
  'notes': instance.notes,
};

_ServiceRequestStats _$ServiceRequestStatsFromJson(Map<String, dynamic> json) =>
    _ServiceRequestStats(
      totalRequests: (json['totalRequests'] as num?)?.toInt() ?? 0,
      pendingRequests: (json['pendingRequests'] as num?)?.toInt() ?? 0,
      inProgressRequests: (json['inProgressRequests'] as num?)?.toInt() ?? 0,
      completedRequests: (json['completedRequests'] as num?)?.toInt() ?? 0,
      cancelledRequests: (json['cancelledRequests'] as num?)?.toInt() ?? 0,
      disputedRequests: (json['disputedRequests'] as num?)?.toInt() ?? 0,
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      pendingRevenue: (json['pendingRevenue'] as num?)?.toDouble() ?? 0.0,
      completedRevenue: (json['completedRevenue'] as num?)?.toDouble() ?? 0.0,
      averageCompletionTime:
          (json['averageCompletionTime'] as num?)?.toDouble() ?? 0.0,
      customerSatisfactionRate:
          (json['customerSatisfactionRate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ServiceRequestStatsToJson(
  _ServiceRequestStats instance,
) => <String, dynamic>{
  'totalRequests': instance.totalRequests,
  'pendingRequests': instance.pendingRequests,
  'inProgressRequests': instance.inProgressRequests,
  'completedRequests': instance.completedRequests,
  'cancelledRequests': instance.cancelledRequests,
  'disputedRequests': instance.disputedRequests,
  'totalRevenue': instance.totalRevenue,
  'pendingRevenue': instance.pendingRevenue,
  'completedRevenue': instance.completedRevenue,
  'averageCompletionTime': instance.averageCompletionTime,
  'customerSatisfactionRate': instance.customerSatisfactionRate,
};
