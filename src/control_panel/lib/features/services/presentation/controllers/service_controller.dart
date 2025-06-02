import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/service.dart';
import '../../domain/usecases/service_usecases.dart';

// Service State
class ServiceState {
  final List<ServiceListItem> services;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMoreData;
  final String? searchQuery;
  final ServiceApprovalStatus? selectedStatus;
  final String? selectedCategoryId;
  final Service? selectedService;

  const ServiceState({
    this.services = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMoreData = true,
    this.searchQuery,
    this.selectedStatus,
    this.selectedCategoryId,
    this.selectedService,
  });

  ServiceState copyWith({
    List<ServiceListItem>? services,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMoreData,
    String? searchQuery,
    ServiceApprovalStatus? selectedStatus,
    String? selectedCategoryId,
    Service? selectedService,
  }) {
    return ServiceState(
      services: services ?? this.services,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedService: selectedService ?? this.selectedService,
    );
  }
}

// Service Controller
class ServiceController extends StateNotifier<ServiceState> {
  final GetServicesUseCase _getServicesUseCase;
  final GetServiceByIdUseCase _getServiceByIdUseCase;
  final UpdateServiceStatusUseCase _updateServiceStatusUseCase;
  final UpdateServiceFeaturedUseCase _updateServiceFeaturedUseCase;
  final CreateServiceUseCase _createServiceUseCase;
  final UpdateServiceUseCase _updateServiceUseCase;
  final DeleteServiceUseCase _deleteServiceUseCase;

  ServiceController(
    this._getServicesUseCase,
    this._getServiceByIdUseCase,
    this._updateServiceStatusUseCase,
    this._updateServiceFeaturedUseCase,
    this._createServiceUseCase,
    this._updateServiceUseCase,
    this._deleteServiceUseCase,
  ) : super(const ServiceState());

  Future<void> loadServices({bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(currentPage: 1, services: []);
    }

    if (state.isLoading || (!state.hasMoreData && !refresh)) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _getServicesUseCase.call(
        page: state.currentPage,
        pageSize: 20,
        searchQuery: state.searchQuery,
        status: state.selectedStatus,
        categoryId: state.selectedCategoryId,
        sortBy: 'createdAt',
        sortDescending: true,
      );

      final newServices = refresh ? result : [...state.services, ...result];

      state = state.copyWith(
        services: newServices,
        isLoading: false,
        currentPage: state.currentPage + 1,
        hasMoreData: result.length == 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> searchServices(String query) async {
    state = state.copyWith(
      searchQuery: query.isEmpty ? null : query,
      currentPage: 1,
      services: [],
      hasMoreData: true,
    );
    await loadServices();
  }

  Future<void> filterByStatus(ServiceApprovalStatus? status) async {
    state = state.copyWith(
      selectedStatus: status,
      currentPage: 1,
      services: [],
      hasMoreData: true,
    );
    await loadServices();
  }

  Future<void> filterByCategory(String? categoryId) async {
    state = state.copyWith(
      selectedCategoryId: categoryId,
      currentPage: 1,
      services: [],
      hasMoreData: true,
    );
    await loadServices();
  }

  Future<void> loadServiceById(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final service = await _getServiceByIdUseCase.call(id);

      state = state.copyWith(selectedService: service, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<Service?> getServiceById(String id) async {
    try {
      return await _getServiceByIdUseCase.call(id);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  Future<bool> createService(ServiceRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _createServiceUseCase.call(request);

      state = state.copyWith(isLoading: false);

      // Refresh the services list
      await refreshServices();

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> updateService(String id, ServiceRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _updateServiceUseCase.call(id, request);

      state = state.copyWith(isLoading: false);

      // Refresh the services list
      await refreshServices();

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> deleteService(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _deleteServiceUseCase.call(id);

      // Remove the service from local state
      final updatedServices = state.services
          .where((service) => service.id != id)
          .toList();

      state = state.copyWith(services: updatedServices, isLoading: false);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> updateServiceStatus(String id, bool isActive) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _updateServiceStatusUseCase.call(id, isActive);

      // Update the local state
      final updatedServices = state.services.map((service) {
        if (service.id == id) {
          return service.copyWith(isActive: isActive);
        }
        return service;
      }).toList();

      state = state.copyWith(services: updatedServices, isLoading: false);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> updateServiceFeatured(String id, bool isFeatured) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _updateServiceFeaturedUseCase.call(id, isFeatured);

      // Update the local state
      final updatedServices = state.services.map((service) {
        if (service.id == id) {
          return service.copyWith(isFeatured: isFeatured);
        }
        return service;
      }).toList();

      state = state.copyWith(services: updatedServices, isLoading: false);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> refreshServices() async {
    await loadServices(refresh: true);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSelectedService() {
    state = state.copyWith(selectedService: null);
  }
}
