import 'package:control_panel/features/service_requests/domain/models/service_request.dart';
import 'package:control_panel/features/service_requests/presentation/controllers/service_request_controller.dart';
import 'package:control_panel/features/service_requests/presentation/controllers/service_request_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/dependency_injection.dart';
import '../../domain/repositories/service_request_repository.dart';
import '../../domain/usecases/service_request_usecases.dart';

// Repository provider
final serviceRequestRepositoryProvider = Provider<ServiceRequestRepository>((
  ref,
) {
  return locator<ServiceRequestRepository>();
});

// Use case providers
final getServiceRequestsUseCaseProvider = Provider<GetServiceRequestsUseCase>((
  ref,
) {
  final repository = ref.read(serviceRequestRepositoryProvider);
  return GetServiceRequestsUseCase(repository);
});

final getServiceRequestByIdUseCaseProvider =
    Provider<GetServiceRequestByIdUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return GetServiceRequestByIdUseCase(repository);
    });

final updateServiceRequestUseCaseProvider =
    Provider<UpdateServiceRequestUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return UpdateServiceRequestUseCase(repository);
    });

final getServiceRequestStatsUseCaseProvider =
    Provider<GetServiceRequestStatsUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return GetServiceRequestStatsUseCase(repository);
    });

final getPendingDocumentVerificationCountUseCaseProvider =
    Provider<GetPendingDocumentVerificationCountUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return GetPendingDocumentVerificationCountUseCase(repository);
    });

final getOverdueServiceRequestsCountUseCaseProvider =
    Provider<GetOverdueServiceRequestsCountUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return GetOverdueServiceRequestsCountUseCase(repository);
    });

final verifyDocumentUseCaseProvider = Provider<VerifyDocumentUseCase>((ref) {
  final repository = ref.read(serviceRequestRepositoryProvider);
  return VerifyDocumentUseCase(repository);
});

final updateMilestoneUseCaseProvider = Provider<UpdateMilestoneUseCase>((ref) {
  final repository = ref.read(serviceRequestRepositoryProvider);
  return UpdateMilestoneUseCase(repository);
});

final resolveDisputeUseCaseProvider = Provider<ResolveDisputeUseCase>((ref) {
  final repository = ref.read(serviceRequestRepositoryProvider);
  return ResolveDisputeUseCase(repository);
});

final getDisputedServiceRequestsUseCaseProvider =
    Provider<GetDisputedServiceRequestsUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return GetDisputedServiceRequestsUseCase(repository);
    });

final getServiceRequestsForReviewUseCaseProvider =
    Provider<GetServiceRequestsForReviewUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return GetServiceRequestsForReviewUseCase(repository);
    });

final getServiceRequestsForDocumentReviewUseCaseProvider =
    Provider<GetServiceRequestsForDocumentReviewUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return GetServiceRequestsForDocumentReviewUseCase(repository);
    });

final exportServiceRequestsUseCaseProvider =
    Provider<ExportServiceRequestsUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return ExportServiceRequestsUseCase(repository);
    });

final getServiceRequestTimelineUseCaseProvider =
    Provider<GetServiceRequestTimelineUseCase>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      return GetServiceRequestTimelineUseCase(repository);
    });

// Controller providers
final serviceRequestControllerProvider =
    StateNotifierProvider<ServiceRequestController, ServiceRequestState>((ref) {
      final repository = ref.read(serviceRequestRepositoryProvider);
      final getServiceRequestsUseCase = ref.read(
        getServiceRequestsUseCaseProvider,
      );
      final getServiceRequestByIdUseCase = ref.read(
        getServiceRequestByIdUseCaseProvider,
      );
      final updateServiceRequestUseCase = ref.read(
        updateServiceRequestUseCaseProvider,
      );
      final getServiceRequestStatsUseCase = ref.read(
        getServiceRequestStatsUseCaseProvider,
      );
      final getPendingDocumentCountUseCase = ref.read(
        getPendingDocumentVerificationCountUseCaseProvider,
      );
      final getOverdueRequestsCountUseCase = ref.read(
        getOverdueServiceRequestsCountUseCaseProvider,
      );

      return ServiceRequestController(
        repository,
        getServiceRequestsUseCase,
        getServiceRequestByIdUseCase,
        updateServiceRequestUseCase,
        getServiceRequestStatsUseCase,
        getPendingDocumentCountUseCase,
        getOverdueRequestsCountUseCase,
      );
    });

final documentVerificationControllerProvider =
    StateNotifierProvider<
      DocumentVerificationController,
      DocumentVerificationState
    >((ref) {
      final verifyDocumentUseCase = ref.read(verifyDocumentUseCaseProvider);
      return DocumentVerificationController(verifyDocumentUseCase);
    });

final milestoneUpdateControllerProvider =
    StateNotifierProvider<MilestoneUpdateController, MilestoneUpdateState>((
      ref,
    ) {
      final updateMilestoneUseCase = ref.read(updateMilestoneUseCaseProvider);
      return MilestoneUpdateController(updateMilestoneUseCase);
    });

final disputeResolutionControllerProvider =
    StateNotifierProvider<DisputeResolutionController, DisputeResolutionState>((
      ref,
    ) {
      final resolveDisputeUseCase = ref.read(resolveDisputeUseCaseProvider);
      final getDisputedRequestsUseCase = ref.read(
        getDisputedServiceRequestsUseCaseProvider,
      );
      return DisputeResolutionController(
        resolveDisputeUseCase,
        getDisputedRequestsUseCase,
      );
    });

// Specialized providers for specific screens
final serviceRequestsForReviewProvider = FutureProvider.autoDispose
    .family<
      List<ServiceRequestListItem>,
      ({int page, int pageSize, ServiceRequestStatus? status})
    >((ref, params) {
      final useCase = ref.read(getServiceRequestsForReviewUseCaseProvider);
      return useCase.call(
        page: params.page,
        pageSize: params.pageSize,
        status: params.status,
      );
    });

final serviceRequestsForDocumentReviewProvider = FutureProvider.autoDispose
    .family<List<ServiceRequestListItem>, ({int page, int pageSize})>((
      ref,
      params,
    ) {
      final useCase = ref.read(
        getServiceRequestsForDocumentReviewUseCaseProvider,
      );
      return useCase.call(page: params.page, pageSize: params.pageSize);
    });

final disputedServiceRequestsProvider = FutureProvider.autoDispose
    .family<List<ServiceRequestListItem>, ({int page, int pageSize})>((
      ref,
      params,
    ) {
      final useCase = ref.read(getDisputedServiceRequestsUseCaseProvider);
      return useCase.call(page: params.page, pageSize: params.pageSize);
    });

final serviceRequestDetailsProvider = FutureProvider.autoDispose
    .family<ServiceRequest, String>((ref, id) {
      final useCase = ref.read(getServiceRequestByIdUseCaseProvider);
      return useCase.call(id);
    });

final serviceRequestTimelineProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, String>((ref, id) {
      final useCase = ref.read(getServiceRequestTimelineUseCaseProvider);
      return useCase.call(id);
    });

// Statistics providers
final serviceRequestStatsProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ({DateTime? startDate, DateTime? endDate})>((
      ref,
      params,
    ) {
      final useCase = ref.read(getServiceRequestStatsUseCaseProvider);
      return useCase.call(startDate: params.startDate, endDate: params.endDate);
    });

final pendingDocumentVerificationCountProvider =
    FutureProvider.autoDispose<int>((ref) {
      final useCase = ref.read(
        getPendingDocumentVerificationCountUseCaseProvider,
      );
      return useCase.call();
    });

final overdueServiceRequestsCountProvider = FutureProvider.autoDispose<int>((
  ref,
) {
  final useCase = ref.read(getOverdueServiceRequestsCountUseCaseProvider);
  return useCase.call();
});
