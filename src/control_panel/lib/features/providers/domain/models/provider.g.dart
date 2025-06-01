// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Provider _$ProviderFromJson(Map<String, dynamic> json) => _Provider(
  id: json['id'] as String,
  userId: json['userId'] as String,
  companyName: json['companyName'] as String,
  registrationNumber: json['registrationNumber'] as String?,
  verificationStatus: $enumDecode(
    _$ProviderVerificationStatusEnumMap,
    json['verificationStatus'],
  ),
  verifiedById: json['verifiedById'] as String?,
  verificationDate: json['verificationDate'] == null
      ? null
      : DateTime.parse(json['verificationDate'] as String),
  companyLogoUrl: json['companyLogoUrl'] as String?,
  companyWebsite: json['companyWebsite'] as String?,
  yearsInBusiness: (json['yearsInBusiness'] as num?)?.toInt(),
  subscriptionPlanId: json['subscriptionPlanId'] as String?,
  subscriptionStartDate: json['subscriptionStartDate'] == null
      ? null
      : DateTime.parse(json['subscriptionStartDate'] as String),
  subscriptionEndDate: json['subscriptionEndDate'] == null
      ? null
      : DateTime.parse(json['subscriptionEndDate'] as String),
  billingAddressId: json['billingAddressId'] as String?,
  taxIdentificationNumber: json['taxIdentificationNumber'] as String?,
  documents: (json['documents'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  notes: json['notes'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  isActive: json['isActive'] as bool?,
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  totalServices: (json['totalServices'] as num?)?.toInt(),
  completedOrders: (json['completedOrders'] as num?)?.toInt(),
  completionRate: (json['completionRate'] as num?)?.toDouble(),
  responseTime: (json['responseTime'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ProviderToJson(_Provider instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'companyName': instance.companyName,
  'registrationNumber': instance.registrationNumber,
  'verificationStatus':
      _$ProviderVerificationStatusEnumMap[instance.verificationStatus]!,
  'verifiedById': instance.verifiedById,
  'verificationDate': instance.verificationDate?.toIso8601String(),
  'companyLogoUrl': instance.companyLogoUrl,
  'companyWebsite': instance.companyWebsite,
  'yearsInBusiness': instance.yearsInBusiness,
  'subscriptionPlanId': instance.subscriptionPlanId,
  'subscriptionStartDate': instance.subscriptionStartDate?.toIso8601String(),
  'subscriptionEndDate': instance.subscriptionEndDate?.toIso8601String(),
  'billingAddressId': instance.billingAddressId,
  'taxIdentificationNumber': instance.taxIdentificationNumber,
  'documents': instance.documents,
  'notes': instance.notes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phoneNumber': instance.phoneNumber,
  'isActive': instance.isActive,
  'averageRating': instance.averageRating,
  'totalServices': instance.totalServices,
  'completedOrders': instance.completedOrders,
  'completionRate': instance.completionRate,
  'responseTime': instance.responseTime,
};

const _$ProviderVerificationStatusEnumMap = {
  ProviderVerificationStatus.pending: 'Pending',
  ProviderVerificationStatus.inReview: 'InReview',
  ProviderVerificationStatus.verified: 'Verified',
  ProviderVerificationStatus.rejected: 'Rejected',
};

_ProviderListItem _$ProviderListItemFromJson(Map<String, dynamic> json) =>
    _ProviderListItem(
      id: json['id'] as String,
      companyName: json['companyName'] as String,
      email: json['email'] as String,
      verificationStatus: $enumDecode(
        _$ProviderVerificationStatusEnumMap,
        json['verificationStatus'],
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      verificationDate: json['verificationDate'] == null
          ? null
          : DateTime.parse(json['verificationDate'] as String),
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      totalServices: (json['totalServices'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$ProviderListItemToJson(_ProviderListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'email': instance.email,
      'verificationStatus':
          _$ProviderVerificationStatusEnumMap[instance.verificationStatus]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'verificationDate': instance.verificationDate?.toIso8601String(),
      'averageRating': instance.averageRating,
      'totalServices': instance.totalServices,
      'isActive': instance.isActive,
    };

_ProviderRequest _$ProviderRequestFromJson(Map<String, dynamic> json) =>
    _ProviderRequest(
      companyName: json['companyName'] as String,
      registrationNumber: json['registrationNumber'] as String?,
      companyWebsite: json['companyWebsite'] as String?,
      yearsInBusiness: (json['yearsInBusiness'] as num?)?.toInt(),
      taxIdentificationNumber: json['taxIdentificationNumber'] as String?,
      notes: json['notes'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$ProviderRequestToJson(_ProviderRequest instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'registrationNumber': instance.registrationNumber,
      'companyWebsite': instance.companyWebsite,
      'yearsInBusiness': instance.yearsInBusiness,
      'taxIdentificationNumber': instance.taxIdentificationNumber,
      'notes': instance.notes,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
    };

_VerifyProviderRequest _$VerifyProviderRequestFromJson(
  Map<String, dynamic> json,
) => _VerifyProviderRequest(
  providerId: json['providerId'] as String,
  isApproved: json['isApproved'] as bool,
  comments: json['comments'] as String?,
  verifiedByAdminId: json['verifiedByAdminId'] as String,
);

Map<String, dynamic> _$VerifyProviderRequestToJson(
  _VerifyProviderRequest instance,
) => <String, dynamic>{
  'providerId': instance.providerId,
  'isApproved': instance.isApproved,
  'comments': instance.comments,
  'verifiedByAdminId': instance.verifiedByAdminId,
};

_ProviderPerformanceMetrics _$ProviderPerformanceMetricsFromJson(
  Map<String, dynamic> json,
) => _ProviderPerformanceMetrics(
  providerId: json['providerId'] as String,
  averageRating: (json['averageRating'] as num).toDouble(),
  totalServices: (json['totalServices'] as num).toInt(),
  totalOrders: (json['totalOrders'] as num).toInt(),
  completedOrders: (json['completedOrders'] as num).toInt(),
  completionRate: (json['completionRate'] as num).toDouble(),
  averageResponseTime: (json['averageResponseTime'] as num).toDouble(),
  ratingDistribution: Map<String, int>.from(json['ratingDistribution'] as Map),
  recentFeedback: (json['recentFeedback'] as List<dynamic>)
      .map((e) => CustomerFeedback.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProviderPerformanceMetricsToJson(
  _ProviderPerformanceMetrics instance,
) => <String, dynamic>{
  'providerId': instance.providerId,
  'averageRating': instance.averageRating,
  'totalServices': instance.totalServices,
  'totalOrders': instance.totalOrders,
  'completedOrders': instance.completedOrders,
  'completionRate': instance.completionRate,
  'averageResponseTime': instance.averageResponseTime,
  'ratingDistribution': instance.ratingDistribution,
  'recentFeedback': instance.recentFeedback,
};

_CustomerFeedback _$CustomerFeedbackFromJson(Map<String, dynamic> json) =>
    _CustomerFeedback(
      id: json['id'] as String,
      customerName: json['customerName'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      serviceTitle: json['serviceTitle'] as String,
    );

Map<String, dynamic> _$CustomerFeedbackToJson(_CustomerFeedback instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
      'serviceTitle': instance.serviceTitle,
    };
