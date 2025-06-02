import '../models/financial.dart';
import '../repositories/financial_repository.dart';

// UC-3.3.1: Escrow Payment Release
class ReleaseEscrowPaymentUseCase {
  final FinancialRepository _repository;

  ReleaseEscrowPaymentUseCase(this._repository);

  Future<EscrowPayment> call(ReleaseEscrowRequest request) async {
    return await _repository.releaseEscrowPayment(request);
  }
}

class GetPendingEscrowPaymentsUseCase {
  final FinancialRepository _repository;

  GetPendingEscrowPaymentsUseCase(this._repository);

  Future<List<EscrowPaymentListItem>> call({
    required int page,
    required int pageSize,
  }) async {
    return await _repository.getPendingEscrowPayments(
      page: page,
      pageSize: pageSize,
    );
  }
}

class GetEscrowPaymentByIdUseCase {
  final FinancialRepository _repository;

  GetEscrowPaymentByIdUseCase(this._repository);

  Future<EscrowPayment> call(String id) async {
    return await _repository.getEscrowPaymentById(id);
  }
}

class GetEscrowPaymentCountsUseCase {
  final FinancialRepository _repository;

  GetEscrowPaymentCountsUseCase(this._repository);

  Future<Map<EscrowStatus, int>> call() async {
    return await _repository.getEscrowPaymentCounts();
  }
}

// UC-3.3.2: Refund and Dispute Management
class ResolveDisputeUseCase {
  final FinancialRepository _repository;

  ResolveDisputeUseCase(this._repository);

  Future<Dispute> call(ResolveDisputeRequest request) async {
    return await _repository.resolveDispute(request);
  }
}

class ProcessRefundUseCase {
  final FinancialRepository _repository;

  ProcessRefundUseCase(this._repository);

  Future<EscrowPayment> call(RefundRequest request) async {
    return await _repository.processRefund(request);
  }
}

class GetActiveDisputesUseCase {
  final FinancialRepository _repository;

  GetActiveDisputesUseCase(this._repository);

  Future<List<DisputeListItem>> call({
    required int page,
    required int pageSize,
  }) async {
    return await _repository.getActiveDisputes(page: page, pageSize: pageSize);
  }
}

class GetDisputeByIdUseCase {
  final FinancialRepository _repository;

  GetDisputeByIdUseCase(this._repository);

  Future<Dispute> call(String id) async {
    return await _repository.getDisputeById(id);
  }
}

class GetDisputeCountsUseCase {
  final FinancialRepository _repository;

  GetDisputeCountsUseCase(this._repository);

  Future<Map<DisputeStatus, int>> call() async {
    return await _repository.getDisputeCounts();
  }
}

class AddDisputeMessageUseCase {
  final FinancialRepository _repository;

  AddDisputeMessageUseCase(this._repository);

  Future<DisputeMessage> call({
    required String disputeId,
    required String senderId,
    required String message,
  }) async {
    return await _repository.addDisputeMessage(
      disputeId: disputeId,
      senderId: senderId,
      message: message,
    );
  }
}

class UploadDisputeEvidenceUseCase {
  final FinancialRepository _repository;

  UploadDisputeEvidenceUseCase(this._repository);

  Future<DisputeEvidence> call({
    required String disputeId,
    required String uploadedBy,
    required EvidenceType type,
    required String fileName,
    required String fileUrl,
    String? description,
  }) async {
    return await _repository.uploadDisputeEvidence(
      disputeId: disputeId,
      uploadedBy: uploadedBy,
      type: type,
      fileName: fileName,
      fileUrl: fileUrl,
      description: description,
    );
  }
}

// Supporting Use Cases
class GetEscrowPaymentsUseCase {
  final FinancialRepository _repository;

  GetEscrowPaymentsUseCase(this._repository);

  Future<List<EscrowPaymentListItem>> call({
    required int page,
    required int pageSize,
    EscrowStatus? status,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    bool? sortDescending,
  }) async {
    return await _repository.getEscrowPayments(
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
}

class GetDisputesUseCase {
  final FinancialRepository _repository;

  GetDisputesUseCase(this._repository);

  Future<List<DisputeListItem>> call({
    required int page,
    required int pageSize,
    DisputeStatus? status,
    DisputeType? type,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    bool? sortDescending,
  }) async {
    return await _repository.getDisputes(
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
}

// Financial Analytics Use Cases
class GetFinancialMetricsUseCase {
  final FinancialRepository _repository;

  GetFinancialMetricsUseCase(this._repository);

  Future<FinancialMetrics> call({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _repository.getFinancialMetrics(
      startDate: startDate,
      endDate: endDate,
    );
  }
}

class GetRevenueAnalyticsUseCase {
  final FinancialRepository _repository;

  GetRevenueAnalyticsUseCase(this._repository);

  Future<Map<String, double>> call({
    required DateTime startDate,
    required DateTime endDate,
    required String groupBy,
  }) async {
    return await _repository.getRevenueAnalytics(
      startDate: startDate,
      endDate: endDate,
      groupBy: groupBy,
    );
  }
}

class GetTransactionAnalyticsUseCase {
  final FinancialRepository _repository;

  GetTransactionAnalyticsUseCase(this._repository);

  Future<Map<String, dynamic>> call({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _repository.getTransactionAnalytics(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
