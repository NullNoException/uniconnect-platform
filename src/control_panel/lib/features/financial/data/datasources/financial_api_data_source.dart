import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/constants/app_constants.dart';
import '../../domain/datasources/financial_data_source.dart';
import '../../domain/models/financial.dart';

class FinancialApiDataSource implements FinancialDataSource {
  final http.Client _client;

  FinancialApiDataSource({http.Client? client})
    : _client = client ?? http.Client();

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
  }) async {
    try {
      final uri = Uri.parse(ApiEndpoints.escrowPayments).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          if (status != null) 'status': status.name,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
          if (startDate != null) 'startDate': startDate.toIso8601String(),
          if (endDate != null) 'endDate': endDate.toIso8601String(),
          if (sortBy != null) 'sortBy': sortBy,
          if (sortDescending != null)
            'sortDescending': sortDescending.toString(),
        },
      );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> escrowData = jsonData['data'] ?? [];
        return escrowData
            .map((item) => EscrowPaymentListItem.fromJson(item))
            .toList();
      } else {
        throw Exception(
          'Failed to fetch escrow payments: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<EscrowPayment> getEscrowPaymentById(String id) async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiEndpoints.escrowPaymentById}$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EscrowPayment.fromJson(jsonData['data']);
      } else {
        throw Exception(
          'Failed to fetch escrow payment details: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<EscrowPayment> releaseEscrowPayment(
    ReleaseEscrowRequest request,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.escrowRelease),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EscrowPayment.fromJson(jsonData['data']);
      } else {
        throw Exception(
          'Failed to release escrow payment: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<EscrowPaymentListItem>> getPendingEscrowPayments({
    required int page,
    required int pageSize,
  }) {
    return getEscrowPayments(
      page: page,
      pageSize: pageSize,
      status: EscrowStatus.pending,
    );
  }

  @override
  Future<Map<EscrowStatus, int>> getEscrowPaymentCounts() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiEndpoints.escrowPayments}/counts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final Map<String, dynamic> countsData = jsonData['data'];

        final Map<EscrowStatus, int> counts = {};
        for (final entry in countsData.entries) {
          final status = EscrowStatus.values.firstWhere(
            (s) => s.name == entry.key,
            orElse: () => EscrowStatus.pending,
          );
          counts[status] = entry.value as int;
        }

        return counts;
      } else {
        throw Exception(
          'Failed to fetch escrow payment counts: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
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
  }) async {
    try {
      final uri = Uri.parse(ApiEndpoints.disputes).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          if (status != null) 'status': status.name,
          if (type != null) 'type': type.name,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
          if (startDate != null) 'startDate': startDate.toIso8601String(),
          if (endDate != null) 'endDate': endDate.toIso8601String(),
          if (sortBy != null) 'sortBy': sortBy,
          if (sortDescending != null)
            'sortDescending': sortDescending.toString(),
        },
      );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> disputeData = jsonData['data'] ?? [];
        return disputeData
            .map((item) => DisputeListItem.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch disputes: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Dispute> getDisputeById(String id) async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiEndpoints.disputeById}$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Dispute.fromJson(jsonData['data']);
      } else {
        throw Exception(
          'Failed to fetch dispute details: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Dispute> resolveDispute(ResolveDisputeRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.disputeResolve),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Dispute.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to resolve dispute: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<EscrowPayment> processRefund(RefundRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.refunds),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EscrowPayment.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to process refund: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<DisputeListItem>> getActiveDisputes({
    required int page,
    required int pageSize,
  }) {
    return getDisputes(
      page: page,
      pageSize: pageSize,
      status: DisputeStatus.open,
    );
  }

  @override
  Future<Map<DisputeStatus, int>> getDisputeCounts() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiEndpoints.disputes}/counts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final Map<String, dynamic> countsData = jsonData['data'];

        final Map<DisputeStatus, int> counts = {};
        for (final entry in countsData.entries) {
          final status = DisputeStatus.values.firstWhere(
            (s) => s.name == entry.key,
            orElse: () => DisputeStatus.open,
          );
          counts[status] = entry.value as int;
        }

        return counts;
      } else {
        throw Exception(
          'Failed to fetch dispute counts: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<DisputeMessage> addDisputeMessage({
    required String disputeId,
    required String senderId,
    required String message,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiEndpoints.disputes}/$disputeId/messages'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
        body: json.encode({'senderId': senderId, 'message': message}),
      );

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return DisputeMessage.fromJson(jsonData['data']);
      } else {
        throw Exception(
          'Failed to add dispute message: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<DisputeEvidence> uploadDisputeEvidence({
    required String disputeId,
    required String uploadedBy,
    required EvidenceType type,
    required String fileName,
    required String fileUrl,
    String? description,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiEndpoints.disputes}/$disputeId/evidence'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
        body: json.encode({
          'uploadedBy': uploadedBy,
          'type': type.name,
          'fileName': fileName,
          'fileUrl': fileUrl,
          if (description != null) 'description': description,
        }),
      );

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return DisputeEvidence.fromJson(jsonData['data']);
      } else {
        throw Exception(
          'Failed to upload dispute evidence: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<FinancialMetrics> getFinancialMetrics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final uri = Uri.parse(ApiEndpoints.financialMetrics).replace(
        queryParameters: {
          if (startDate != null) 'startDate': startDate.toIso8601String(),
          if (endDate != null) 'endDate': endDate.toIso8601String(),
        },
      );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return FinancialMetrics.fromJson(jsonData['data']);
      } else {
        throw Exception(
          'Failed to fetch financial metrics: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, double>> getRevenueAnalytics({
    required DateTime startDate,
    required DateTime endDate,
    required String groupBy,
  }) async {
    try {
      final uri = Uri.parse('${ApiEndpoints.financialMetrics}/revenue').replace(
        queryParameters: {
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'groupBy': groupBy,
        },
      );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final Map<String, dynamic> revenueData = jsonData['data'];
        return revenueData.map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        );
      } else {
        throw Exception(
          'Failed to fetch revenue analytics: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getTransactionAnalytics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final uri = Uri.parse('${ApiEndpoints.financialMetrics}/transactions')
          .replace(
            queryParameters: {
              if (startDate != null) 'startDate': startDate.toIso8601String(),
              if (endDate != null) 'endDate': endDate.toIso8601String(),
            },
          );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token', // TODO: Get from auth service
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['data'];
      } else {
        throw Exception(
          'Failed to fetch transaction analytics: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
