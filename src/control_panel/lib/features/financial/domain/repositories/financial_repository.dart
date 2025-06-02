import '../models/financial.dart';

abstract class FinancialRepository {
  /// Get escrow payments with filtering and pagination
  Future<List<EscrowPaymentListItem>> getEscrowPayments({
    required int page,
    required int pageSize,
    EscrowStatus? status,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    bool? sortDescending,
  });

  /// Get a specific escrow payment by ID
  Future<EscrowPayment> getEscrowPaymentById(String id);

  /// Release escrow payment to provider (UC-3.3.1)
  Future<EscrowPayment> releaseEscrowPayment(ReleaseEscrowRequest request);

  /// Get pending escrow payments requiring action
  Future<List<EscrowPaymentListItem>> getPendingEscrowPayments({
    required int page,
    required int pageSize,
  });

  /// Get escrow payments count by status
  Future<Map<EscrowStatus, int>> getEscrowPaymentCounts();

  // Dispute Management (UC-3.3.2)

  /// Get disputes with filtering and pagination
  Future<List<DisputeListItem>> getDisputes({
    required int page,
    required int pageSize,
    DisputeStatus? status,
    DisputeType? type,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    bool? sortDescending,
  });

  /// Get a specific dispute by ID
  Future<Dispute> getDisputeById(String id);

  /// Resolve a dispute
  Future<Dispute> resolveDispute(ResolveDisputeRequest request);

  /// Process a refund
  Future<EscrowPayment> processRefund(RefundRequest request);

  /// Get active disputes requiring action
  Future<List<DisputeListItem>> getActiveDisputes({
    required int page,
    required int pageSize,
  });

  /// Get dispute counts by status
  Future<Map<DisputeStatus, int>> getDisputeCounts();

  /// Add message to dispute
  Future<DisputeMessage> addDisputeMessage({
    required String disputeId,
    required String senderId,
    required String message,
  });

  /// Upload evidence to dispute
  Future<DisputeEvidence> uploadDisputeEvidence({
    required String disputeId,
    required String uploadedBy,
    required EvidenceType type,
    required String fileName,
    required String fileUrl,
    String? description,
  });

  // Financial Analytics

  /// Get financial metrics and analytics
  Future<FinancialMetrics> getFinancialMetrics({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get revenue analytics by period
  Future<Map<String, double>> getRevenueAnalytics({
    required DateTime startDate,
    required DateTime endDate,
    required String groupBy, // 'day', 'week', 'month', 'year'
  });

  /// Get transaction analytics
  Future<Map<String, dynamic>> getTransactionAnalytics({
    DateTime? startDate,
    DateTime? endDate,
  });
}
