import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/service.dart';
import '../../domain/usecases/service_usecases.dart';

// Service Approval State
class ServiceApprovalState {
  final List<ServiceListItem> pendingServices;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMoreData;
  final int queueCount;

  const ServiceApprovalState({
    this.pendingServices = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMoreData = true,
    this.queueCount = 0,
  });

  ServiceApprovalState copyWith({
    List<ServiceListItem>? pendingServices,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMoreData,
    int? queueCount,
  }) {
    return ServiceApprovalState(
      pendingServices: pendingServices ?? this.pendingServices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      queueCount: queueCount ?? this.queueCount,
    );
  }
}

// Service Approval Controller
class ServiceApprovalController extends StateNotifier<ServiceApprovalState> {
  final GetServicesForApprovalUseCase _getServicesForApprovalUseCase;
  final ApproveServiceUseCase _approveServiceUseCase;
  final GetServiceApprovalQueueCountUseCase
  _getServiceApprovalQueueCountUseCase;

  ServiceApprovalController(
    this._getServicesForApprovalUseCase,
    this._approveServiceUseCase,
    this._getServiceApprovalQueueCountUseCase,
  ) : super(const ServiceApprovalState());

  Future<void> loadPendingServices({bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(currentPage: 1, pendingServices: []);
    }

    if (state.isLoading || (!state.hasMoreData && !refresh)) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _getServicesForApprovalUseCase.call(
        page: state.currentPage,
        pageSize: 20,
      );

      final newServices = refresh
          ? result
          : [...state.pendingServices, ...result];

      state = state.copyWith(
        pendingServices: newServices,
        isLoading: false,
        currentPage: state.currentPage + 1,
        hasMoreData: result.length == 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadQueueCount() async {
    try {
      final count = await _getServiceApprovalQueueCountUseCase.call();
      state = state.copyWith(queueCount: count);
    } catch (e) {
      // Don't update error state for queue count failures
    }
  }

  Future<bool> approveService({
    required String serviceId,
    required bool isApproved,
    String? rejectionReason,
    String? notes,
    required String approvedByAdminId,
    bool? isFeatured,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final request = ApproveServiceRequest(
        serviceId: serviceId,
        isApproved: isApproved,
        rejectionReason: rejectionReason,
        notes: notes,
        approvedByAdminId: approvedByAdminId,
        isFeatured: isFeatured,
      );

      await _approveServiceUseCase.call(request);

      // Remove the service from pending list
      final updatedServices = state.pendingServices
          .where((service) => service.id != serviceId)
          .toList();

      state = state.copyWith(
        pendingServices: updatedServices,
        isLoading: false,
        queueCount: state.queueCount > 0 ? state.queueCount - 1 : 0,
      );

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> refreshPendingServices() async {
    await loadPendingServices(refresh: true);
    await loadQueueCount();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
