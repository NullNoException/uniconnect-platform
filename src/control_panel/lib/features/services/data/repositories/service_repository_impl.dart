import '../../domain/datasources/service_data_source.dart';
import '../../domain/models/service.dart';
import '../../domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceDataSource _dataSource;

  ServiceRepositoryImpl(this._dataSource);

  @override
  Future<List<ServiceListItem>> getServices({
    required int page,
    required int pageSize,
    String? searchQuery,
    ServiceApprovalStatus? status,
    String? categoryId,
    String? sortBy,
    bool? sortDescending,
  }) async {
    return await _dataSource.getServices(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      status: status,
      categoryId: categoryId,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }

  @override
  Future<Service> getServiceById(String id) async {
    return await _dataSource.getServiceById(id);
  }

  @override
  Future<Service> createService(ServiceRequest request) async {
    return await _dataSource.createService(request);
  }

  @override
  Future<Service> updateService(String id, ServiceRequest request) async {
    return await _dataSource.updateService(id, request);
  }

  @override
  Future<void> deleteService(String id) async {
    return await _dataSource.deleteService(id);
  }

  @override
  Future<Service> approveService(ApproveServiceRequest request) async {
    return await _dataSource.approveService(request);
  }

  @override
  Future<List<ServiceListItem>> getServicesForApproval({
    required int page,
    required int pageSize,
  }) async {
    return await _dataSource.getServicesForApproval(
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<int> getApprovalQueueCount() async {
    return await _dataSource.getApprovalQueueCount();
  }

  @override
  Future<Service> updateServiceStatus(String id, bool isActive) async {
    return await _dataSource.updateServiceStatus(id, isActive);
  }

  @override
  Future<Service> updateServiceFeatured(String id, bool isFeatured) async {
    return await _dataSource.updateServiceFeatured(id, isFeatured);
  }

  @override
  Future<List<ServiceCategory>> getCategories({bool? isActive}) async {
    return await _dataSource.getCategories(isActive: isActive);
  }

  @override
  Future<ServiceCategory> getCategoryById(String id) async {
    return await _dataSource.getCategoryById(id);
  }

  @override
  Future<ServiceCategory> createCategory(ServiceCategoryRequest request) async {
    return await _dataSource.createCategory(request);
  }

  @override
  Future<ServiceCategory> updateCategory(String id, ServiceCategoryRequest request) async {
    return await _dataSource.updateCategory(id, request);
  }

  @override
  Future<void> deleteCategory(String id) async {
    return await _dataSource.deleteCategory(id);
  }

  @override
  Future<List<ServiceSubcategory>> getSubcategories(String categoryId) async {
    return await _dataSource.getSubcategories(categoryId);
  }

  @override
  Future<ServiceSubcategory> createSubcategory(ServiceSubcategoryRequest request) async {
    return await _dataSource.createSubcategory(request);
  }

  @override
  Future<ServiceSubcategory> updateSubcategory(String id, ServiceSubcategoryRequest request) async {
    return await _dataSource.updateSubcategory(id, request);
  }

  @override
  Future<void> deleteSubcategory(String id) async {
    return await _dataSource.deleteSubcategory(id);
  }
}
