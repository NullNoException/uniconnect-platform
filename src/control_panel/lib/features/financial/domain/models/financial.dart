import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial.freezed.dart';
part 'financial.g.dart';

// UC-3.3.1: Escrow Payment Release
@freezed
abstract class EscrowPayment with _$EscrowPayment {
  const factory EscrowPayment({
    required String id,
    required String transactionId,
    required String orderId,
    required String customerId,
    required String providerId,
    required double amount,
    required String currency,
    required EscrowStatus status,
    required DateTime createdAt,
    DateTime? releasedAt,
    DateTime? refundedAt,
    String? releaseNotes,
    String? refundReason,
    String? adminId,
    // Customer info for display
    String? customerName,
    String? customerEmail,
    // Provider info for display
    String? providerName,
    String? providerEmail,
    // Order info for display
    String? serviceTitle,
    String? orderDescription,
  }) = _EscrowPayment;

  factory EscrowPayment.fromJson(Map<String, dynamic> json) =>
      _$EscrowPaymentFromJson(json);
}

enum EscrowStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Released')
  released,
  @JsonValue('Refunded')
  refunded,
  @JsonValue('Disputed')
  disputed,
  @JsonValue('Cancelled')
  cancelled,
}

@freezed
abstract class EscrowPaymentListItem with _$EscrowPaymentListItem {
  const factory EscrowPaymentListItem({
    required String id,
    required String transactionId,
    required String customerName,
    required String providerName,
    required String serviceTitle,
    required double amount,
    required String currency,
    required EscrowStatus status,
    required DateTime createdAt,
    DateTime? releasedAt,
    DateTime? refundedAt,
  }) = _EscrowPaymentListItem;

  factory EscrowPaymentListItem.fromJson(Map<String, dynamic> json) =>
      _$EscrowPaymentListItemFromJson(json);
}

@freezed
abstract class ReleaseEscrowRequest with _$ReleaseEscrowRequest {
  const factory ReleaseEscrowRequest({
    required String escrowPaymentId,
    required String adminId,
    String? releaseNotes,
    required bool confirmRelease,
  }) = _ReleaseEscrowRequest;

  factory ReleaseEscrowRequest.fromJson(Map<String, dynamic> json) =>
      _$ReleaseEscrowRequestFromJson(json);
}

// UC-3.3.2: Refund and Dispute Management
@freezed
abstract class Dispute with _$Dispute {
  const factory Dispute({
    required String id,
    required String transactionId,
    required String orderId,
    required String customerId,
    required String providerId,
    required DisputeType type,
    required DisputeStatus status,
    required String reason,
    String? description,
    required DateTime createdAt,
    DateTime? resolvedAt,
    String? resolution,
    String? adminId,
    double? refundAmount,
    List<DisputeEvidence>? evidence,
    List<DisputeMessage>? messages,
    // Display info
    String? customerName,
    String? providerName,
    String? serviceTitle,
    double? originalAmount,
    String? currency,
  }) = _Dispute;

  factory Dispute.fromJson(Map<String, dynamic> json) =>
      _$DisputeFromJson(json);
}

enum DisputeType {
  @JsonValue('ServiceNotDelivered')
  serviceNotDelivered,
  @JsonValue('ServiceQuality')
  serviceQuality,
  @JsonValue('PaymentIssue')
  paymentIssue,
  @JsonValue('RefundRequest')
  refundRequest,
  @JsonValue('Other')
  other,
}

enum DisputeStatus {
  @JsonValue('Open')
  open,
  @JsonValue('InProgress')
  inProgress,
  @JsonValue('Resolved')
  resolved,
  @JsonValue('Closed')
  closed,
  @JsonValue('Escalated')
  escalated,
}

@freezed
abstract class DisputeListItem with _$DisputeListItem {
  const factory DisputeListItem({
    required String id,
    required String customerName,
    required String providerName,
    required String serviceTitle,
    required DisputeType type,
    required DisputeStatus status,
    required double originalAmount,
    required String currency,
    required DateTime createdAt,
    DateTime? resolvedAt,
    bool? isUrgent,
  }) = _DisputeListItem;

  factory DisputeListItem.fromJson(Map<String, dynamic> json) =>
      _$DisputeListItemFromJson(json);
}

@freezed
abstract class DisputeEvidence with _$DisputeEvidence {
  const factory DisputeEvidence({
    required String id,
    required String disputeId,
    required String uploadedBy,
    required EvidenceType type,
    required String fileName,
    required String fileUrl,
    String? description,
    required DateTime uploadedAt,
  }) = _DisputeEvidence;

  factory DisputeEvidence.fromJson(Map<String, dynamic> json) =>
      _$DisputeEvidenceFromJson(json);
}

enum EvidenceType {
  @JsonValue('Document')
  document,
  @JsonValue('Image')
  image,
  @JsonValue('Video')
  video,
  @JsonValue('Screenshot')
  screenshot,
  @JsonValue('Other')
  other,
}

@freezed
abstract class DisputeMessage with _$DisputeMessage {
  const factory DisputeMessage({
    required String id,
    required String disputeId,
    required String senderId,
    required String senderName,
    required String message,
    required DateTime sentAt,
    bool? isAdminMessage,
  }) = _DisputeMessage;

  factory DisputeMessage.fromJson(Map<String, dynamic> json) =>
      _$DisputeMessageFromJson(json);
}

@freezed
abstract class ResolveDisputeRequest with _$ResolveDisputeRequest {
  const factory ResolveDisputeRequest({
    required String disputeId,
    required String adminId,
    required DisputeResolution resolution,
    String? resolutionNotes,
    double? refundAmount,
    String? refundReason,
  }) = _ResolveDisputeRequest;

  factory ResolveDisputeRequest.fromJson(Map<String, dynamic> json) =>
      _$ResolveDisputeRequestFromJson(json);
}

enum DisputeResolution {
  @JsonValue('FavorCustomer')
  favorCustomer,
  @JsonValue('FavorProvider')
  favorProvider,
  @JsonValue('PartialRefund')
  partialRefund,
  @JsonValue('FullRefund')
  fullRefund,
  @JsonValue('NoAction')
  noAction,
}

@freezed
abstract class RefundRequest with _$RefundRequest {
  const factory RefundRequest({
    required String transactionId,
    required String adminId,
    required double refundAmount,
    required String refundReason,
    String? refundNotes,
    required bool confirmRefund,
  }) = _RefundRequest;

  factory RefundRequest.fromJson(Map<String, dynamic> json) =>
      _$RefundRequestFromJson(json);
}

// Financial Analytics
@freezed
abstract class FinancialMetrics with _$FinancialMetrics {
  const factory FinancialMetrics({
    required double totalRevenue,
    required double totalEscrowHeld,
    required double totalRefunded,
    required int totalTransactions,
    required int pendingEscrows,
    required int activeDisputes,
    required double averageTransactionValue,
    required double refundRate,
    required Map<String, double> revenueByMonth,
    required Map<String, int> transactionsByStatus,
    required List<TopProvider> topProviders,
  }) = _FinancialMetrics;

  factory FinancialMetrics.fromJson(Map<String, dynamic> json) =>
      _$FinancialMetricsFromJson(json);
}

@freezed
abstract class TopProvider with _$TopProvider {
  const factory TopProvider({
    required String providerId,
    required String providerName,
    required double totalRevenue,
    required int totalOrders,
    required double averageOrderValue,
  }) = _TopProvider;

  factory TopProvider.fromJson(Map<String, dynamic> json) =>
      _$TopProviderFromJson(json);
}
