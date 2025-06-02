// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Service {

 String get id; String get providerId; String get title; String get description; String get categoryId; String get subcategoryId; ServiceApprovalStatus get approvalStatus; String? get approvedById; DateTime? get approvalDate; String? get rejectionReason; double get basePrice; ServicePricingType get pricingType; List<ServicePackage>? get packages; List<String>? get tags; List<String>? get images; List<ServiceRequirement>? get requirements; Duration get deliveryTime; bool? get isActive; bool? get isFeatured; double? get averageRating; int? get totalReviews; int? get totalOrders; DateTime get createdAt; DateTime get updatedAt;// Provider info for display
 String? get providerName; String? get providerEmail;
/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCopyWith<Service> get copyWith => _$ServiceCopyWithImpl<Service>(this as Service, _$identity);

  /// Serializes this Service to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Service&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.approvedById, approvedById) || other.approvedById == approvedById)&&(identical(other.approvalDate, approvalDate) || other.approvalDate == approvalDate)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.pricingType, pricingType) || other.pricingType == pricingType)&&const DeepCollectionEquality().equals(other.packages, packages)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerEmail, providerEmail) || other.providerEmail == providerEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,providerId,title,description,categoryId,subcategoryId,approvalStatus,approvedById,approvalDate,rejectionReason,basePrice,pricingType,const DeepCollectionEquality().hash(packages),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(requirements),deliveryTime,isActive,isFeatured,averageRating,totalReviews,totalOrders,createdAt,updatedAt,providerName,providerEmail]);

@override
String toString() {
  return 'Service(id: $id, providerId: $providerId, title: $title, description: $description, categoryId: $categoryId, subcategoryId: $subcategoryId, approvalStatus: $approvalStatus, approvedById: $approvedById, approvalDate: $approvalDate, rejectionReason: $rejectionReason, basePrice: $basePrice, pricingType: $pricingType, packages: $packages, tags: $tags, images: $images, requirements: $requirements, deliveryTime: $deliveryTime, isActive: $isActive, isFeatured: $isFeatured, averageRating: $averageRating, totalReviews: $totalReviews, totalOrders: $totalOrders, createdAt: $createdAt, updatedAt: $updatedAt, providerName: $providerName, providerEmail: $providerEmail)';
}


}

/// @nodoc
abstract mixin class $ServiceCopyWith<$Res>  {
  factory $ServiceCopyWith(Service value, $Res Function(Service) _then) = _$ServiceCopyWithImpl;
@useResult
$Res call({
 String id, String providerId, String title, String description, String categoryId, String subcategoryId, ServiceApprovalStatus approvalStatus, String? approvedById, DateTime? approvalDate, String? rejectionReason, double basePrice, ServicePricingType pricingType, List<ServicePackage>? packages, List<String>? tags, List<String>? images, List<ServiceRequirement>? requirements, Duration deliveryTime, bool? isActive, bool? isFeatured, double? averageRating, int? totalReviews, int? totalOrders, DateTime createdAt, DateTime updatedAt, String? providerName, String? providerEmail
});




}
/// @nodoc
class _$ServiceCopyWithImpl<$Res>
    implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._self, this._then);

  final Service _self;
  final $Res Function(Service) _then;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? providerId = null,Object? title = null,Object? description = null,Object? categoryId = null,Object? subcategoryId = null,Object? approvalStatus = null,Object? approvedById = freezed,Object? approvalDate = freezed,Object? rejectionReason = freezed,Object? basePrice = null,Object? pricingType = null,Object? packages = freezed,Object? tags = freezed,Object? images = freezed,Object? requirements = freezed,Object? deliveryTime = null,Object? isActive = freezed,Object? isFeatured = freezed,Object? averageRating = freezed,Object? totalReviews = freezed,Object? totalOrders = freezed,Object? createdAt = null,Object? updatedAt = null,Object? providerName = freezed,Object? providerEmail = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: null == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String,approvalStatus: null == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as ServiceApprovalStatus,approvedById: freezed == approvedById ? _self.approvedById : approvedById // ignore: cast_nullable_to_non_nullable
as String?,approvalDate: freezed == approvalDate ? _self.approvalDate : approvalDate // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,pricingType: null == pricingType ? _self.pricingType : pricingType // ignore: cast_nullable_to_non_nullable
as ServicePricingType,packages: freezed == packages ? _self.packages : packages // ignore: cast_nullable_to_non_nullable
as List<ServicePackage>?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<ServiceRequirement>?,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as Duration,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,totalReviews: freezed == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int?,totalOrders: freezed == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,providerEmail: freezed == providerEmail ? _self.providerEmail : providerEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Service implements Service {
  const _Service({required this.id, required this.providerId, required this.title, required this.description, required this.categoryId, required this.subcategoryId, required this.approvalStatus, this.approvedById, this.approvalDate, this.rejectionReason, required this.basePrice, required this.pricingType, final  List<ServicePackage>? packages, final  List<String>? tags, final  List<String>? images, final  List<ServiceRequirement>? requirements, required this.deliveryTime, this.isActive, this.isFeatured, this.averageRating, this.totalReviews, this.totalOrders, required this.createdAt, required this.updatedAt, this.providerName, this.providerEmail}): _packages = packages,_tags = tags,_images = images,_requirements = requirements;
  factory _Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

@override final  String id;
@override final  String providerId;
@override final  String title;
@override final  String description;
@override final  String categoryId;
@override final  String subcategoryId;
@override final  ServiceApprovalStatus approvalStatus;
@override final  String? approvedById;
@override final  DateTime? approvalDate;
@override final  String? rejectionReason;
@override final  double basePrice;
@override final  ServicePricingType pricingType;
 final  List<ServicePackage>? _packages;
@override List<ServicePackage>? get packages {
  final value = _packages;
  if (value == null) return null;
  if (_packages is EqualUnmodifiableListView) return _packages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _images;
@override List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ServiceRequirement>? _requirements;
@override List<ServiceRequirement>? get requirements {
  final value = _requirements;
  if (value == null) return null;
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Duration deliveryTime;
@override final  bool? isActive;
@override final  bool? isFeatured;
@override final  double? averageRating;
@override final  int? totalReviews;
@override final  int? totalOrders;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
// Provider info for display
@override final  String? providerName;
@override final  String? providerEmail;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCopyWith<_Service> get copyWith => __$ServiceCopyWithImpl<_Service>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Service&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.approvedById, approvedById) || other.approvedById == approvedById)&&(identical(other.approvalDate, approvalDate) || other.approvalDate == approvalDate)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.pricingType, pricingType) || other.pricingType == pricingType)&&const DeepCollectionEquality().equals(other._packages, _packages)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerEmail, providerEmail) || other.providerEmail == providerEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,providerId,title,description,categoryId,subcategoryId,approvalStatus,approvedById,approvalDate,rejectionReason,basePrice,pricingType,const DeepCollectionEquality().hash(_packages),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_requirements),deliveryTime,isActive,isFeatured,averageRating,totalReviews,totalOrders,createdAt,updatedAt,providerName,providerEmail]);

@override
String toString() {
  return 'Service(id: $id, providerId: $providerId, title: $title, description: $description, categoryId: $categoryId, subcategoryId: $subcategoryId, approvalStatus: $approvalStatus, approvedById: $approvedById, approvalDate: $approvalDate, rejectionReason: $rejectionReason, basePrice: $basePrice, pricingType: $pricingType, packages: $packages, tags: $tags, images: $images, requirements: $requirements, deliveryTime: $deliveryTime, isActive: $isActive, isFeatured: $isFeatured, averageRating: $averageRating, totalReviews: $totalReviews, totalOrders: $totalOrders, createdAt: $createdAt, updatedAt: $updatedAt, providerName: $providerName, providerEmail: $providerEmail)';
}


}

/// @nodoc
abstract mixin class _$ServiceCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$ServiceCopyWith(_Service value, $Res Function(_Service) _then) = __$ServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String providerId, String title, String description, String categoryId, String subcategoryId, ServiceApprovalStatus approvalStatus, String? approvedById, DateTime? approvalDate, String? rejectionReason, double basePrice, ServicePricingType pricingType, List<ServicePackage>? packages, List<String>? tags, List<String>? images, List<ServiceRequirement>? requirements, Duration deliveryTime, bool? isActive, bool? isFeatured, double? averageRating, int? totalReviews, int? totalOrders, DateTime createdAt, DateTime updatedAt, String? providerName, String? providerEmail
});




}
/// @nodoc
class __$ServiceCopyWithImpl<$Res>
    implements _$ServiceCopyWith<$Res> {
  __$ServiceCopyWithImpl(this._self, this._then);

  final _Service _self;
  final $Res Function(_Service) _then;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? providerId = null,Object? title = null,Object? description = null,Object? categoryId = null,Object? subcategoryId = null,Object? approvalStatus = null,Object? approvedById = freezed,Object? approvalDate = freezed,Object? rejectionReason = freezed,Object? basePrice = null,Object? pricingType = null,Object? packages = freezed,Object? tags = freezed,Object? images = freezed,Object? requirements = freezed,Object? deliveryTime = null,Object? isActive = freezed,Object? isFeatured = freezed,Object? averageRating = freezed,Object? totalReviews = freezed,Object? totalOrders = freezed,Object? createdAt = null,Object? updatedAt = null,Object? providerName = freezed,Object? providerEmail = freezed,}) {
  return _then(_Service(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: null == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String,approvalStatus: null == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as ServiceApprovalStatus,approvedById: freezed == approvedById ? _self.approvedById : approvedById // ignore: cast_nullable_to_non_nullable
as String?,approvalDate: freezed == approvalDate ? _self.approvalDate : approvalDate // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,pricingType: null == pricingType ? _self.pricingType : pricingType // ignore: cast_nullable_to_non_nullable
as ServicePricingType,packages: freezed == packages ? _self._packages : packages // ignore: cast_nullable_to_non_nullable
as List<ServicePackage>?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,requirements: freezed == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<ServiceRequirement>?,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as Duration,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,totalReviews: freezed == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int?,totalOrders: freezed == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,providerEmail: freezed == providerEmail ? _self.providerEmail : providerEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ServiceListItem {

 String get id; String get title; String get categoryName; String get providerName; ServiceApprovalStatus get approvalStatus; double get basePrice; DateTime get createdAt; DateTime? get approvalDate; double? get averageRating; int? get totalOrders; bool? get isActive; bool? get isFeatured;
/// Create a copy of ServiceListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceListItemCopyWith<ServiceListItem> get copyWith => _$ServiceListItemCopyWithImpl<ServiceListItem>(this as ServiceListItem, _$identity);

  /// Serializes this ServiceListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.approvalDate, approvalDate) || other.approvalDate == approvalDate)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,categoryName,providerName,approvalStatus,basePrice,createdAt,approvalDate,averageRating,totalOrders,isActive,isFeatured);

@override
String toString() {
  return 'ServiceListItem(id: $id, title: $title, categoryName: $categoryName, providerName: $providerName, approvalStatus: $approvalStatus, basePrice: $basePrice, createdAt: $createdAt, approvalDate: $approvalDate, averageRating: $averageRating, totalOrders: $totalOrders, isActive: $isActive, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $ServiceListItemCopyWith<$Res>  {
  factory $ServiceListItemCopyWith(ServiceListItem value, $Res Function(ServiceListItem) _then) = _$ServiceListItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String categoryName, String providerName, ServiceApprovalStatus approvalStatus, double basePrice, DateTime createdAt, DateTime? approvalDate, double? averageRating, int? totalOrders, bool? isActive, bool? isFeatured
});




}
/// @nodoc
class _$ServiceListItemCopyWithImpl<$Res>
    implements $ServiceListItemCopyWith<$Res> {
  _$ServiceListItemCopyWithImpl(this._self, this._then);

  final ServiceListItem _self;
  final $Res Function(ServiceListItem) _then;

/// Create a copy of ServiceListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? categoryName = null,Object? providerName = null,Object? approvalStatus = null,Object? basePrice = null,Object? createdAt = null,Object? approvalDate = freezed,Object? averageRating = freezed,Object? totalOrders = freezed,Object? isActive = freezed,Object? isFeatured = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,approvalStatus: null == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as ServiceApprovalStatus,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,approvalDate: freezed == approvalDate ? _self.approvalDate : approvalDate // ignore: cast_nullable_to_non_nullable
as DateTime?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,totalOrders: freezed == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceListItem implements ServiceListItem {
  const _ServiceListItem({required this.id, required this.title, required this.categoryName, required this.providerName, required this.approvalStatus, required this.basePrice, required this.createdAt, this.approvalDate, this.averageRating, this.totalOrders, this.isActive, this.isFeatured});
  factory _ServiceListItem.fromJson(Map<String, dynamic> json) => _$ServiceListItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  String categoryName;
@override final  String providerName;
@override final  ServiceApprovalStatus approvalStatus;
@override final  double basePrice;
@override final  DateTime createdAt;
@override final  DateTime? approvalDate;
@override final  double? averageRating;
@override final  int? totalOrders;
@override final  bool? isActive;
@override final  bool? isFeatured;

/// Create a copy of ServiceListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceListItemCopyWith<_ServiceListItem> get copyWith => __$ServiceListItemCopyWithImpl<_ServiceListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.approvalDate, approvalDate) || other.approvalDate == approvalDate)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,categoryName,providerName,approvalStatus,basePrice,createdAt,approvalDate,averageRating,totalOrders,isActive,isFeatured);

@override
String toString() {
  return 'ServiceListItem(id: $id, title: $title, categoryName: $categoryName, providerName: $providerName, approvalStatus: $approvalStatus, basePrice: $basePrice, createdAt: $createdAt, approvalDate: $approvalDate, averageRating: $averageRating, totalOrders: $totalOrders, isActive: $isActive, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$ServiceListItemCopyWith<$Res> implements $ServiceListItemCopyWith<$Res> {
  factory _$ServiceListItemCopyWith(_ServiceListItem value, $Res Function(_ServiceListItem) _then) = __$ServiceListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String categoryName, String providerName, ServiceApprovalStatus approvalStatus, double basePrice, DateTime createdAt, DateTime? approvalDate, double? averageRating, int? totalOrders, bool? isActive, bool? isFeatured
});




}
/// @nodoc
class __$ServiceListItemCopyWithImpl<$Res>
    implements _$ServiceListItemCopyWith<$Res> {
  __$ServiceListItemCopyWithImpl(this._self, this._then);

  final _ServiceListItem _self;
  final $Res Function(_ServiceListItem) _then;

/// Create a copy of ServiceListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? categoryName = null,Object? providerName = null,Object? approvalStatus = null,Object? basePrice = null,Object? createdAt = null,Object? approvalDate = freezed,Object? averageRating = freezed,Object? totalOrders = freezed,Object? isActive = freezed,Object? isFeatured = freezed,}) {
  return _then(_ServiceListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,approvalStatus: null == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as ServiceApprovalStatus,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,approvalDate: freezed == approvalDate ? _self.approvalDate : approvalDate // ignore: cast_nullable_to_non_nullable
as DateTime?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,totalOrders: freezed == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ServiceRequest {

 String get title; String get description; String get categoryId; String get subcategoryId; double get basePrice; ServicePricingType get pricingType; List<ServicePackage>? get packages; List<String>? get tags; List<String>? get images; List<ServiceRequirement>? get requirements; Duration get deliveryTime; bool? get isFeatured;
/// Create a copy of ServiceRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestCopyWith<ServiceRequest> get copyWith => _$ServiceRequestCopyWithImpl<ServiceRequest>(this as ServiceRequest, _$identity);

  /// Serializes this ServiceRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.pricingType, pricingType) || other.pricingType == pricingType)&&const DeepCollectionEquality().equals(other.packages, packages)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,categoryId,subcategoryId,basePrice,pricingType,const DeepCollectionEquality().hash(packages),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(requirements),deliveryTime,isFeatured);

@override
String toString() {
  return 'ServiceRequest(title: $title, description: $description, categoryId: $categoryId, subcategoryId: $subcategoryId, basePrice: $basePrice, pricingType: $pricingType, packages: $packages, tags: $tags, images: $images, requirements: $requirements, deliveryTime: $deliveryTime, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestCopyWith<$Res>  {
  factory $ServiceRequestCopyWith(ServiceRequest value, $Res Function(ServiceRequest) _then) = _$ServiceRequestCopyWithImpl;
@useResult
$Res call({
 String title, String description, String categoryId, String subcategoryId, double basePrice, ServicePricingType pricingType, List<ServicePackage>? packages, List<String>? tags, List<String>? images, List<ServiceRequirement>? requirements, Duration deliveryTime, bool? isFeatured
});




}
/// @nodoc
class _$ServiceRequestCopyWithImpl<$Res>
    implements $ServiceRequestCopyWith<$Res> {
  _$ServiceRequestCopyWithImpl(this._self, this._then);

  final ServiceRequest _self;
  final $Res Function(ServiceRequest) _then;

/// Create a copy of ServiceRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? categoryId = null,Object? subcategoryId = null,Object? basePrice = null,Object? pricingType = null,Object? packages = freezed,Object? tags = freezed,Object? images = freezed,Object? requirements = freezed,Object? deliveryTime = null,Object? isFeatured = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: null == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,pricingType: null == pricingType ? _self.pricingType : pricingType // ignore: cast_nullable_to_non_nullable
as ServicePricingType,packages: freezed == packages ? _self.packages : packages // ignore: cast_nullable_to_non_nullable
as List<ServicePackage>?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<ServiceRequirement>?,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as Duration,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequest implements ServiceRequest {
  const _ServiceRequest({required this.title, required this.description, required this.categoryId, required this.subcategoryId, required this.basePrice, required this.pricingType, final  List<ServicePackage>? packages, final  List<String>? tags, final  List<String>? images, final  List<ServiceRequirement>? requirements, required this.deliveryTime, this.isFeatured}): _packages = packages,_tags = tags,_images = images,_requirements = requirements;
  factory _ServiceRequest.fromJson(Map<String, dynamic> json) => _$ServiceRequestFromJson(json);

@override final  String title;
@override final  String description;
@override final  String categoryId;
@override final  String subcategoryId;
@override final  double basePrice;
@override final  ServicePricingType pricingType;
 final  List<ServicePackage>? _packages;
@override List<ServicePackage>? get packages {
  final value = _packages;
  if (value == null) return null;
  if (_packages is EqualUnmodifiableListView) return _packages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _images;
@override List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ServiceRequirement>? _requirements;
@override List<ServiceRequirement>? get requirements {
  final value = _requirements;
  if (value == null) return null;
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Duration deliveryTime;
@override final  bool? isFeatured;

/// Create a copy of ServiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestCopyWith<_ServiceRequest> get copyWith => __$ServiceRequestCopyWithImpl<_ServiceRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.pricingType, pricingType) || other.pricingType == pricingType)&&const DeepCollectionEquality().equals(other._packages, _packages)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,categoryId,subcategoryId,basePrice,pricingType,const DeepCollectionEquality().hash(_packages),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_requirements),deliveryTime,isFeatured);

@override
String toString() {
  return 'ServiceRequest(title: $title, description: $description, categoryId: $categoryId, subcategoryId: $subcategoryId, basePrice: $basePrice, pricingType: $pricingType, packages: $packages, tags: $tags, images: $images, requirements: $requirements, deliveryTime: $deliveryTime, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestCopyWith<$Res> implements $ServiceRequestCopyWith<$Res> {
  factory _$ServiceRequestCopyWith(_ServiceRequest value, $Res Function(_ServiceRequest) _then) = __$ServiceRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String categoryId, String subcategoryId, double basePrice, ServicePricingType pricingType, List<ServicePackage>? packages, List<String>? tags, List<String>? images, List<ServiceRequirement>? requirements, Duration deliveryTime, bool? isFeatured
});




}
/// @nodoc
class __$ServiceRequestCopyWithImpl<$Res>
    implements _$ServiceRequestCopyWith<$Res> {
  __$ServiceRequestCopyWithImpl(this._self, this._then);

  final _ServiceRequest _self;
  final $Res Function(_ServiceRequest) _then;

/// Create a copy of ServiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? categoryId = null,Object? subcategoryId = null,Object? basePrice = null,Object? pricingType = null,Object? packages = freezed,Object? tags = freezed,Object? images = freezed,Object? requirements = freezed,Object? deliveryTime = null,Object? isFeatured = freezed,}) {
  return _then(_ServiceRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: null == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,pricingType: null == pricingType ? _self.pricingType : pricingType // ignore: cast_nullable_to_non_nullable
as ServicePricingType,packages: freezed == packages ? _self._packages : packages // ignore: cast_nullable_to_non_nullable
as List<ServicePackage>?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,requirements: freezed == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<ServiceRequirement>?,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as Duration,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ApproveServiceRequest {

 String get serviceId; bool get isApproved; String? get rejectionReason; String? get notes; String get approvedByAdminId; bool? get isFeatured;
/// Create a copy of ApproveServiceRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApproveServiceRequestCopyWith<ApproveServiceRequest> get copyWith => _$ApproveServiceRequestCopyWithImpl<ApproveServiceRequest>(this as ApproveServiceRequest, _$identity);

  /// Serializes this ApproveServiceRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveServiceRequest&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.approvedByAdminId, approvedByAdminId) || other.approvedByAdminId == approvedByAdminId)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,isApproved,rejectionReason,notes,approvedByAdminId,isFeatured);

@override
String toString() {
  return 'ApproveServiceRequest(serviceId: $serviceId, isApproved: $isApproved, rejectionReason: $rejectionReason, notes: $notes, approvedByAdminId: $approvedByAdminId, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $ApproveServiceRequestCopyWith<$Res>  {
  factory $ApproveServiceRequestCopyWith(ApproveServiceRequest value, $Res Function(ApproveServiceRequest) _then) = _$ApproveServiceRequestCopyWithImpl;
@useResult
$Res call({
 String serviceId, bool isApproved, String? rejectionReason, String? notes, String approvedByAdminId, bool? isFeatured
});




}
/// @nodoc
class _$ApproveServiceRequestCopyWithImpl<$Res>
    implements $ApproveServiceRequestCopyWith<$Res> {
  _$ApproveServiceRequestCopyWithImpl(this._self, this._then);

  final ApproveServiceRequest _self;
  final $Res Function(ApproveServiceRequest) _then;

/// Create a copy of ApproveServiceRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = null,Object? isApproved = null,Object? rejectionReason = freezed,Object? notes = freezed,Object? approvedByAdminId = null,Object? isFeatured = freezed,}) {
  return _then(_self.copyWith(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,approvedByAdminId: null == approvedByAdminId ? _self.approvedByAdminId : approvedByAdminId // ignore: cast_nullable_to_non_nullable
as String,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ApproveServiceRequest implements ApproveServiceRequest {
  const _ApproveServiceRequest({required this.serviceId, required this.isApproved, this.rejectionReason, this.notes, required this.approvedByAdminId, this.isFeatured});
  factory _ApproveServiceRequest.fromJson(Map<String, dynamic> json) => _$ApproveServiceRequestFromJson(json);

@override final  String serviceId;
@override final  bool isApproved;
@override final  String? rejectionReason;
@override final  String? notes;
@override final  String approvedByAdminId;
@override final  bool? isFeatured;

/// Create a copy of ApproveServiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApproveServiceRequestCopyWith<_ApproveServiceRequest> get copyWith => __$ApproveServiceRequestCopyWithImpl<_ApproveServiceRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApproveServiceRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApproveServiceRequest&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.approvedByAdminId, approvedByAdminId) || other.approvedByAdminId == approvedByAdminId)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,isApproved,rejectionReason,notes,approvedByAdminId,isFeatured);

@override
String toString() {
  return 'ApproveServiceRequest(serviceId: $serviceId, isApproved: $isApproved, rejectionReason: $rejectionReason, notes: $notes, approvedByAdminId: $approvedByAdminId, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$ApproveServiceRequestCopyWith<$Res> implements $ApproveServiceRequestCopyWith<$Res> {
  factory _$ApproveServiceRequestCopyWith(_ApproveServiceRequest value, $Res Function(_ApproveServiceRequest) _then) = __$ApproveServiceRequestCopyWithImpl;
@override @useResult
$Res call({
 String serviceId, bool isApproved, String? rejectionReason, String? notes, String approvedByAdminId, bool? isFeatured
});




}
/// @nodoc
class __$ApproveServiceRequestCopyWithImpl<$Res>
    implements _$ApproveServiceRequestCopyWith<$Res> {
  __$ApproveServiceRequestCopyWithImpl(this._self, this._then);

  final _ApproveServiceRequest _self;
  final $Res Function(_ApproveServiceRequest) _then;

/// Create a copy of ApproveServiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = null,Object? isApproved = null,Object? rejectionReason = freezed,Object? notes = freezed,Object? approvedByAdminId = null,Object? isFeatured = freezed,}) {
  return _then(_ApproveServiceRequest(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,approvedByAdminId: null == approvedByAdminId ? _self.approvedByAdminId : approvedByAdminId // ignore: cast_nullable_to_non_nullable
as String,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ServicePackage {

 String get name; String get description; double get price; Duration get deliveryTime; List<String>? get features;
/// Create a copy of ServicePackage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicePackageCopyWith<ServicePackage> get copyWith => _$ServicePackageCopyWithImpl<ServicePackage>(this as ServicePackage, _$identity);

  /// Serializes this ServicePackage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicePackage&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&const DeepCollectionEquality().equals(other.features, features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,price,deliveryTime,const DeepCollectionEquality().hash(features));

@override
String toString() {
  return 'ServicePackage(name: $name, description: $description, price: $price, deliveryTime: $deliveryTime, features: $features)';
}


}

/// @nodoc
abstract mixin class $ServicePackageCopyWith<$Res>  {
  factory $ServicePackageCopyWith(ServicePackage value, $Res Function(ServicePackage) _then) = _$ServicePackageCopyWithImpl;
@useResult
$Res call({
 String name, String description, double price, Duration deliveryTime, List<String>? features
});




}
/// @nodoc
class _$ServicePackageCopyWithImpl<$Res>
    implements $ServicePackageCopyWith<$Res> {
  _$ServicePackageCopyWithImpl(this._self, this._then);

  final ServicePackage _self;
  final $Res Function(ServicePackage) _then;

/// Create a copy of ServicePackage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? price = null,Object? deliveryTime = null,Object? features = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as Duration,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServicePackage implements ServicePackage {
  const _ServicePackage({required this.name, required this.description, required this.price, required this.deliveryTime, final  List<String>? features}): _features = features;
  factory _ServicePackage.fromJson(Map<String, dynamic> json) => _$ServicePackageFromJson(json);

@override final  String name;
@override final  String description;
@override final  double price;
@override final  Duration deliveryTime;
 final  List<String>? _features;
@override List<String>? get features {
  final value = _features;
  if (value == null) return null;
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ServicePackage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicePackageCopyWith<_ServicePackage> get copyWith => __$ServicePackageCopyWithImpl<_ServicePackage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServicePackageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServicePackage&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&const DeepCollectionEquality().equals(other._features, _features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,price,deliveryTime,const DeepCollectionEquality().hash(_features));

@override
String toString() {
  return 'ServicePackage(name: $name, description: $description, price: $price, deliveryTime: $deliveryTime, features: $features)';
}


}

/// @nodoc
abstract mixin class _$ServicePackageCopyWith<$Res> implements $ServicePackageCopyWith<$Res> {
  factory _$ServicePackageCopyWith(_ServicePackage value, $Res Function(_ServicePackage) _then) = __$ServicePackageCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, double price, Duration deliveryTime, List<String>? features
});




}
/// @nodoc
class __$ServicePackageCopyWithImpl<$Res>
    implements _$ServicePackageCopyWith<$Res> {
  __$ServicePackageCopyWithImpl(this._self, this._then);

  final _ServicePackage _self;
  final $Res Function(_ServicePackage) _then;

/// Create a copy of ServicePackage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? price = null,Object? deliveryTime = null,Object? features = freezed,}) {
  return _then(_ServicePackage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as Duration,features: freezed == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$ServiceRequirement {

 String get question; ServiceRequirementType get type; bool get isRequired; List<String>? get options;
/// Create a copy of ServiceRequirement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequirementCopyWith<ServiceRequirement> get copyWith => _$ServiceRequirementCopyWithImpl<ServiceRequirement>(this as ServiceRequirement, _$identity);

  /// Serializes this ServiceRequirement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequirement&&(identical(other.question, question) || other.question == question)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,type,isRequired,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'ServiceRequirement(question: $question, type: $type, isRequired: $isRequired, options: $options)';
}


}

/// @nodoc
abstract mixin class $ServiceRequirementCopyWith<$Res>  {
  factory $ServiceRequirementCopyWith(ServiceRequirement value, $Res Function(ServiceRequirement) _then) = _$ServiceRequirementCopyWithImpl;
@useResult
$Res call({
 String question, ServiceRequirementType type, bool isRequired, List<String>? options
});




}
/// @nodoc
class _$ServiceRequirementCopyWithImpl<$Res>
    implements $ServiceRequirementCopyWith<$Res> {
  _$ServiceRequirementCopyWithImpl(this._self, this._then);

  final ServiceRequirement _self;
  final $Res Function(ServiceRequirement) _then;

/// Create a copy of ServiceRequirement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? type = null,Object? isRequired = null,Object? options = freezed,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ServiceRequirementType,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequirement implements ServiceRequirement {
  const _ServiceRequirement({required this.question, required this.type, required this.isRequired, final  List<String>? options}): _options = options;
  factory _ServiceRequirement.fromJson(Map<String, dynamic> json) => _$ServiceRequirementFromJson(json);

@override final  String question;
@override final  ServiceRequirementType type;
@override final  bool isRequired;
 final  List<String>? _options;
@override List<String>? get options {
  final value = _options;
  if (value == null) return null;
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ServiceRequirement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequirementCopyWith<_ServiceRequirement> get copyWith => __$ServiceRequirementCopyWithImpl<_ServiceRequirement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequirementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequirement&&(identical(other.question, question) || other.question == question)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,type,isRequired,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'ServiceRequirement(question: $question, type: $type, isRequired: $isRequired, options: $options)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequirementCopyWith<$Res> implements $ServiceRequirementCopyWith<$Res> {
  factory _$ServiceRequirementCopyWith(_ServiceRequirement value, $Res Function(_ServiceRequirement) _then) = __$ServiceRequirementCopyWithImpl;
@override @useResult
$Res call({
 String question, ServiceRequirementType type, bool isRequired, List<String>? options
});




}
/// @nodoc
class __$ServiceRequirementCopyWithImpl<$Res>
    implements _$ServiceRequirementCopyWith<$Res> {
  __$ServiceRequirementCopyWithImpl(this._self, this._then);

  final _ServiceRequirement _self;
  final $Res Function(_ServiceRequirement) _then;

/// Create a copy of ServiceRequirement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? type = null,Object? isRequired = null,Object? options = freezed,}) {
  return _then(_ServiceRequirement(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ServiceRequirementType,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,options: freezed == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$ServiceCategory {

 String get id; String get name; String get description; String? get icon; String? get imageUrl; int get sortOrder; bool get isActive; List<ServiceSubcategory>? get subcategories; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ServiceCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCategoryCopyWith<ServiceCategory> get copyWith => _$ServiceCategoryCopyWithImpl<ServiceCategory>(this as ServiceCategory, _$identity);

  /// Serializes this ServiceCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.subcategories, subcategories)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,icon,imageUrl,sortOrder,isActive,const DeepCollectionEquality().hash(subcategories),createdAt,updatedAt);

@override
String toString() {
  return 'ServiceCategory(id: $id, name: $name, description: $description, icon: $icon, imageUrl: $imageUrl, sortOrder: $sortOrder, isActive: $isActive, subcategories: $subcategories, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ServiceCategoryCopyWith<$Res>  {
  factory $ServiceCategoryCopyWith(ServiceCategory value, $Res Function(ServiceCategory) _then) = _$ServiceCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String? icon, String? imageUrl, int sortOrder, bool isActive, List<ServiceSubcategory>? subcategories, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ServiceCategoryCopyWithImpl<$Res>
    implements $ServiceCategoryCopyWith<$Res> {
  _$ServiceCategoryCopyWithImpl(this._self, this._then);

  final ServiceCategory _self;
  final $Res Function(ServiceCategory) _then;

/// Create a copy of ServiceCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? icon = freezed,Object? imageUrl = freezed,Object? sortOrder = null,Object? isActive = null,Object? subcategories = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,subcategories: freezed == subcategories ? _self.subcategories : subcategories // ignore: cast_nullable_to_non_nullable
as List<ServiceSubcategory>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceCategory implements ServiceCategory {
  const _ServiceCategory({required this.id, required this.name, required this.description, this.icon, this.imageUrl, required this.sortOrder, required this.isActive, final  List<ServiceSubcategory>? subcategories, required this.createdAt, required this.updatedAt}): _subcategories = subcategories;
  factory _ServiceCategory.fromJson(Map<String, dynamic> json) => _$ServiceCategoryFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String? icon;
@override final  String? imageUrl;
@override final  int sortOrder;
@override final  bool isActive;
 final  List<ServiceSubcategory>? _subcategories;
@override List<ServiceSubcategory>? get subcategories {
  final value = _subcategories;
  if (value == null) return null;
  if (_subcategories is EqualUnmodifiableListView) return _subcategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ServiceCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCategoryCopyWith<_ServiceCategory> get copyWith => __$ServiceCategoryCopyWithImpl<_ServiceCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._subcategories, _subcategories)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,icon,imageUrl,sortOrder,isActive,const DeepCollectionEquality().hash(_subcategories),createdAt,updatedAt);

@override
String toString() {
  return 'ServiceCategory(id: $id, name: $name, description: $description, icon: $icon, imageUrl: $imageUrl, sortOrder: $sortOrder, isActive: $isActive, subcategories: $subcategories, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ServiceCategoryCopyWith<$Res> implements $ServiceCategoryCopyWith<$Res> {
  factory _$ServiceCategoryCopyWith(_ServiceCategory value, $Res Function(_ServiceCategory) _then) = __$ServiceCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String? icon, String? imageUrl, int sortOrder, bool isActive, List<ServiceSubcategory>? subcategories, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ServiceCategoryCopyWithImpl<$Res>
    implements _$ServiceCategoryCopyWith<$Res> {
  __$ServiceCategoryCopyWithImpl(this._self, this._then);

  final _ServiceCategory _self;
  final $Res Function(_ServiceCategory) _then;

/// Create a copy of ServiceCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? icon = freezed,Object? imageUrl = freezed,Object? sortOrder = null,Object? isActive = null,Object? subcategories = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ServiceCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,subcategories: freezed == subcategories ? _self._subcategories : subcategories // ignore: cast_nullable_to_non_nullable
as List<ServiceSubcategory>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ServiceSubcategory {

 String get id; String get categoryId; String get name; String get description; int get sortOrder; bool get isActive; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ServiceSubcategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceSubcategoryCopyWith<ServiceSubcategory> get copyWith => _$ServiceSubcategoryCopyWithImpl<ServiceSubcategory>(this as ServiceSubcategory, _$identity);

  /// Serializes this ServiceSubcategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceSubcategory&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,description,sortOrder,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'ServiceSubcategory(id: $id, categoryId: $categoryId, name: $name, description: $description, sortOrder: $sortOrder, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ServiceSubcategoryCopyWith<$Res>  {
  factory $ServiceSubcategoryCopyWith(ServiceSubcategory value, $Res Function(ServiceSubcategory) _then) = _$ServiceSubcategoryCopyWithImpl;
@useResult
$Res call({
 String id, String categoryId, String name, String description, int sortOrder, bool isActive, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ServiceSubcategoryCopyWithImpl<$Res>
    implements $ServiceSubcategoryCopyWith<$Res> {
  _$ServiceSubcategoryCopyWithImpl(this._self, this._then);

  final ServiceSubcategory _self;
  final $Res Function(ServiceSubcategory) _then;

/// Create a copy of ServiceSubcategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? description = null,Object? sortOrder = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceSubcategory implements ServiceSubcategory {
  const _ServiceSubcategory({required this.id, required this.categoryId, required this.name, required this.description, required this.sortOrder, required this.isActive, required this.createdAt, required this.updatedAt});
  factory _ServiceSubcategory.fromJson(Map<String, dynamic> json) => _$ServiceSubcategoryFromJson(json);

@override final  String id;
@override final  String categoryId;
@override final  String name;
@override final  String description;
@override final  int sortOrder;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ServiceSubcategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceSubcategoryCopyWith<_ServiceSubcategory> get copyWith => __$ServiceSubcategoryCopyWithImpl<_ServiceSubcategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceSubcategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceSubcategory&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,description,sortOrder,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'ServiceSubcategory(id: $id, categoryId: $categoryId, name: $name, description: $description, sortOrder: $sortOrder, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ServiceSubcategoryCopyWith<$Res> implements $ServiceSubcategoryCopyWith<$Res> {
  factory _$ServiceSubcategoryCopyWith(_ServiceSubcategory value, $Res Function(_ServiceSubcategory) _then) = __$ServiceSubcategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String categoryId, String name, String description, int sortOrder, bool isActive, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ServiceSubcategoryCopyWithImpl<$Res>
    implements _$ServiceSubcategoryCopyWith<$Res> {
  __$ServiceSubcategoryCopyWithImpl(this._self, this._then);

  final _ServiceSubcategory _self;
  final $Res Function(_ServiceSubcategory) _then;

/// Create a copy of ServiceSubcategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? description = null,Object? sortOrder = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ServiceSubcategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ServiceCategoryRequest {

 String get name; String get description; String? get icon; String? get imageUrl; int get sortOrder; bool get isActive;
/// Create a copy of ServiceCategoryRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCategoryRequestCopyWith<ServiceCategoryRequest> get copyWith => _$ServiceCategoryRequestCopyWithImpl<ServiceCategoryRequest>(this as ServiceCategoryRequest, _$identity);

  /// Serializes this ServiceCategoryRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCategoryRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,icon,imageUrl,sortOrder,isActive);

@override
String toString() {
  return 'ServiceCategoryRequest(name: $name, description: $description, icon: $icon, imageUrl: $imageUrl, sortOrder: $sortOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ServiceCategoryRequestCopyWith<$Res>  {
  factory $ServiceCategoryRequestCopyWith(ServiceCategoryRequest value, $Res Function(ServiceCategoryRequest) _then) = _$ServiceCategoryRequestCopyWithImpl;
@useResult
$Res call({
 String name, String description, String? icon, String? imageUrl, int sortOrder, bool isActive
});




}
/// @nodoc
class _$ServiceCategoryRequestCopyWithImpl<$Res>
    implements $ServiceCategoryRequestCopyWith<$Res> {
  _$ServiceCategoryRequestCopyWithImpl(this._self, this._then);

  final ServiceCategoryRequest _self;
  final $Res Function(ServiceCategoryRequest) _then;

/// Create a copy of ServiceCategoryRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? icon = freezed,Object? imageUrl = freezed,Object? sortOrder = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceCategoryRequest implements ServiceCategoryRequest {
  const _ServiceCategoryRequest({required this.name, required this.description, this.icon, this.imageUrl, required this.sortOrder, required this.isActive});
  factory _ServiceCategoryRequest.fromJson(Map<String, dynamic> json) => _$ServiceCategoryRequestFromJson(json);

@override final  String name;
@override final  String description;
@override final  String? icon;
@override final  String? imageUrl;
@override final  int sortOrder;
@override final  bool isActive;

/// Create a copy of ServiceCategoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCategoryRequestCopyWith<_ServiceCategoryRequest> get copyWith => __$ServiceCategoryRequestCopyWithImpl<_ServiceCategoryRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceCategoryRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceCategoryRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,icon,imageUrl,sortOrder,isActive);

@override
String toString() {
  return 'ServiceCategoryRequest(name: $name, description: $description, icon: $icon, imageUrl: $imageUrl, sortOrder: $sortOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ServiceCategoryRequestCopyWith<$Res> implements $ServiceCategoryRequestCopyWith<$Res> {
  factory _$ServiceCategoryRequestCopyWith(_ServiceCategoryRequest value, $Res Function(_ServiceCategoryRequest) _then) = __$ServiceCategoryRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String? icon, String? imageUrl, int sortOrder, bool isActive
});




}
/// @nodoc
class __$ServiceCategoryRequestCopyWithImpl<$Res>
    implements _$ServiceCategoryRequestCopyWith<$Res> {
  __$ServiceCategoryRequestCopyWithImpl(this._self, this._then);

  final _ServiceCategoryRequest _self;
  final $Res Function(_ServiceCategoryRequest) _then;

/// Create a copy of ServiceCategoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? icon = freezed,Object? imageUrl = freezed,Object? sortOrder = null,Object? isActive = null,}) {
  return _then(_ServiceCategoryRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ServiceSubcategoryRequest {

 String get categoryId; String get name; String get description; int get sortOrder; bool get isActive;
/// Create a copy of ServiceSubcategoryRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceSubcategoryRequestCopyWith<ServiceSubcategoryRequest> get copyWith => _$ServiceSubcategoryRequestCopyWithImpl<ServiceSubcategoryRequest>(this as ServiceSubcategoryRequest, _$identity);

  /// Serializes this ServiceSubcategoryRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceSubcategoryRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,name,description,sortOrder,isActive);

@override
String toString() {
  return 'ServiceSubcategoryRequest(categoryId: $categoryId, name: $name, description: $description, sortOrder: $sortOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ServiceSubcategoryRequestCopyWith<$Res>  {
  factory $ServiceSubcategoryRequestCopyWith(ServiceSubcategoryRequest value, $Res Function(ServiceSubcategoryRequest) _then) = _$ServiceSubcategoryRequestCopyWithImpl;
@useResult
$Res call({
 String categoryId, String name, String description, int sortOrder, bool isActive
});




}
/// @nodoc
class _$ServiceSubcategoryRequestCopyWithImpl<$Res>
    implements $ServiceSubcategoryRequestCopyWith<$Res> {
  _$ServiceSubcategoryRequestCopyWithImpl(this._self, this._then);

  final ServiceSubcategoryRequest _self;
  final $Res Function(ServiceSubcategoryRequest) _then;

/// Create a copy of ServiceSubcategoryRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? name = null,Object? description = null,Object? sortOrder = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceSubcategoryRequest implements ServiceSubcategoryRequest {
  const _ServiceSubcategoryRequest({required this.categoryId, required this.name, required this.description, required this.sortOrder, required this.isActive});
  factory _ServiceSubcategoryRequest.fromJson(Map<String, dynamic> json) => _$ServiceSubcategoryRequestFromJson(json);

@override final  String categoryId;
@override final  String name;
@override final  String description;
@override final  int sortOrder;
@override final  bool isActive;

/// Create a copy of ServiceSubcategoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceSubcategoryRequestCopyWith<_ServiceSubcategoryRequest> get copyWith => __$ServiceSubcategoryRequestCopyWithImpl<_ServiceSubcategoryRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceSubcategoryRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceSubcategoryRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,name,description,sortOrder,isActive);

@override
String toString() {
  return 'ServiceSubcategoryRequest(categoryId: $categoryId, name: $name, description: $description, sortOrder: $sortOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ServiceSubcategoryRequestCopyWith<$Res> implements $ServiceSubcategoryRequestCopyWith<$Res> {
  factory _$ServiceSubcategoryRequestCopyWith(_ServiceSubcategoryRequest value, $Res Function(_ServiceSubcategoryRequest) _then) = __$ServiceSubcategoryRequestCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, String name, String description, int sortOrder, bool isActive
});




}
/// @nodoc
class __$ServiceSubcategoryRequestCopyWithImpl<$Res>
    implements _$ServiceSubcategoryRequestCopyWith<$Res> {
  __$ServiceSubcategoryRequestCopyWithImpl(this._self, this._then);

  final _ServiceSubcategoryRequest _self;
  final $Res Function(_ServiceSubcategoryRequest) _then;

/// Create a copy of ServiceSubcategoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? name = null,Object? description = null,Object? sortOrder = null,Object? isActive = null,}) {
  return _then(_ServiceSubcategoryRequest(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
