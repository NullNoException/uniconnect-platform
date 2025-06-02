import 'package:control_panel/core/utils/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/service_repository.dart';
import '../../domain/usecases/service_usecases.dart';
import '../../domain/models/service.dart';
import '../controllers/service_controller.dart';
import '../controllers/service_approval_controller.dart';
import '../controllers/service_category_controller.dart';

// Repository provider
final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  return locator<ServiceRepository>();
});

// Use case providers
final approveServiceUseCaseProvider = Provider<ApproveServiceUseCase>((ref) {
  return ApproveServiceUseCase(ref.watch(serviceRepositoryProvider));
});

final getServicesForApprovalUseCaseProvider =
    Provider<GetServicesForApprovalUseCase>((ref) {
      return GetServicesForApprovalUseCase(
        ref.watch(serviceRepositoryProvider),
      );
    });

final getServiceApprovalQueueCountUseCaseProvider =
    Provider<GetServiceApprovalQueueCountUseCase>((ref) {
      return GetServiceApprovalQueueCountUseCase(
        ref.watch(serviceRepositoryProvider),
      );
    });

final getServiceCategoriesUseCaseProvider =
    Provider<GetServiceCategoriesUseCase>((ref) {
      return GetServiceCategoriesUseCase(ref.watch(serviceRepositoryProvider));
    });

final createServiceCategoryUseCaseProvider =
    Provider<CreateServiceCategoryUseCase>((ref) {
      return CreateServiceCategoryUseCase(ref.watch(serviceRepositoryProvider));
    });

final updateServiceCategoryUseCaseProvider =
    Provider<UpdateServiceCategoryUseCase>((ref) {
      return UpdateServiceCategoryUseCase(ref.watch(serviceRepositoryProvider));
    });

final deleteServiceCategoryUseCaseProvider =
    Provider<DeleteServiceCategoryUseCase>((ref) {
      return DeleteServiceCategoryUseCase(ref.watch(serviceRepositoryProvider));
    });

final getServiceSubcategoriesUseCaseProvider =
    Provider<GetServiceSubcategoriesUseCase>((ref) {
      return GetServiceSubcategoriesUseCase(
        ref.watch(serviceRepositoryProvider),
      );
    });

final createServiceSubcategoryUseCaseProvider =
    Provider<CreateServiceSubcategoryUseCase>((ref) {
      return CreateServiceSubcategoryUseCase(
        ref.watch(serviceRepositoryProvider),
      );
    });

final updateServiceSubcategoryUseCaseProvider =
    Provider<UpdateServiceSubcategoryUseCase>((ref) {
      return UpdateServiceSubcategoryUseCase(
        ref.watch(serviceRepositoryProvider),
      );
    });

final deleteServiceSubcategoryUseCaseProvider =
    Provider<DeleteServiceSubcategoryUseCase>((ref) {
      return DeleteServiceSubcategoryUseCase(
        ref.watch(serviceRepositoryProvider),
      );
    });

final getServicesUseCaseProvider = Provider<GetServicesUseCase>((ref) {
  return GetServicesUseCase(ref.watch(serviceRepositoryProvider));
});

final getServiceByIdUseCaseProvider = Provider<GetServiceByIdUseCase>((ref) {
  return GetServiceByIdUseCase(ref.watch(serviceRepositoryProvider));
});

final updateServiceStatusUseCaseProvider = Provider<UpdateServiceStatusUseCase>(
  (ref) {
    return UpdateServiceStatusUseCase(ref.watch(serviceRepositoryProvider));
  },
);

final updateServiceFeaturedUseCaseProvider =
    Provider<UpdateServiceFeaturedUseCase>((ref) {
      return UpdateServiceFeaturedUseCase(ref.watch(serviceRepositoryProvider));
    });

final createServiceUseCaseProvider = Provider<CreateServiceUseCase>((ref) {
  return CreateServiceUseCase(ref.watch(serviceRepositoryProvider));
});

final updateServiceUseCaseProvider = Provider<UpdateServiceUseCase>((ref) {
  return UpdateServiceUseCase(ref.watch(serviceRepositoryProvider));
});

final deleteServiceUseCaseProvider = Provider<DeleteServiceUseCase>((ref) {
  return DeleteServiceUseCase(ref.watch(serviceRepositoryProvider));
});

// Controller providers
final serviceControllerProvider =
    StateNotifierProvider<ServiceController, ServiceState>((ref) {
      return ServiceController(
        ref.watch(getServicesUseCaseProvider),
        ref.watch(getServiceByIdUseCaseProvider),
        ref.watch(updateServiceStatusUseCaseProvider),
        ref.watch(updateServiceFeaturedUseCaseProvider),
        ref.watch(createServiceUseCaseProvider),
        ref.watch(updateServiceUseCaseProvider),
        ref.watch(deleteServiceUseCaseProvider),
      );
    });

final serviceApprovalControllerProvider =
    StateNotifierProvider<ServiceApprovalController, ServiceApprovalState>((
      ref,
    ) {
      return ServiceApprovalController(
        ref.watch(getServicesForApprovalUseCaseProvider),
        ref.watch(approveServiceUseCaseProvider),
        ref.watch(getServiceApprovalQueueCountUseCaseProvider),
      );
    });

final serviceCategoryControllerProvider =
    StateNotifierProvider<ServiceCategoryController, ServiceCategoryState>((
      ref,
    ) {
      return ServiceCategoryController(
        ref.watch(getServiceCategoriesUseCaseProvider),
        ref.watch(createServiceCategoryUseCaseProvider),
        ref.watch(updateServiceCategoryUseCaseProvider),
        ref.watch(deleteServiceCategoryUseCaseProvider),
        ref.watch(getServiceSubcategoriesUseCaseProvider),
        ref.watch(createServiceSubcategoryUseCaseProvider),
        ref.watch(updateServiceSubcategoryUseCaseProvider),
        ref.watch(deleteServiceSubcategoryUseCaseProvider),
      );
    });

// Future providers for async data
final serviceApprovalQueueCountProvider = FutureProvider<int>((ref) async {
  final useCase = ref.watch(getServiceApprovalQueueCountUseCaseProvider);
  return await useCase.call();
});

final serviceCategoriesProvider = FutureProvider<List<ServiceCategory>>((
  ref,
) async {
  final useCase = ref.watch(getServiceCategoriesUseCaseProvider);
  return await useCase.call(isActive: true);
});
