// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Service _$ServiceFromJson(Map<String, dynamic> json) => _Service(
  id: json['id'] as String,
  providerId: json['providerId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  categoryId: json['categoryId'] as String,
  subcategoryId: json['subcategoryId'] as String,
  approvalStatus: $enumDecode(
    _$ServiceApprovalStatusEnumMap,
    json['approvalStatus'],
  ),
  approvedById: json['approvedById'] as String?,
  approvalDate: json['approvalDate'] == null
      ? null
      : DateTime.parse(json['approvalDate'] as String),
  rejectionReason: json['rejectionReason'] as String?,
  basePrice: (json['basePrice'] as num).toDouble(),
  pricingType: $enumDecode(_$ServicePricingTypeEnumMap, json['pricingType']),
  packages: (json['packages'] as List<dynamic>?)
      ?.map((e) => ServicePackage.fromJson(e as Map<String, dynamic>))
      .toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  requirements: (json['requirements'] as List<dynamic>?)
      ?.map((e) => ServiceRequirement.fromJson(e as Map<String, dynamic>))
      .toList(),
  deliveryTime: Duration(microseconds: (json['deliveryTime'] as num).toInt()),
  isActive: json['isActive'] as bool?,
  isFeatured: json['isFeatured'] as bool?,
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  totalReviews: (json['totalReviews'] as num?)?.toInt(),
  totalOrders: (json['totalOrders'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  providerName: json['providerName'] as String?,
  providerEmail: json['providerEmail'] as String?,
);

Map<String, dynamic> _$ServiceToJson(_Service instance) => <String, dynamic>{
  'id': instance.id,
  'providerId': instance.providerId,
  'title': instance.title,
  'description': instance.description,
  'categoryId': instance.categoryId,
  'subcategoryId': instance.subcategoryId,
  'approvalStatus': _$ServiceApprovalStatusEnumMap[instance.approvalStatus]!,
  'approvedById': instance.approvedById,
  'approvalDate': instance.approvalDate?.toIso8601String(),
  'rejectionReason': instance.rejectionReason,
  'basePrice': instance.basePrice,
  'pricingType': _$ServicePricingTypeEnumMap[instance.pricingType]!,
  'packages': instance.packages,
  'tags': instance.tags,
  'images': instance.images,
  'requirements': instance.requirements,
  'deliveryTime': instance.deliveryTime.inMicroseconds,
  'isActive': instance.isActive,
  'isFeatured': instance.isFeatured,
  'averageRating': instance.averageRating,
  'totalReviews': instance.totalReviews,
  'totalOrders': instance.totalOrders,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'providerName': instance.providerName,
  'providerEmail': instance.providerEmail,
};

const _$ServiceApprovalStatusEnumMap = {
  ServiceApprovalStatus.pending: 'Pending',
  ServiceApprovalStatus.inReview: 'InReview',
  ServiceApprovalStatus.approved: 'Approved',
  ServiceApprovalStatus.rejected: 'Rejected',
  ServiceApprovalStatus.requiresChanges: 'RequiresChanges',
};

const _$ServicePricingTypeEnumMap = {
  ServicePricingType.fixed: 'Fixed',
  ServicePricingType.hourly: 'Hourly',
  ServicePricingType.custom: 'Custom',
};

_ServiceListItem _$ServiceListItemFromJson(Map<String, dynamic> json) =>
    _ServiceListItem(
      id: json['id'] as String,
      title: json['title'] as String,
      categoryName: json['categoryName'] as String,
      providerName: json['providerName'] as String,
      approvalStatus: $enumDecode(
        _$ServiceApprovalStatusEnumMap,
        json['approvalStatus'],
      ),
      basePrice: (json['basePrice'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      approvalDate: json['approvalDate'] == null
          ? null
          : DateTime.parse(json['approvalDate'] as String),
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      totalOrders: (json['totalOrders'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      isFeatured: json['isFeatured'] as bool?,
    );

Map<String, dynamic> _$ServiceListItemToJson(
  _ServiceListItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'categoryName': instance.categoryName,
  'providerName': instance.providerName,
  'approvalStatus': _$ServiceApprovalStatusEnumMap[instance.approvalStatus]!,
  'basePrice': instance.basePrice,
  'createdAt': instance.createdAt.toIso8601String(),
  'approvalDate': instance.approvalDate?.toIso8601String(),
  'averageRating': instance.averageRating,
  'totalOrders': instance.totalOrders,
  'isActive': instance.isActive,
  'isFeatured': instance.isFeatured,
};

_ServiceRequest _$ServiceRequestFromJson(
  Map<String, dynamic> json,
) => _ServiceRequest(
  title: json['title'] as String,
  description: json['description'] as String,
  categoryId: json['categoryId'] as String,
  subcategoryId: json['subcategoryId'] as String,
  basePrice: (json['basePrice'] as num).toDouble(),
  pricingType: $enumDecode(_$ServicePricingTypeEnumMap, json['pricingType']),
  packages: (json['packages'] as List<dynamic>?)
      ?.map((e) => ServicePackage.fromJson(e as Map<String, dynamic>))
      .toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  requirements: (json['requirements'] as List<dynamic>?)
      ?.map((e) => ServiceRequirement.fromJson(e as Map<String, dynamic>))
      .toList(),
  deliveryTime: Duration(microseconds: (json['deliveryTime'] as num).toInt()),
  isFeatured: json['isFeatured'] as bool?,
);

Map<String, dynamic> _$ServiceRequestToJson(_ServiceRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'subcategoryId': instance.subcategoryId,
      'basePrice': instance.basePrice,
      'pricingType': _$ServicePricingTypeEnumMap[instance.pricingType]!,
      'packages': instance.packages,
      'tags': instance.tags,
      'images': instance.images,
      'requirements': instance.requirements,
      'deliveryTime': instance.deliveryTime.inMicroseconds,
      'isFeatured': instance.isFeatured,
    };

_ApproveServiceRequest _$ApproveServiceRequestFromJson(
  Map<String, dynamic> json,
) => _ApproveServiceRequest(
  serviceId: json['serviceId'] as String,
  isApproved: json['isApproved'] as bool,
  rejectionReason: json['rejectionReason'] as String?,
  notes: json['notes'] as String?,
  approvedByAdminId: json['approvedByAdminId'] as String,
  isFeatured: json['isFeatured'] as bool?,
);

Map<String, dynamic> _$ApproveServiceRequestToJson(
  _ApproveServiceRequest instance,
) => <String, dynamic>{
  'serviceId': instance.serviceId,
  'isApproved': instance.isApproved,
  'rejectionReason': instance.rejectionReason,
  'notes': instance.notes,
  'approvedByAdminId': instance.approvedByAdminId,
  'isFeatured': instance.isFeatured,
};

_ServicePackage _$ServicePackageFromJson(Map<String, dynamic> json) =>
    _ServicePackage(
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      deliveryTime: Duration(
        microseconds: (json['deliveryTime'] as num).toInt(),
      ),
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ServicePackageToJson(_ServicePackage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'deliveryTime': instance.deliveryTime.inMicroseconds,
      'features': instance.features,
    };

_ServiceRequirement _$ServiceRequirementFromJson(Map<String, dynamic> json) =>
    _ServiceRequirement(
      question: json['question'] as String,
      type: $enumDecode(_$ServiceRequirementTypeEnumMap, json['type']),
      isRequired: json['isRequired'] as bool,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ServiceRequirementToJson(_ServiceRequirement instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': _$ServiceRequirementTypeEnumMap[instance.type]!,
      'isRequired': instance.isRequired,
      'options': instance.options,
    };

const _$ServiceRequirementTypeEnumMap = {
  ServiceRequirementType.text: 'Text',
  ServiceRequirementType.number: 'Number',
  ServiceRequirementType.multipleChoice: 'MultipleChoice',
  ServiceRequirementType.file: 'File',
};

_ServiceCategory _$ServiceCategoryFromJson(Map<String, dynamic> json) =>
    _ServiceCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sortOrder: (json['sortOrder'] as num).toInt(),
      isActive: json['isActive'] as bool,
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => ServiceSubcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ServiceCategoryToJson(_ServiceCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'imageUrl': instance.imageUrl,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'subcategories': instance.subcategories,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_ServiceSubcategory _$ServiceSubcategoryFromJson(Map<String, dynamic> json) =>
    _ServiceSubcategory(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      sortOrder: (json['sortOrder'] as num).toInt(),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ServiceSubcategoryToJson(_ServiceSubcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'description': instance.description,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_ServiceCategoryRequest _$ServiceCategoryRequestFromJson(
  Map<String, dynamic> json,
) => _ServiceCategoryRequest(
  name: json['name'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String?,
  imageUrl: json['imageUrl'] as String?,
  sortOrder: (json['sortOrder'] as num).toInt(),
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$ServiceCategoryRequestToJson(
  _ServiceCategoryRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'icon': instance.icon,
  'imageUrl': instance.imageUrl,
  'sortOrder': instance.sortOrder,
  'isActive': instance.isActive,
};

_ServiceSubcategoryRequest _$ServiceSubcategoryRequestFromJson(
  Map<String, dynamic> json,
) => _ServiceSubcategoryRequest(
  categoryId: json['categoryId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  sortOrder: (json['sortOrder'] as num).toInt(),
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$ServiceSubcategoryRequestToJson(
  _ServiceSubcategoryRequest instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'name': instance.name,
  'description': instance.description,
  'sortOrder': instance.sortOrder,
  'isActive': instance.isActive,
};
