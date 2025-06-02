import '../../domain/datasources/financial_data_source.dart';
import '../../domain/models/financial.dart';
import '../../domain/repositories/financial_repository.dart';

class FinancialRepositoryImpl implements FinancialRepository {
  final FinancialDataSource _dataSource;

  FinancialRepositoryImpl({required FinancialDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<List<EscrowPaymentListItem>> getEscrowPayments({
    required int page,
    required int pageSize,
    EscrowStatus? status,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    bool? sortDescending,
  }) {
    return _dataSource.getEscrowPayments(
      page: page,
      pageSize: pageSize,
      status: status,
      searchQuery: searchQuery,
      startDate: startDate,
      endDate: endDate,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }

  @override
  Future<EscrowPayment> getEscrowPaymentById(String id) {
    return _dataSource.getEscrowPaymentById(id);
  }

  @override
  Future<EscrowPayment> releaseEscrowPayment(ReleaseEscrowRequest request) {
    return _dataSource.releaseEscrowPayment(request);
  }

  @override
  Future<List<EscrowPaymentListItem>> getPendingEscrowPayments({
    required int page,
    required int pageSize,
  }) {
    return _dataSource.getPendingEscrowPayments(page: page, pageSize: pageSize);
  }

  @override
  Future<Map<EscrowStatus, int>> getEscrowPaymentCounts() {
    return _dataSource.getEscrowPaymentCounts();
  }

  @override
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
  }) {
    return _dataSource.getDisputes(
      page: page,
      pageSize: pageSize,
      status: status,
      type: type,
      searchQuery: searchQuery,
      startDate: startDate,
      endDate: endDate,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }

  @override
  Future<Dispute> getDisputeById(String id) {
    return _dataSource.getDisputeById(id);
  }

  @override
  Future<Dispute> resolveDispute(ResolveDisputeRequest request) {
    return _dataSource.resolveDispute(request);
  }

  @override
  Future<EscrowPayment> processRefund(RefundRequest request) {
    return _dataSource.processRefund(request);
  }

  @override
  Future<List<DisputeListItem>> getActiveDisputes({
    required int page,
    required int pageSize,
  }) {
    return _dataSource.getActiveDisputes(page: page, pageSize: pageSize);
  }

  @override
  Future<Map<DisputeStatus, int>> getDisputeCounts() {
    return _dataSource.getDisputeCounts();
  }

  @override
  Future<DisputeMessage> addDisputeMessage({
    required String disputeId,
    required String senderId,
    required String message,
  }) {
    return _dataSource.addDisputeMessage(
      disputeId: disputeId,
      senderId: senderId,
      message: message,
    );
  }

  @override
  Future<DisputeEvidence> uploadDisputeEvidence({
    required String disputeId,
    required String uploadedBy,
    required EvidenceType type,
    required String fileName,
    required String fileUrl,
    String? description,
  }) {
    return _dataSource.uploadDisputeEvidence(
      disputeId: disputeId,
      uploadedBy: uploadedBy,
      type: type,
      fileName: fileName,
      fileUrl: fileUrl,
      description: description,
    );
  }

  @override
  Future<FinancialMetrics> getFinancialMetrics({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _dataSource.getFinancialMetrics(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<Map<String, double>> getRevenueAnalytics({
    required DateTime startDate,
    required DateTime endDate,
    required String groupBy,
  }) {
    return _dataSource.getRevenueAnalytics(
      startDate: startDate,
      endDate: endDate,
      groupBy: groupBy,
    );
  }

  @override
  Future<Map<String, dynamic>> getTransactionAnalytics({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _dataSource.getTransactionAnalytics(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
