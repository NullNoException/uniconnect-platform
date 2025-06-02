// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EscrowPayment _$EscrowPaymentFromJson(Map<String, dynamic> json) =>
    _EscrowPayment(
      id: json['id'] as String,
      transactionId: json['transactionId'] as String,
      orderId: json['orderId'] as String,
      customerId: json['customerId'] as String,
      providerId: json['providerId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: $enumDecode(_$EscrowStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      releasedAt: json['releasedAt'] == null
          ? null
          : DateTime.parse(json['releasedAt'] as String),
      refundedAt: json['refundedAt'] == null
          ? null
          : DateTime.parse(json['refundedAt'] as String),
      releaseNotes: json['releaseNotes'] as String?,
      refundReason: json['refundReason'] as String?,
      adminId: json['adminId'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      providerName: json['providerName'] as String?,
      providerEmail: json['providerEmail'] as String?,
      serviceTitle: json['serviceTitle'] as String?,
      orderDescription: json['orderDescription'] as String?,
    );

Map<String, dynamic> _$EscrowPaymentToJson(_EscrowPayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'orderId': instance.orderId,
      'customerId': instance.customerId,
      'providerId': instance.providerId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _$EscrowStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'releasedAt': instance.releasedAt?.toIso8601String(),
      'refundedAt': instance.refundedAt?.toIso8601String(),
      'releaseNotes': instance.releaseNotes,
      'refundReason': instance.refundReason,
      'adminId': instance.adminId,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'providerName': instance.providerName,
      'providerEmail': instance.providerEmail,
      'serviceTitle': instance.serviceTitle,
      'orderDescription': instance.orderDescription,
    };

const _$EscrowStatusEnumMap = {
  EscrowStatus.pending: 'Pending',
  EscrowStatus.released: 'Released',
  EscrowStatus.refunded: 'Refunded',
  EscrowStatus.disputed: 'Disputed',
  EscrowStatus.cancelled: 'Cancelled',
};

_EscrowPaymentListItem _$EscrowPaymentListItemFromJson(
  Map<String, dynamic> json,
) => _EscrowPaymentListItem(
  id: json['id'] as String,
  transactionId: json['transactionId'] as String,
  customerName: json['customerName'] as String,
  providerName: json['providerName'] as String,
  serviceTitle: json['serviceTitle'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  status: $enumDecode(_$EscrowStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  releasedAt: json['releasedAt'] == null
      ? null
      : DateTime.parse(json['releasedAt'] as String),
  refundedAt: json['refundedAt'] == null
      ? null
      : DateTime.parse(json['refundedAt'] as String),
);

Map<String, dynamic> _$EscrowPaymentListItemToJson(
  _EscrowPaymentListItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'transactionId': instance.transactionId,
  'customerName': instance.customerName,
  'providerName': instance.providerName,
  'serviceTitle': instance.serviceTitle,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': _$EscrowStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'releasedAt': instance.releasedAt?.toIso8601String(),
  'refundedAt': instance.refundedAt?.toIso8601String(),
};

_ReleaseEscrowRequest _$ReleaseEscrowRequestFromJson(
  Map<String, dynamic> json,
) => _ReleaseEscrowRequest(
  escrowPaymentId: json['escrowPaymentId'] as String,
  adminId: json['adminId'] as String,
  releaseNotes: json['releaseNotes'] as String?,
  confirmRelease: json['confirmRelease'] as bool,
);

Map<String, dynamic> _$ReleaseEscrowRequestToJson(
  _ReleaseEscrowRequest instance,
) => <String, dynamic>{
  'escrowPaymentId': instance.escrowPaymentId,
  'adminId': instance.adminId,
  'releaseNotes': instance.releaseNotes,
  'confirmRelease': instance.confirmRelease,
};

_Dispute _$DisputeFromJson(Map<String, dynamic> json) => _Dispute(
  id: json['id'] as String,
  transactionId: json['transactionId'] as String,
  orderId: json['orderId'] as String,
  customerId: json['customerId'] as String,
  providerId: json['providerId'] as String,
  type: $enumDecode(_$DisputeTypeEnumMap, json['type']),
  status: $enumDecode(_$DisputeStatusEnumMap, json['status']),
  reason: json['reason'] as String,
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  resolvedAt: json['resolvedAt'] == null
      ? null
      : DateTime.parse(json['resolvedAt'] as String),
  resolution: json['resolution'] as String?,
  adminId: json['adminId'] as String?,
  refundAmount: (json['refundAmount'] as num?)?.toDouble(),
  evidence: (json['evidence'] as List<dynamic>?)
      ?.map((e) => DisputeEvidence.fromJson(e as Map<String, dynamic>))
      .toList(),
  messages: (json['messages'] as List<dynamic>?)
      ?.map((e) => DisputeMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
  customerName: json['customerName'] as String?,
  providerName: json['providerName'] as String?,
  serviceTitle: json['serviceTitle'] as String?,
  originalAmount: (json['originalAmount'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$DisputeToJson(_Dispute instance) => <String, dynamic>{
  'id': instance.id,
  'transactionId': instance.transactionId,
  'orderId': instance.orderId,
  'customerId': instance.customerId,
  'providerId': instance.providerId,
  'type': _$DisputeTypeEnumMap[instance.type]!,
  'status': _$DisputeStatusEnumMap[instance.status]!,
  'reason': instance.reason,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
  'resolvedAt': instance.resolvedAt?.toIso8601String(),
  'resolution': instance.resolution,
  'adminId': instance.adminId,
  'refundAmount': instance.refundAmount,
  'evidence': instance.evidence,
  'messages': instance.messages,
  'customerName': instance.customerName,
  'providerName': instance.providerName,
  'serviceTitle': instance.serviceTitle,
  'originalAmount': instance.originalAmount,
  'currency': instance.currency,
};

const _$DisputeTypeEnumMap = {
  DisputeType.serviceNotDelivered: 'ServiceNotDelivered',
  DisputeType.serviceQuality: 'ServiceQuality',
  DisputeType.paymentIssue: 'PaymentIssue',
  DisputeType.refundRequest: 'RefundRequest',
  DisputeType.other: 'Other',
};

const _$DisputeStatusEnumMap = {
  DisputeStatus.open: 'Open',
  DisputeStatus.inProgress: 'InProgress',
  DisputeStatus.resolved: 'Resolved',
  DisputeStatus.closed: 'Closed',
  DisputeStatus.escalated: 'Escalated',
};

_DisputeListItem _$DisputeListItemFromJson(Map<String, dynamic> json) =>
    _DisputeListItem(
      id: json['id'] as String,
      customerName: json['customerName'] as String,
      providerName: json['providerName'] as String,
      serviceTitle: json['serviceTitle'] as String,
      type: $enumDecode(_$DisputeTypeEnumMap, json['type']),
      status: $enumDecode(_$DisputeStatusEnumMap, json['status']),
      originalAmount: (json['originalAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
      isUrgent: json['isUrgent'] as bool?,
    );

Map<String, dynamic> _$DisputeListItemToJson(_DisputeListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'providerName': instance.providerName,
      'serviceTitle': instance.serviceTitle,
      'type': _$DisputeTypeEnumMap[instance.type]!,
      'status': _$DisputeStatusEnumMap[instance.status]!,
      'originalAmount': instance.originalAmount,
      'currency': instance.currency,
      'createdAt': instance.createdAt.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
      'isUrgent': instance.isUrgent,
    };

_DisputeEvidence _$DisputeEvidenceFromJson(Map<String, dynamic> json) =>
    _DisputeEvidence(
      id: json['id'] as String,
      disputeId: json['disputeId'] as String,
      uploadedBy: json['uploadedBy'] as String,
      type: $enumDecode(_$EvidenceTypeEnumMap, json['type']),
      fileName: json['fileName'] as String,
      fileUrl: json['fileUrl'] as String,
      description: json['description'] as String?,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );

Map<String, dynamic> _$DisputeEvidenceToJson(_DisputeEvidence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'disputeId': instance.disputeId,
      'uploadedBy': instance.uploadedBy,
      'type': _$EvidenceTypeEnumMap[instance.type]!,
      'fileName': instance.fileName,
      'fileUrl': instance.fileUrl,
      'description': instance.description,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
    };

const _$EvidenceTypeEnumMap = {
  EvidenceType.document: 'Document',
  EvidenceType.image: 'Image',
  EvidenceType.video: 'Video',
  EvidenceType.screenshot: 'Screenshot',
  EvidenceType.other: 'Other',
};

_DisputeMessage _$DisputeMessageFromJson(Map<String, dynamic> json) =>
    _DisputeMessage(
      id: json['id'] as String,
      disputeId: json['disputeId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      message: json['message'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      isAdminMessage: json['isAdminMessage'] as bool?,
    );

Map<String, dynamic> _$DisputeMessageToJson(_DisputeMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'disputeId': instance.disputeId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'message': instance.message,
      'sentAt': instance.sentAt.toIso8601String(),
      'isAdminMessage': instance.isAdminMessage,
    };

_ResolveDisputeRequest _$ResolveDisputeRequestFromJson(
  Map<String, dynamic> json,
) => _ResolveDisputeRequest(
  disputeId: json['disputeId'] as String,
  adminId: json['adminId'] as String,
  resolution: $enumDecode(_$DisputeResolutionEnumMap, json['resolution']),
  resolutionNotes: json['resolutionNotes'] as String?,
  refundAmount: (json['refundAmount'] as num?)?.toDouble(),
  refundReason: json['refundReason'] as String?,
);

Map<String, dynamic> _$ResolveDisputeRequestToJson(
  _ResolveDisputeRequest instance,
) => <String, dynamic>{
  'disputeId': instance.disputeId,
  'adminId': instance.adminId,
  'resolution': _$DisputeResolutionEnumMap[instance.resolution]!,
  'resolutionNotes': instance.resolutionNotes,
  'refundAmount': instance.refundAmount,
  'refundReason': instance.refundReason,
};

const _$DisputeResolutionEnumMap = {
  DisputeResolution.favorCustomer: 'FavorCustomer',
  DisputeResolution.favorProvider: 'FavorProvider',
  DisputeResolution.partialRefund: 'PartialRefund',
  DisputeResolution.fullRefund: 'FullRefund',
  DisputeResolution.noAction: 'NoAction',
};

_RefundRequest _$RefundRequestFromJson(Map<String, dynamic> json) =>
    _RefundRequest(
      transactionId: json['transactionId'] as String,
      adminId: json['adminId'] as String,
      refundAmount: (json['refundAmount'] as num).toDouble(),
      refundReason: json['refundReason'] as String,
      refundNotes: json['refundNotes'] as String?,
      confirmRefund: json['confirmRefund'] as bool,
    );

Map<String, dynamic> _$RefundRequestToJson(_RefundRequest instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'adminId': instance.adminId,
      'refundAmount': instance.refundAmount,
      'refundReason': instance.refundReason,
      'refundNotes': instance.refundNotes,
      'confirmRefund': instance.confirmRefund,
    };

_FinancialMetrics _$FinancialMetricsFromJson(Map<String, dynamic> json) =>
    _FinancialMetrics(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalEscrowHeld: (json['totalEscrowHeld'] as num).toDouble(),
      totalRefunded: (json['totalRefunded'] as num).toDouble(),
      totalTransactions: (json['totalTransactions'] as num).toInt(),
      pendingEscrows: (json['pendingEscrows'] as num).toInt(),
      activeDisputes: (json['activeDisputes'] as num).toInt(),
      averageTransactionValue: (json['averageTransactionValue'] as num)
          .toDouble(),
      refundRate: (json['refundRate'] as num).toDouble(),
      revenueByMonth: (json['revenueByMonth'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      transactionsByStatus: Map<String, int>.from(
        json['transactionsByStatus'] as Map,
      ),
      topProviders: (json['topProviders'] as List<dynamic>)
          .map((e) => TopProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FinancialMetricsToJson(_FinancialMetrics instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'totalEscrowHeld': instance.totalEscrowHeld,
      'totalRefunded': instance.totalRefunded,
      'totalTransactions': instance.totalTransactions,
      'pendingEscrows': instance.pendingEscrows,
      'activeDisputes': instance.activeDisputes,
      'averageTransactionValue': instance.averageTransactionValue,
      'refundRate': instance.refundRate,
      'revenueByMonth': instance.revenueByMonth,
      'transactionsByStatus': instance.transactionsByStatus,
      'topProviders': instance.topProviders,
    };

_TopProvider _$TopProviderFromJson(Map<String, dynamic> json) => _TopProvider(
  providerId: json['providerId'] as String,
  providerName: json['providerName'] as String,
  totalRevenue: (json['totalRevenue'] as num).toDouble(),
  totalOrders: (json['totalOrders'] as num).toInt(),
  averageOrderValue: (json['averageOrderValue'] as num).toDouble(),
);

Map<String, dynamic> _$TopProviderToJson(_TopProvider instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'providerName': instance.providerName,
      'totalRevenue': instance.totalRevenue,
      'totalOrders': instance.totalOrders,
      'averageOrderValue': instance.averageOrderValue,
    };
