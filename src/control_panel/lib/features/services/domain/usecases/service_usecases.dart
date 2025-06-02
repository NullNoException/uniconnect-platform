import '../models/service.dart';
import '../repositories/service_repository.dart';

// UC-3.2.1: Service Listing Approval
class ApproveServiceUseCase {
  final ServiceRepository _repository;

  ApproveServiceUseCase(this._repository);

  Future<Service> call(ApproveServiceRequest request) async {
    return await _repository.approveService(request);
  }
}

class GetServicesForApprovalUseCase {
  final ServiceRepository _repository;

  GetServicesForApprovalUseCase(this._repository);

  Future<List<ServiceListItem>> call({
    required int page,
    required int pageSize,
  }) async {
    return await _repository.getServicesForApproval(
      page: page,
      pageSize: pageSize,
    );
  }
}

class GetServiceApprovalQueueCountUseCase {
  final ServiceRepository _repository;

  GetServiceApprovalQueueCountUseCase(this._repository);

  Future<int> call() async {
    return await _repository.getApprovalQueueCount();
  }
}

// UC-3.2.2: Service Category Management
class GetServiceCategoriesUseCase {
  final ServiceRepository _repository;

  GetServiceCategoriesUseCase(this._repository);

  Future<List<ServiceCategory>> call({bool? isActive}) async {
    return await _repository.getCategories(isActive: isActive);
  }
}

class CreateServiceCategoryUseCase {
  final ServiceRepository _repository;

  CreateServiceCategoryUseCase(this._repository);

  Future<ServiceCategory> call(ServiceCategoryRequest request) async {
    return await _repository.createCategory(request);
  }
}

class UpdateServiceCategoryUseCase {
  final ServiceRepository _repository;

  UpdateServiceCategoryUseCase(this._repository);

  Future<ServiceCategory> call(
    String id,
    ServiceCategoryRequest request,
  ) async {
    return await _repository.updateCategory(id, request);
  }
}

class DeleteServiceCategoryUseCase {
  final ServiceRepository _repository;

  DeleteServiceCategoryUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteCategory(id);
  }
}

class GetServiceSubcategoriesUseCase {
  final ServiceRepository _repository;

  GetServiceSubcategoriesUseCase(this._repository);

  Future<List<ServiceSubcategory>> call(String categoryId) async {
    return await _repository.getSubcategories(categoryId);
  }
}

class CreateServiceSubcategoryUseCase {
  final ServiceRepository _repository;

  CreateServiceSubcategoryUseCase(this._repository);

  Future<ServiceSubcategory> call(ServiceSubcategoryRequest request) async {
    return await _repository.createSubcategory(request);
  }
}

class UpdateServiceSubcategoryUseCase {
  final ServiceRepository _repository;

  UpdateServiceSubcategoryUseCase(this._repository);

  Future<ServiceSubcategory> call(
    String id,
    ServiceSubcategoryRequest request,
  ) async {
    return await _repository.updateSubcategory(id, request);
  }
}

class DeleteServiceSubcategoryUseCase {
  final ServiceRepository _repository;

  DeleteServiceSubcategoryUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteSubcategory(id);
  }
}

// Supporting use cases for general service management
class GetServicesUseCase {
  final ServiceRepository _repository;

  GetServicesUseCase(this._repository);

  Future<List<ServiceListItem>> call({
    required int page,
    required int pageSize,
    String? searchQuery,
    ServiceApprovalStatus? status,
    String? categoryId,
    String? sortBy,
    bool? sortDescending,
  }) async {
    return await _repository.getServices(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      status: status,
      categoryId: categoryId,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }
}

class GetServiceByIdUseCase {
  final ServiceRepository _repository;

  GetServiceByIdUseCase(this._repository);

  Future<Service> call(String id) async {
    return await _repository.getServiceById(id);
  }
}

class UpdateServiceStatusUseCase {
  final ServiceRepository _repository;

  UpdateServiceStatusUseCase(this._repository);

  Future<Service> call(String id, bool isActive) async {
    return await _repository.updateServiceStatus(id, isActive);
  }
}

class UpdateServiceFeaturedUseCase {
  final ServiceRepository _repository;

  UpdateServiceFeaturedUseCase(this._repository);

  Future<Service> call(String id, bool isFeatured) async {
    return await _repository.updateServiceFeatured(id, isFeatured);
  }
}

class CreateServiceUseCase {
  final ServiceRepository _repository;

  CreateServiceUseCase(this._repository);

  Future<Service> call(ServiceRequest request) async {
    return await _repository.createService(request);
  }
}

class UpdateServiceUseCase {
  final ServiceRepository _repository;

  UpdateServiceUseCase(this._repository);

  Future<Service> call(String id, ServiceRequest request) async {
    return await _repository.updateService(id, request);
  }
}

class DeleteServiceUseCase {
  final ServiceRepository _repository;

  DeleteServiceUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteService(id);
  }
}
