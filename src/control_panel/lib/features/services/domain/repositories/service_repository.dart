import '../models/service.dart';

abstract class ServiceRepository {
  /// Get services with filtering and pagination
  Future<List<ServiceListItem>> getServices({
    required int page,
    required int pageSize,
    String? searchQuery,
    ServiceApprovalStatus? status,
    String? categoryId,
    String? sortBy,
    bool? sortDescending,
  });

  /// Get a specific service by ID
  Future<Service> getServiceById(String id);

  /// Create a new service
  Future<Service> createService(ServiceRequest request);

  /// Update an existing service
  Future<Service> updateService(String id, ServiceRequest request);

  /// Delete a service
  Future<void> deleteService(String id);

  /// Approve or reject a service (UC-3.2.1)
  Future<Service> approveService(ApproveServiceRequest request);

  /// Get services requiring approval
  Future<List<ServiceListItem>> getServicesForApproval({
    required int page,
    required int pageSize,
  });

  /// Get service approval queue count
  Future<int> getApprovalQueueCount();

  /// Update service status (active/inactive)
  Future<Service> updateServiceStatus(String id, bool isActive);

  /// Feature/unfeature a service
  Future<Service> updateServiceFeatured(String id, bool isFeatured);

  // Category Management (UC-3.2.2)

  /// Get all service categories
  Future<List<ServiceCategory>> getCategories({bool? isActive});

  /// Get a specific category by ID
  Future<ServiceCategory> getCategoryById(String id);

  /// Create a new service category
  Future<ServiceCategory> createCategory(ServiceCategoryRequest request);

  /// Update an existing service category
  Future<ServiceCategory> updateCategory(
    String id,
    ServiceCategoryRequest request,
  );

  /// Delete a service category
  Future<void> deleteCategory(String id);

  /// Get subcategories for a category
  Future<List<ServiceSubcategory>> getSubcategories(String categoryId);

  /// Create a new subcategory
  Future<ServiceSubcategory> createSubcategory(
    ServiceSubcategoryRequest request,
  );

  /// Update an existing subcategory
  Future<ServiceSubcategory> updateSubcategory(
    String id,
    ServiceSubcategoryRequest request,
  );

  /// Delete a subcategory
  Future<void> deleteSubcategory(String id);
}
