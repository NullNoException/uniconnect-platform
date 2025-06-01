// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Provider {

 String get id; String get userId; String get companyName; String? get registrationNumber; ProviderVerificationStatus get verificationStatus; String? get verifiedById; DateTime? get verificationDate; String? get companyLogoUrl; String? get companyWebsite; int? get yearsInBusiness; String? get subscriptionPlanId; DateTime? get subscriptionStartDate; DateTime? get subscriptionEndDate; String? get billingAddressId; String? get taxIdentificationNumber; List<String>? get documents; String? get notes; DateTime get createdAt; DateTime get updatedAt;// User information
 String get email; String? get firstName; String? get lastName; String? get phoneNumber; bool? get isActive;// Performance metrics
 double? get averageRating; int? get totalServices; int? get completedOrders; double? get completionRate; double? get responseTime;
/// Create a copy of Provider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderCopyWith<Provider> get copyWith => _$ProviderCopyWithImpl<Provider>(this as Provider, _$identity);

  /// Serializes this Provider to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Provider&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.verifiedById, verifiedById) || other.verifiedById == verifiedById)&&(identical(other.verificationDate, verificationDate) || other.verificationDate == verificationDate)&&(identical(other.companyLogoUrl, companyLogoUrl) || other.companyLogoUrl == companyLogoUrl)&&(identical(other.companyWebsite, companyWebsite) || other.companyWebsite == companyWebsite)&&(identical(other.yearsInBusiness, yearsInBusiness) || other.yearsInBusiness == yearsInBusiness)&&(identical(other.subscriptionPlanId, subscriptionPlanId) || other.subscriptionPlanId == subscriptionPlanId)&&(identical(other.subscriptionStartDate, subscriptionStartDate) || other.subscriptionStartDate == subscriptionStartDate)&&(identical(other.subscriptionEndDate, subscriptionEndDate) || other.subscriptionEndDate == subscriptionEndDate)&&(identical(other.billingAddressId, billingAddressId) || other.billingAddressId == billingAddressId)&&(identical(other.taxIdentificationNumber, taxIdentificationNumber) || other.taxIdentificationNumber == taxIdentificationNumber)&&const DeepCollectionEquality().equals(other.documents, documents)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalServices, totalServices) || other.totalServices == totalServices)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,companyName,registrationNumber,verificationStatus,verifiedById,verificationDate,companyLogoUrl,companyWebsite,yearsInBusiness,subscriptionPlanId,subscriptionStartDate,subscriptionEndDate,billingAddressId,taxIdentificationNumber,const DeepCollectionEquality().hash(documents),notes,createdAt,updatedAt,email,firstName,lastName,phoneNumber,isActive,averageRating,totalServices,completedOrders,completionRate,responseTime]);

@override
String toString() {
  return 'Provider(id: $id, userId: $userId, companyName: $companyName, registrationNumber: $registrationNumber, verificationStatus: $verificationStatus, verifiedById: $verifiedById, verificationDate: $verificationDate, companyLogoUrl: $companyLogoUrl, companyWebsite: $companyWebsite, yearsInBusiness: $yearsInBusiness, subscriptionPlanId: $subscriptionPlanId, subscriptionStartDate: $subscriptionStartDate, subscriptionEndDate: $subscriptionEndDate, billingAddressId: $billingAddressId, taxIdentificationNumber: $taxIdentificationNumber, documents: $documents, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, isActive: $isActive, averageRating: $averageRating, totalServices: $totalServices, completedOrders: $completedOrders, completionRate: $completionRate, responseTime: $responseTime)';
}


}

/// @nodoc
abstract mixin class $ProviderCopyWith<$Res>  {
  factory $ProviderCopyWith(Provider value, $Res Function(Provider) _then) = _$ProviderCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String companyName, String? registrationNumber, ProviderVerificationStatus verificationStatus, String? verifiedById, DateTime? verificationDate, String? companyLogoUrl, String? companyWebsite, int? yearsInBusiness, String? subscriptionPlanId, DateTime? subscriptionStartDate, DateTime? subscriptionEndDate, String? billingAddressId, String? taxIdentificationNumber, List<String>? documents, String? notes, DateTime createdAt, DateTime updatedAt, String email, String? firstName, String? lastName, String? phoneNumber, bool? isActive, double? averageRating, int? totalServices, int? completedOrders, double? completionRate, double? responseTime
});




}
/// @nodoc
class _$ProviderCopyWithImpl<$Res>
    implements $ProviderCopyWith<$Res> {
  _$ProviderCopyWithImpl(this._self, this._then);

  final Provider _self;
  final $Res Function(Provider) _then;

/// Create a copy of Provider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? companyName = null,Object? registrationNumber = freezed,Object? verificationStatus = null,Object? verifiedById = freezed,Object? verificationDate = freezed,Object? companyLogoUrl = freezed,Object? companyWebsite = freezed,Object? yearsInBusiness = freezed,Object? subscriptionPlanId = freezed,Object? subscriptionStartDate = freezed,Object? subscriptionEndDate = freezed,Object? billingAddressId = freezed,Object? taxIdentificationNumber = freezed,Object? documents = freezed,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? phoneNumber = freezed,Object? isActive = freezed,Object? averageRating = freezed,Object? totalServices = freezed,Object? completedOrders = freezed,Object? completionRate = freezed,Object? responseTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as ProviderVerificationStatus,verifiedById: freezed == verifiedById ? _self.verifiedById : verifiedById // ignore: cast_nullable_to_non_nullable
as String?,verificationDate: freezed == verificationDate ? _self.verificationDate : verificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,companyLogoUrl: freezed == companyLogoUrl ? _self.companyLogoUrl : companyLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,companyWebsite: freezed == companyWebsite ? _self.companyWebsite : companyWebsite // ignore: cast_nullable_to_non_nullable
as String?,yearsInBusiness: freezed == yearsInBusiness ? _self.yearsInBusiness : yearsInBusiness // ignore: cast_nullable_to_non_nullable
as int?,subscriptionPlanId: freezed == subscriptionPlanId ? _self.subscriptionPlanId : subscriptionPlanId // ignore: cast_nullable_to_non_nullable
as String?,subscriptionStartDate: freezed == subscriptionStartDate ? _self.subscriptionStartDate : subscriptionStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,subscriptionEndDate: freezed == subscriptionEndDate ? _self.subscriptionEndDate : subscriptionEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,billingAddressId: freezed == billingAddressId ? _self.billingAddressId : billingAddressId // ignore: cast_nullable_to_non_nullable
as String?,taxIdentificationNumber: freezed == taxIdentificationNumber ? _self.taxIdentificationNumber : taxIdentificationNumber // ignore: cast_nullable_to_non_nullable
as String?,documents: freezed == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<String>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,totalServices: freezed == totalServices ? _self.totalServices : totalServices // ignore: cast_nullable_to_non_nullable
as int?,completedOrders: freezed == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int?,completionRate: freezed == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double?,responseTime: freezed == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Provider implements Provider {
  const _Provider({required this.id, required this.userId, required this.companyName, this.registrationNumber, required this.verificationStatus, this.verifiedById, this.verificationDate, this.companyLogoUrl, this.companyWebsite, this.yearsInBusiness, this.subscriptionPlanId, this.subscriptionStartDate, this.subscriptionEndDate, this.billingAddressId, this.taxIdentificationNumber, final  List<String>? documents, this.notes, required this.createdAt, required this.updatedAt, required this.email, this.firstName, this.lastName, this.phoneNumber, this.isActive, this.averageRating, this.totalServices, this.completedOrders, this.completionRate, this.responseTime}): _documents = documents;
  factory _Provider.fromJson(Map<String, dynamic> json) => _$ProviderFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String companyName;
@override final  String? registrationNumber;
@override final  ProviderVerificationStatus verificationStatus;
@override final  String? verifiedById;
@override final  DateTime? verificationDate;
@override final  String? companyLogoUrl;
@override final  String? companyWebsite;
@override final  int? yearsInBusiness;
@override final  String? subscriptionPlanId;
@override final  DateTime? subscriptionStartDate;
@override final  DateTime? subscriptionEndDate;
@override final  String? billingAddressId;
@override final  String? taxIdentificationNumber;
 final  List<String>? _documents;
@override List<String>? get documents {
  final value = _documents;
  if (value == null) return null;
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
// User information
@override final  String email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? phoneNumber;
@override final  bool? isActive;
// Performance metrics
@override final  double? averageRating;
@override final  int? totalServices;
@override final  int? completedOrders;
@override final  double? completionRate;
@override final  double? responseTime;

/// Create a copy of Provider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderCopyWith<_Provider> get copyWith => __$ProviderCopyWithImpl<_Provider>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Provider&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.verifiedById, verifiedById) || other.verifiedById == verifiedById)&&(identical(other.verificationDate, verificationDate) || other.verificationDate == verificationDate)&&(identical(other.companyLogoUrl, companyLogoUrl) || other.companyLogoUrl == companyLogoUrl)&&(identical(other.companyWebsite, companyWebsite) || other.companyWebsite == companyWebsite)&&(identical(other.yearsInBusiness, yearsInBusiness) || other.yearsInBusiness == yearsInBusiness)&&(identical(other.subscriptionPlanId, subscriptionPlanId) || other.subscriptionPlanId == subscriptionPlanId)&&(identical(other.subscriptionStartDate, subscriptionStartDate) || other.subscriptionStartDate == subscriptionStartDate)&&(identical(other.subscriptionEndDate, subscriptionEndDate) || other.subscriptionEndDate == subscriptionEndDate)&&(identical(other.billingAddressId, billingAddressId) || other.billingAddressId == billingAddressId)&&(identical(other.taxIdentificationNumber, taxIdentificationNumber) || other.taxIdentificationNumber == taxIdentificationNumber)&&const DeepCollectionEquality().equals(other._documents, _documents)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalServices, totalServices) || other.totalServices == totalServices)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,companyName,registrationNumber,verificationStatus,verifiedById,verificationDate,companyLogoUrl,companyWebsite,yearsInBusiness,subscriptionPlanId,subscriptionStartDate,subscriptionEndDate,billingAddressId,taxIdentificationNumber,const DeepCollectionEquality().hash(_documents),notes,createdAt,updatedAt,email,firstName,lastName,phoneNumber,isActive,averageRating,totalServices,completedOrders,completionRate,responseTime]);

@override
String toString() {
  return 'Provider(id: $id, userId: $userId, companyName: $companyName, registrationNumber: $registrationNumber, verificationStatus: $verificationStatus, verifiedById: $verifiedById, verificationDate: $verificationDate, companyLogoUrl: $companyLogoUrl, companyWebsite: $companyWebsite, yearsInBusiness: $yearsInBusiness, subscriptionPlanId: $subscriptionPlanId, subscriptionStartDate: $subscriptionStartDate, subscriptionEndDate: $subscriptionEndDate, billingAddressId: $billingAddressId, taxIdentificationNumber: $taxIdentificationNumber, documents: $documents, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, isActive: $isActive, averageRating: $averageRating, totalServices: $totalServices, completedOrders: $completedOrders, completionRate: $completionRate, responseTime: $responseTime)';
}


}

/// @nodoc
abstract mixin class _$ProviderCopyWith<$Res> implements $ProviderCopyWith<$Res> {
  factory _$ProviderCopyWith(_Provider value, $Res Function(_Provider) _then) = __$ProviderCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String companyName, String? registrationNumber, ProviderVerificationStatus verificationStatus, String? verifiedById, DateTime? verificationDate, String? companyLogoUrl, String? companyWebsite, int? yearsInBusiness, String? subscriptionPlanId, DateTime? subscriptionStartDate, DateTime? subscriptionEndDate, String? billingAddressId, String? taxIdentificationNumber, List<String>? documents, String? notes, DateTime createdAt, DateTime updatedAt, String email, String? firstName, String? lastName, String? phoneNumber, bool? isActive, double? averageRating, int? totalServices, int? completedOrders, double? completionRate, double? responseTime
});




}
/// @nodoc
class __$ProviderCopyWithImpl<$Res>
    implements _$ProviderCopyWith<$Res> {
  __$ProviderCopyWithImpl(this._self, this._then);

  final _Provider _self;
  final $Res Function(_Provider) _then;

/// Create a copy of Provider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? companyName = null,Object? registrationNumber = freezed,Object? verificationStatus = null,Object? verifiedById = freezed,Object? verificationDate = freezed,Object? companyLogoUrl = freezed,Object? companyWebsite = freezed,Object? yearsInBusiness = freezed,Object? subscriptionPlanId = freezed,Object? subscriptionStartDate = freezed,Object? subscriptionEndDate = freezed,Object? billingAddressId = freezed,Object? taxIdentificationNumber = freezed,Object? documents = freezed,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? phoneNumber = freezed,Object? isActive = freezed,Object? averageRating = freezed,Object? totalServices = freezed,Object? completedOrders = freezed,Object? completionRate = freezed,Object? responseTime = freezed,}) {
  return _then(_Provider(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as ProviderVerificationStatus,verifiedById: freezed == verifiedById ? _self.verifiedById : verifiedById // ignore: cast_nullable_to_non_nullable
as String?,verificationDate: freezed == verificationDate ? _self.verificationDate : verificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,companyLogoUrl: freezed == companyLogoUrl ? _self.companyLogoUrl : companyLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,companyWebsite: freezed == companyWebsite ? _self.companyWebsite : companyWebsite // ignore: cast_nullable_to_non_nullable
as String?,yearsInBusiness: freezed == yearsInBusiness ? _self.yearsInBusiness : yearsInBusiness // ignore: cast_nullable_to_non_nullable
as int?,subscriptionPlanId: freezed == subscriptionPlanId ? _self.subscriptionPlanId : subscriptionPlanId // ignore: cast_nullable_to_non_nullable
as String?,subscriptionStartDate: freezed == subscriptionStartDate ? _self.subscriptionStartDate : subscriptionStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,subscriptionEndDate: freezed == subscriptionEndDate ? _self.subscriptionEndDate : subscriptionEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,billingAddressId: freezed == billingAddressId ? _self.billingAddressId : billingAddressId // ignore: cast_nullable_to_non_nullable
as String?,taxIdentificationNumber: freezed == taxIdentificationNumber ? _self.taxIdentificationNumber : taxIdentificationNumber // ignore: cast_nullable_to_non_nullable
as String?,documents: freezed == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<String>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,totalServices: freezed == totalServices ? _self.totalServices : totalServices // ignore: cast_nullable_to_non_nullable
as int?,completedOrders: freezed == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int?,completionRate: freezed == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double?,responseTime: freezed == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$ProviderListItem {

 String get id; String get companyName; String get email; ProviderVerificationStatus get verificationStatus; DateTime get createdAt; DateTime? get verificationDate; double? get averageRating; int? get totalServices; bool? get isActive;
/// Create a copy of ProviderListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderListItemCopyWith<ProviderListItem> get copyWith => _$ProviderListItemCopyWithImpl<ProviderListItem>(this as ProviderListItem, _$identity);

  /// Serializes this ProviderListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.email, email) || other.email == email)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.verificationDate, verificationDate) || other.verificationDate == verificationDate)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalServices, totalServices) || other.totalServices == totalServices)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyName,email,verificationStatus,createdAt,verificationDate,averageRating,totalServices,isActive);

@override
String toString() {
  return 'ProviderListItem(id: $id, companyName: $companyName, email: $email, verificationStatus: $verificationStatus, createdAt: $createdAt, verificationDate: $verificationDate, averageRating: $averageRating, totalServices: $totalServices, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ProviderListItemCopyWith<$Res>  {
  factory $ProviderListItemCopyWith(ProviderListItem value, $Res Function(ProviderListItem) _then) = _$ProviderListItemCopyWithImpl;
@useResult
$Res call({
 String id, String companyName, String email, ProviderVerificationStatus verificationStatus, DateTime createdAt, DateTime? verificationDate, double? averageRating, int? totalServices, bool? isActive
});




}
/// @nodoc
class _$ProviderListItemCopyWithImpl<$Res>
    implements $ProviderListItemCopyWith<$Res> {
  _$ProviderListItemCopyWithImpl(this._self, this._then);

  final ProviderListItem _self;
  final $Res Function(ProviderListItem) _then;

/// Create a copy of ProviderListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? companyName = null,Object? email = null,Object? verificationStatus = null,Object? createdAt = null,Object? verificationDate = freezed,Object? averageRating = freezed,Object? totalServices = freezed,Object? isActive = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as ProviderVerificationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,verificationDate: freezed == verificationDate ? _self.verificationDate : verificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,totalServices: freezed == totalServices ? _self.totalServices : totalServices // ignore: cast_nullable_to_non_nullable
as int?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProviderListItem implements ProviderListItem {
  const _ProviderListItem({required this.id, required this.companyName, required this.email, required this.verificationStatus, required this.createdAt, this.verificationDate, this.averageRating, this.totalServices, this.isActive});
  factory _ProviderListItem.fromJson(Map<String, dynamic> json) => _$ProviderListItemFromJson(json);

@override final  String id;
@override final  String companyName;
@override final  String email;
@override final  ProviderVerificationStatus verificationStatus;
@override final  DateTime createdAt;
@override final  DateTime? verificationDate;
@override final  double? averageRating;
@override final  int? totalServices;
@override final  bool? isActive;

/// Create a copy of ProviderListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderListItemCopyWith<_ProviderListItem> get copyWith => __$ProviderListItemCopyWithImpl<_ProviderListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.email, email) || other.email == email)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.verificationDate, verificationDate) || other.verificationDate == verificationDate)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalServices, totalServices) || other.totalServices == totalServices)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyName,email,verificationStatus,createdAt,verificationDate,averageRating,totalServices,isActive);

@override
String toString() {
  return 'ProviderListItem(id: $id, companyName: $companyName, email: $email, verificationStatus: $verificationStatus, createdAt: $createdAt, verificationDate: $verificationDate, averageRating: $averageRating, totalServices: $totalServices, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ProviderListItemCopyWith<$Res> implements $ProviderListItemCopyWith<$Res> {
  factory _$ProviderListItemCopyWith(_ProviderListItem value, $Res Function(_ProviderListItem) _then) = __$ProviderListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String companyName, String email, ProviderVerificationStatus verificationStatus, DateTime createdAt, DateTime? verificationDate, double? averageRating, int? totalServices, bool? isActive
});




}
/// @nodoc
class __$ProviderListItemCopyWithImpl<$Res>
    implements _$ProviderListItemCopyWith<$Res> {
  __$ProviderListItemCopyWithImpl(this._self, this._then);

  final _ProviderListItem _self;
  final $Res Function(_ProviderListItem) _then;

/// Create a copy of ProviderListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? companyName = null,Object? email = null,Object? verificationStatus = null,Object? createdAt = null,Object? verificationDate = freezed,Object? averageRating = freezed,Object? totalServices = freezed,Object? isActive = freezed,}) {
  return _then(_ProviderListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as ProviderVerificationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,verificationDate: freezed == verificationDate ? _self.verificationDate : verificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,totalServices: freezed == totalServices ? _self.totalServices : totalServices // ignore: cast_nullable_to_non_nullable
as int?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ProviderRequest {

 String get companyName; String? get registrationNumber; String? get companyWebsite; int? get yearsInBusiness; String? get taxIdentificationNumber; String? get notes;// User data
 String get email; String get firstName; String get lastName; String? get phoneNumber;
/// Create a copy of ProviderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderRequestCopyWith<ProviderRequest> get copyWith => _$ProviderRequestCopyWithImpl<ProviderRequest>(this as ProviderRequest, _$identity);

  /// Serializes this ProviderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderRequest&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.companyWebsite, companyWebsite) || other.companyWebsite == companyWebsite)&&(identical(other.yearsInBusiness, yearsInBusiness) || other.yearsInBusiness == yearsInBusiness)&&(identical(other.taxIdentificationNumber, taxIdentificationNumber) || other.taxIdentificationNumber == taxIdentificationNumber)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyName,registrationNumber,companyWebsite,yearsInBusiness,taxIdentificationNumber,notes,email,firstName,lastName,phoneNumber);

@override
String toString() {
  return 'ProviderRequest(companyName: $companyName, registrationNumber: $registrationNumber, companyWebsite: $companyWebsite, yearsInBusiness: $yearsInBusiness, taxIdentificationNumber: $taxIdentificationNumber, notes: $notes, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $ProviderRequestCopyWith<$Res>  {
  factory $ProviderRequestCopyWith(ProviderRequest value, $Res Function(ProviderRequest) _then) = _$ProviderRequestCopyWithImpl;
@useResult
$Res call({
 String companyName, String? registrationNumber, String? companyWebsite, int? yearsInBusiness, String? taxIdentificationNumber, String? notes, String email, String firstName, String lastName, String? phoneNumber
});




}
/// @nodoc
class _$ProviderRequestCopyWithImpl<$Res>
    implements $ProviderRequestCopyWith<$Res> {
  _$ProviderRequestCopyWithImpl(this._self, this._then);

  final ProviderRequest _self;
  final $Res Function(ProviderRequest) _then;

/// Create a copy of ProviderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? companyName = null,Object? registrationNumber = freezed,Object? companyWebsite = freezed,Object? yearsInBusiness = freezed,Object? taxIdentificationNumber = freezed,Object? notes = freezed,Object? email = null,Object? firstName = null,Object? lastName = null,Object? phoneNumber = freezed,}) {
  return _then(_self.copyWith(
companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,companyWebsite: freezed == companyWebsite ? _self.companyWebsite : companyWebsite // ignore: cast_nullable_to_non_nullable
as String?,yearsInBusiness: freezed == yearsInBusiness ? _self.yearsInBusiness : yearsInBusiness // ignore: cast_nullable_to_non_nullable
as int?,taxIdentificationNumber: freezed == taxIdentificationNumber ? _self.taxIdentificationNumber : taxIdentificationNumber // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProviderRequest implements ProviderRequest {
  const _ProviderRequest({required this.companyName, this.registrationNumber, this.companyWebsite, this.yearsInBusiness, this.taxIdentificationNumber, this.notes, required this.email, required this.firstName, required this.lastName, this.phoneNumber});
  factory _ProviderRequest.fromJson(Map<String, dynamic> json) => _$ProviderRequestFromJson(json);

@override final  String companyName;
@override final  String? registrationNumber;
@override final  String? companyWebsite;
@override final  int? yearsInBusiness;
@override final  String? taxIdentificationNumber;
@override final  String? notes;
// User data
@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  String? phoneNumber;

/// Create a copy of ProviderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderRequestCopyWith<_ProviderRequest> get copyWith => __$ProviderRequestCopyWithImpl<_ProviderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderRequest&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.companyWebsite, companyWebsite) || other.companyWebsite == companyWebsite)&&(identical(other.yearsInBusiness, yearsInBusiness) || other.yearsInBusiness == yearsInBusiness)&&(identical(other.taxIdentificationNumber, taxIdentificationNumber) || other.taxIdentificationNumber == taxIdentificationNumber)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyName,registrationNumber,companyWebsite,yearsInBusiness,taxIdentificationNumber,notes,email,firstName,lastName,phoneNumber);

@override
String toString() {
  return 'ProviderRequest(companyName: $companyName, registrationNumber: $registrationNumber, companyWebsite: $companyWebsite, yearsInBusiness: $yearsInBusiness, taxIdentificationNumber: $taxIdentificationNumber, notes: $notes, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$ProviderRequestCopyWith<$Res> implements $ProviderRequestCopyWith<$Res> {
  factory _$ProviderRequestCopyWith(_ProviderRequest value, $Res Function(_ProviderRequest) _then) = __$ProviderRequestCopyWithImpl;
@override @useResult
$Res call({
 String companyName, String? registrationNumber, String? companyWebsite, int? yearsInBusiness, String? taxIdentificationNumber, String? notes, String email, String firstName, String lastName, String? phoneNumber
});




}
/// @nodoc
class __$ProviderRequestCopyWithImpl<$Res>
    implements _$ProviderRequestCopyWith<$Res> {
  __$ProviderRequestCopyWithImpl(this._self, this._then);

  final _ProviderRequest _self;
  final $Res Function(_ProviderRequest) _then;

/// Create a copy of ProviderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? companyName = null,Object? registrationNumber = freezed,Object? companyWebsite = freezed,Object? yearsInBusiness = freezed,Object? taxIdentificationNumber = freezed,Object? notes = freezed,Object? email = null,Object? firstName = null,Object? lastName = null,Object? phoneNumber = freezed,}) {
  return _then(_ProviderRequest(
companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,companyWebsite: freezed == companyWebsite ? _self.companyWebsite : companyWebsite // ignore: cast_nullable_to_non_nullable
as String?,yearsInBusiness: freezed == yearsInBusiness ? _self.yearsInBusiness : yearsInBusiness // ignore: cast_nullable_to_non_nullable
as int?,taxIdentificationNumber: freezed == taxIdentificationNumber ? _self.taxIdentificationNumber : taxIdentificationNumber // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VerifyProviderRequest {

 String get providerId; bool get isApproved; String? get comments; String get verifiedByAdminId;
/// Create a copy of VerifyProviderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyProviderRequestCopyWith<VerifyProviderRequest> get copyWith => _$VerifyProviderRequestCopyWithImpl<VerifyProviderRequest>(this as VerifyProviderRequest, _$identity);

  /// Serializes this VerifyProviderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyProviderRequest&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.verifiedByAdminId, verifiedByAdminId) || other.verifiedByAdminId == verifiedByAdminId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,providerId,isApproved,comments,verifiedByAdminId);

@override
String toString() {
  return 'VerifyProviderRequest(providerId: $providerId, isApproved: $isApproved, comments: $comments, verifiedByAdminId: $verifiedByAdminId)';
}


}

/// @nodoc
abstract mixin class $VerifyProviderRequestCopyWith<$Res>  {
  factory $VerifyProviderRequestCopyWith(VerifyProviderRequest value, $Res Function(VerifyProviderRequest) _then) = _$VerifyProviderRequestCopyWithImpl;
@useResult
$Res call({
 String providerId, bool isApproved, String? comments, String verifiedByAdminId
});




}
/// @nodoc
class _$VerifyProviderRequestCopyWithImpl<$Res>
    implements $VerifyProviderRequestCopyWith<$Res> {
  _$VerifyProviderRequestCopyWithImpl(this._self, this._then);

  final VerifyProviderRequest _self;
  final $Res Function(VerifyProviderRequest) _then;

/// Create a copy of VerifyProviderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? providerId = null,Object? isApproved = null,Object? comments = freezed,Object? verifiedByAdminId = null,}) {
  return _then(_self.copyWith(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as String?,verifiedByAdminId: null == verifiedByAdminId ? _self.verifiedByAdminId : verifiedByAdminId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _VerifyProviderRequest implements VerifyProviderRequest {
  const _VerifyProviderRequest({required this.providerId, required this.isApproved, this.comments, required this.verifiedByAdminId});
  factory _VerifyProviderRequest.fromJson(Map<String, dynamic> json) => _$VerifyProviderRequestFromJson(json);

@override final  String providerId;
@override final  bool isApproved;
@override final  String? comments;
@override final  String verifiedByAdminId;

/// Create a copy of VerifyProviderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyProviderRequestCopyWith<_VerifyProviderRequest> get copyWith => __$VerifyProviderRequestCopyWithImpl<_VerifyProviderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyProviderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyProviderRequest&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.verifiedByAdminId, verifiedByAdminId) || other.verifiedByAdminId == verifiedByAdminId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,providerId,isApproved,comments,verifiedByAdminId);

@override
String toString() {
  return 'VerifyProviderRequest(providerId: $providerId, isApproved: $isApproved, comments: $comments, verifiedByAdminId: $verifiedByAdminId)';
}


}

/// @nodoc
abstract mixin class _$VerifyProviderRequestCopyWith<$Res> implements $VerifyProviderRequestCopyWith<$Res> {
  factory _$VerifyProviderRequestCopyWith(_VerifyProviderRequest value, $Res Function(_VerifyProviderRequest) _then) = __$VerifyProviderRequestCopyWithImpl;
@override @useResult
$Res call({
 String providerId, bool isApproved, String? comments, String verifiedByAdminId
});




}
/// @nodoc
class __$VerifyProviderRequestCopyWithImpl<$Res>
    implements _$VerifyProviderRequestCopyWith<$Res> {
  __$VerifyProviderRequestCopyWithImpl(this._self, this._then);

  final _VerifyProviderRequest _self;
  final $Res Function(_VerifyProviderRequest) _then;

/// Create a copy of VerifyProviderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? providerId = null,Object? isApproved = null,Object? comments = freezed,Object? verifiedByAdminId = null,}) {
  return _then(_VerifyProviderRequest(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as String?,verifiedByAdminId: null == verifiedByAdminId ? _self.verifiedByAdminId : verifiedByAdminId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProviderPerformanceMetrics {

 String get providerId; double get averageRating; int get totalServices; int get totalOrders; int get completedOrders; double get completionRate; double get averageResponseTime; Map<String, int> get ratingDistribution; List<CustomerFeedback> get recentFeedback;
/// Create a copy of ProviderPerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderPerformanceMetricsCopyWith<ProviderPerformanceMetrics> get copyWith => _$ProviderPerformanceMetricsCopyWithImpl<ProviderPerformanceMetrics>(this as ProviderPerformanceMetrics, _$identity);

  /// Serializes this ProviderPerformanceMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderPerformanceMetrics&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalServices, totalServices) || other.totalServices == totalServices)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&const DeepCollectionEquality().equals(other.ratingDistribution, ratingDistribution)&&const DeepCollectionEquality().equals(other.recentFeedback, recentFeedback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,providerId,averageRating,totalServices,totalOrders,completedOrders,completionRate,averageResponseTime,const DeepCollectionEquality().hash(ratingDistribution),const DeepCollectionEquality().hash(recentFeedback));

@override
String toString() {
  return 'ProviderPerformanceMetrics(providerId: $providerId, averageRating: $averageRating, totalServices: $totalServices, totalOrders: $totalOrders, completedOrders: $completedOrders, completionRate: $completionRate, averageResponseTime: $averageResponseTime, ratingDistribution: $ratingDistribution, recentFeedback: $recentFeedback)';
}


}

/// @nodoc
abstract mixin class $ProviderPerformanceMetricsCopyWith<$Res>  {
  factory $ProviderPerformanceMetricsCopyWith(ProviderPerformanceMetrics value, $Res Function(ProviderPerformanceMetrics) _then) = _$ProviderPerformanceMetricsCopyWithImpl;
@useResult
$Res call({
 String providerId, double averageRating, int totalServices, int totalOrders, int completedOrders, double completionRate, double averageResponseTime, Map<String, int> ratingDistribution, List<CustomerFeedback> recentFeedback
});




}
/// @nodoc
class _$ProviderPerformanceMetricsCopyWithImpl<$Res>
    implements $ProviderPerformanceMetricsCopyWith<$Res> {
  _$ProviderPerformanceMetricsCopyWithImpl(this._self, this._then);

  final ProviderPerformanceMetrics _self;
  final $Res Function(ProviderPerformanceMetrics) _then;

/// Create a copy of ProviderPerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? providerId = null,Object? averageRating = null,Object? totalServices = null,Object? totalOrders = null,Object? completedOrders = null,Object? completionRate = null,Object? averageResponseTime = null,Object? ratingDistribution = null,Object? recentFeedback = null,}) {
  return _then(_self.copyWith(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalServices: null == totalServices ? _self.totalServices : totalServices // ignore: cast_nullable_to_non_nullable
as int,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,completedOrders: null == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as double,ratingDistribution: null == ratingDistribution ? _self.ratingDistribution : ratingDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, int>,recentFeedback: null == recentFeedback ? _self.recentFeedback : recentFeedback // ignore: cast_nullable_to_non_nullable
as List<CustomerFeedback>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProviderPerformanceMetrics implements ProviderPerformanceMetrics {
  const _ProviderPerformanceMetrics({required this.providerId, required this.averageRating, required this.totalServices, required this.totalOrders, required this.completedOrders, required this.completionRate, required this.averageResponseTime, required final  Map<String, int> ratingDistribution, required final  List<CustomerFeedback> recentFeedback}): _ratingDistribution = ratingDistribution,_recentFeedback = recentFeedback;
  factory _ProviderPerformanceMetrics.fromJson(Map<String, dynamic> json) => _$ProviderPerformanceMetricsFromJson(json);

@override final  String providerId;
@override final  double averageRating;
@override final  int totalServices;
@override final  int totalOrders;
@override final  int completedOrders;
@override final  double completionRate;
@override final  double averageResponseTime;
 final  Map<String, int> _ratingDistribution;
@override Map<String, int> get ratingDistribution {
  if (_ratingDistribution is EqualUnmodifiableMapView) return _ratingDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratingDistribution);
}

 final  List<CustomerFeedback> _recentFeedback;
@override List<CustomerFeedback> get recentFeedback {
  if (_recentFeedback is EqualUnmodifiableListView) return _recentFeedback;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentFeedback);
}


/// Create a copy of ProviderPerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderPerformanceMetricsCopyWith<_ProviderPerformanceMetrics> get copyWith => __$ProviderPerformanceMetricsCopyWithImpl<_ProviderPerformanceMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderPerformanceMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderPerformanceMetrics&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalServices, totalServices) || other.totalServices == totalServices)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.averageResponseTime, averageResponseTime) || other.averageResponseTime == averageResponseTime)&&const DeepCollectionEquality().equals(other._ratingDistribution, _ratingDistribution)&&const DeepCollectionEquality().equals(other._recentFeedback, _recentFeedback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,providerId,averageRating,totalServices,totalOrders,completedOrders,completionRate,averageResponseTime,const DeepCollectionEquality().hash(_ratingDistribution),const DeepCollectionEquality().hash(_recentFeedback));

@override
String toString() {
  return 'ProviderPerformanceMetrics(providerId: $providerId, averageRating: $averageRating, totalServices: $totalServices, totalOrders: $totalOrders, completedOrders: $completedOrders, completionRate: $completionRate, averageResponseTime: $averageResponseTime, ratingDistribution: $ratingDistribution, recentFeedback: $recentFeedback)';
}


}

/// @nodoc
abstract mixin class _$ProviderPerformanceMetricsCopyWith<$Res> implements $ProviderPerformanceMetricsCopyWith<$Res> {
  factory _$ProviderPerformanceMetricsCopyWith(_ProviderPerformanceMetrics value, $Res Function(_ProviderPerformanceMetrics) _then) = __$ProviderPerformanceMetricsCopyWithImpl;
@override @useResult
$Res call({
 String providerId, double averageRating, int totalServices, int totalOrders, int completedOrders, double completionRate, double averageResponseTime, Map<String, int> ratingDistribution, List<CustomerFeedback> recentFeedback
});




}
/// @nodoc
class __$ProviderPerformanceMetricsCopyWithImpl<$Res>
    implements _$ProviderPerformanceMetricsCopyWith<$Res> {
  __$ProviderPerformanceMetricsCopyWithImpl(this._self, this._then);

  final _ProviderPerformanceMetrics _self;
  final $Res Function(_ProviderPerformanceMetrics) _then;

/// Create a copy of ProviderPerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? providerId = null,Object? averageRating = null,Object? totalServices = null,Object? totalOrders = null,Object? completedOrders = null,Object? completionRate = null,Object? averageResponseTime = null,Object? ratingDistribution = null,Object? recentFeedback = null,}) {
  return _then(_ProviderPerformanceMetrics(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalServices: null == totalServices ? _self.totalServices : totalServices // ignore: cast_nullable_to_non_nullable
as int,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,completedOrders: null == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,averageResponseTime: null == averageResponseTime ? _self.averageResponseTime : averageResponseTime // ignore: cast_nullable_to_non_nullable
as double,ratingDistribution: null == ratingDistribution ? _self._ratingDistribution : ratingDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, int>,recentFeedback: null == recentFeedback ? _self._recentFeedback : recentFeedback // ignore: cast_nullable_to_non_nullable
as List<CustomerFeedback>,
  ));
}


}


/// @nodoc
mixin _$CustomerFeedback {

 String get id; String get customerName; int get rating; String? get comment; DateTime get createdAt; String get serviceTitle;
/// Create a copy of CustomerFeedback
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerFeedbackCopyWith<CustomerFeedback> get copyWith => _$CustomerFeedbackCopyWithImpl<CustomerFeedback>(this as CustomerFeedback, _$identity);

  /// Serializes this CustomerFeedback to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerFeedback&&(identical(other.id, id) || other.id == id)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerName,rating,comment,createdAt,serviceTitle);

@override
String toString() {
  return 'CustomerFeedback(id: $id, customerName: $customerName, rating: $rating, comment: $comment, createdAt: $createdAt, serviceTitle: $serviceTitle)';
}


}

/// @nodoc
abstract mixin class $CustomerFeedbackCopyWith<$Res>  {
  factory $CustomerFeedbackCopyWith(CustomerFeedback value, $Res Function(CustomerFeedback) _then) = _$CustomerFeedbackCopyWithImpl;
@useResult
$Res call({
 String id, String customerName, int rating, String? comment, DateTime createdAt, String serviceTitle
});




}
/// @nodoc
class _$CustomerFeedbackCopyWithImpl<$Res>
    implements $CustomerFeedbackCopyWith<$Res> {
  _$CustomerFeedbackCopyWithImpl(this._self, this._then);

  final CustomerFeedback _self;
  final $Res Function(CustomerFeedback) _then;

/// Create a copy of CustomerFeedback
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerName = null,Object? rating = null,Object? comment = freezed,Object? createdAt = null,Object? serviceTitle = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,serviceTitle: null == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CustomerFeedback implements CustomerFeedback {
  const _CustomerFeedback({required this.id, required this.customerName, required this.rating, this.comment, required this.createdAt, required this.serviceTitle});
  factory _CustomerFeedback.fromJson(Map<String, dynamic> json) => _$CustomerFeedbackFromJson(json);

@override final  String id;
@override final  String customerName;
@override final  int rating;
@override final  String? comment;
@override final  DateTime createdAt;
@override final  String serviceTitle;

/// Create a copy of CustomerFeedback
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerFeedbackCopyWith<_CustomerFeedback> get copyWith => __$CustomerFeedbackCopyWithImpl<_CustomerFeedback>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerFeedbackToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerFeedback&&(identical(other.id, id) || other.id == id)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerName,rating,comment,createdAt,serviceTitle);

@override
String toString() {
  return 'CustomerFeedback(id: $id, customerName: $customerName, rating: $rating, comment: $comment, createdAt: $createdAt, serviceTitle: $serviceTitle)';
}


}

/// @nodoc
abstract mixin class _$CustomerFeedbackCopyWith<$Res> implements $CustomerFeedbackCopyWith<$Res> {
  factory _$CustomerFeedbackCopyWith(_CustomerFeedback value, $Res Function(_CustomerFeedback) _then) = __$CustomerFeedbackCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerName, int rating, String? comment, DateTime createdAt, String serviceTitle
});




}
/// @nodoc
class __$CustomerFeedbackCopyWithImpl<$Res>
    implements _$CustomerFeedbackCopyWith<$Res> {
  __$CustomerFeedbackCopyWithImpl(this._self, this._then);

  final _CustomerFeedback _self;
  final $Res Function(_CustomerFeedback) _then;

/// Create a copy of CustomerFeedback
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerName = null,Object? rating = null,Object? comment = freezed,Object? createdAt = null,Object? serviceTitle = null,}) {
  return _then(_CustomerFeedback(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,serviceTitle: null == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
