import 'package:freezed_annotation/freezed_annotation.dart';

part 'service.freezed.dart';
part 'service.g.dart';

@freezed
abstract class Service with _$Service {
  const factory Service({
    required String id,
    required String providerId,
    required String title,
    required String description,
    required String categoryId,
    required String subcategoryId,
    required ServiceApprovalStatus approvalStatus,
    String? approvedById,
    DateTime? approvalDate,
    String? rejectionReason,
    required double basePrice,
    required ServicePricingType pricingType,
    List<ServicePackage>? packages,
    List<String>? tags,
    List<String>? images,
    List<ServiceRequirement>? requirements,
    required Duration deliveryTime,
    bool? isActive,
    bool? isFeatured,
    double? averageRating,
    int? totalReviews,
    int? totalOrders,
    required DateTime createdAt,
    required DateTime updatedAt,
    // Provider info for display
    String? providerName,
    String? providerEmail,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
}

enum ServiceApprovalStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('InReview')
  inReview,
  @JsonValue('Approved')
  approved,
  @JsonValue('Rejected')
  rejected,
  @JsonValue('RequiresChanges')
  requiresChanges,
}

enum ServicePricingType {
  @JsonValue('Fixed')
  fixed,
  @JsonValue('Hourly')
  hourly,
  @JsonValue('Custom')
  custom,
}

@freezed
abstract class ServiceListItem with _$ServiceListItem {
  const factory ServiceListItem({
    required String id,
    required String title,
    required String categoryName,
    required String providerName,
    required ServiceApprovalStatus approvalStatus,
    required double basePrice,
    required DateTime createdAt,
    DateTime? approvalDate,
    double? averageRating,
    int? totalOrders,
    bool? isActive,
    bool? isFeatured,
  }) = _ServiceListItem;

  factory ServiceListItem.fromJson(Map<String, dynamic> json) =>
      _$ServiceListItemFromJson(json);
}

@freezed
abstract class ServiceRequest with _$ServiceRequest {
  const factory ServiceRequest({
    required String title,
    required String description,
    required String categoryId,
    required String subcategoryId,
    required double basePrice,
    required ServicePricingType pricingType,
    List<ServicePackage>? packages,
    List<String>? tags,
    List<String>? images,
    List<ServiceRequirement>? requirements,
    required Duration deliveryTime,
    bool? isFeatured,
  }) = _ServiceRequest;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);
}

@freezed
abstract class ApproveServiceRequest with _$ApproveServiceRequest {
  const factory ApproveServiceRequest({
    required String serviceId,
    required bool isApproved,
    String? rejectionReason,
    String? notes,
    required String approvedByAdminId,
    bool? isFeatured,
  }) = _ApproveServiceRequest;

  factory ApproveServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ApproveServiceRequestFromJson(json);
}

@freezed
abstract class ServicePackage with _$ServicePackage {
  const factory ServicePackage({
    required String name,
    required String description,
    required double price,
    required Duration deliveryTime,
    List<String>? features,
  }) = _ServicePackage;

  factory ServicePackage.fromJson(Map<String, dynamic> json) =>
      _$ServicePackageFromJson(json);
}

@freezed
abstract class ServiceRequirement with _$ServiceRequirement {
  const factory ServiceRequirement({
    required String question,
    required ServiceRequirementType type,
    required bool isRequired,
    List<String>? options,
  }) = _ServiceRequirement;

  factory ServiceRequirement.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequirementFromJson(json);
}

enum ServiceRequirementType {
  @JsonValue('Text')
  text,
  @JsonValue('Number')
  number,
  @JsonValue('MultipleChoice')
  multipleChoice,
  @JsonValue('File')
  file,
}

// Service Category models
@freezed
abstract class ServiceCategory with _$ServiceCategory {
  const factory ServiceCategory({
    required String id,
    required String name,
    required String description,
    String? icon,
    String? imageUrl,
    required int sortOrder,
    required bool isActive,
    List<ServiceSubcategory>? subcategories,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ServiceCategory;

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryFromJson(json);
}

@freezed
abstract class ServiceSubcategory with _$ServiceSubcategory {
  const factory ServiceSubcategory({
    required String id,
    required String categoryId,
    required String name,
    required String description,
    required int sortOrder,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ServiceSubcategory;

  factory ServiceSubcategory.fromJson(Map<String, dynamic> json) =>
      _$ServiceSubcategoryFromJson(json);
}

@freezed
abstract class ServiceCategoryRequest with _$ServiceCategoryRequest {
  const factory ServiceCategoryRequest({
    required String name,
    required String description,
    String? icon,
    String? imageUrl,
    required int sortOrder,
    required bool isActive,
  }) = _ServiceCategoryRequest;

  factory ServiceCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryRequestFromJson(json);
}

@freezed
abstract class ServiceSubcategoryRequest with _$ServiceSubcategoryRequest {
  const factory ServiceSubcategoryRequest({
    required String categoryId,
    required String name,
    required String description,
    required int sortOrder,
    required bool isActive,
  }) = _ServiceSubcategoryRequest;

  factory ServiceSubcategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceSubcategoryRequestFromJson(json);
}
