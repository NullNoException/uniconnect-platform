// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceRequest {

 String get id; String get studentId; String get serviceId; String get serviceName; String get studentName; String get providerName; ServiceRequestStatus get status; DateTime get initiatedDate; DateTime? get requiredByDate; DateTime? get expectedCompletionDate; DateTime? get completedDate; DateTime? get cancelledDate; String? get cancellationReason; String? get description; String? get notes; String? get assignedAdminId; double get totalAmount; String get currency; List<RequestDocument> get documents; List<RequestMilestone> get milestones; List<ServiceRequestTransaction> get transactions; List<ServiceRequestReview> get reviews; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ServiceRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestCopyWith<ServiceRequest> get copyWith => _$ServiceRequestCopyWithImpl<ServiceRequest>(this as ServiceRequest, _$identity);

  /// Serializes this ServiceRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.status, status) || other.status == status)&&(identical(other.initiatedDate, initiatedDate) || other.initiatedDate == initiatedDate)&&(identical(other.requiredByDate, requiredByDate) || other.requiredByDate == requiredByDate)&&(identical(other.expectedCompletionDate, expectedCompletionDate) || other.expectedCompletionDate == expectedCompletionDate)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.cancelledDate, cancelledDate) || other.cancelledDate == cancelledDate)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.description, description) || other.description == description)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.assignedAdminId, assignedAdminId) || other.assignedAdminId == assignedAdminId)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.documents, documents)&&const DeepCollectionEquality().equals(other.milestones, milestones)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,studentId,serviceId,serviceName,studentName,providerName,status,initiatedDate,requiredByDate,expectedCompletionDate,completedDate,cancelledDate,cancellationReason,description,notes,assignedAdminId,totalAmount,currency,const DeepCollectionEquality().hash(documents),const DeepCollectionEquality().hash(milestones),const DeepCollectionEquality().hash(transactions),const DeepCollectionEquality().hash(reviews),createdAt,updatedAt]);

@override
String toString() {
  return 'ServiceRequest(id: $id, studentId: $studentId, serviceId: $serviceId, serviceName: $serviceName, studentName: $studentName, providerName: $providerName, status: $status, initiatedDate: $initiatedDate, requiredByDate: $requiredByDate, expectedCompletionDate: $expectedCompletionDate, completedDate: $completedDate, cancelledDate: $cancelledDate, cancellationReason: $cancellationReason, description: $description, notes: $notes, assignedAdminId: $assignedAdminId, totalAmount: $totalAmount, currency: $currency, documents: $documents, milestones: $milestones, transactions: $transactions, reviews: $reviews, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestCopyWith<$Res>  {
  factory $ServiceRequestCopyWith(ServiceRequest value, $Res Function(ServiceRequest) _then) = _$ServiceRequestCopyWithImpl;
@useResult
$Res call({
 String id, String studentId, String serviceId, String serviceName, String studentName, String providerName, ServiceRequestStatus status, DateTime initiatedDate, DateTime? requiredByDate, DateTime? expectedCompletionDate, DateTime? completedDate, DateTime? cancelledDate, String? cancellationReason, String? description, String? notes, String? assignedAdminId, double totalAmount, String currency, List<RequestDocument> documents, List<RequestMilestone> milestones, List<ServiceRequestTransaction> transactions, List<ServiceRequestReview> reviews, DateTime createdAt, DateTime updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentId = null,Object? serviceId = null,Object? serviceName = null,Object? studentName = null,Object? providerName = null,Object? status = null,Object? initiatedDate = null,Object? requiredByDate = freezed,Object? expectedCompletionDate = freezed,Object? completedDate = freezed,Object? cancelledDate = freezed,Object? cancellationReason = freezed,Object? description = freezed,Object? notes = freezed,Object? assignedAdminId = freezed,Object? totalAmount = null,Object? currency = null,Object? documents = null,Object? milestones = null,Object? transactions = null,Object? reviews = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus,initiatedDate: null == initiatedDate ? _self.initiatedDate : initiatedDate // ignore: cast_nullable_to_non_nullable
as DateTime,requiredByDate: freezed == requiredByDate ? _self.requiredByDate : requiredByDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedCompletionDate: freezed == expectedCompletionDate ? _self.expectedCompletionDate : expectedCompletionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledDate: freezed == cancelledDate ? _self.cancelledDate : cancelledDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,assignedAdminId: freezed == assignedAdminId ? _self.assignedAdminId : assignedAdminId // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<RequestDocument>,milestones: null == milestones ? _self.milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<RequestMilestone>,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestTransaction>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestReview>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequest implements ServiceRequest {
  const _ServiceRequest({required this.id, required this.studentId, required this.serviceId, required this.serviceName, required this.studentName, required this.providerName, required this.status, required this.initiatedDate, this.requiredByDate, this.expectedCompletionDate, this.completedDate, this.cancelledDate, this.cancellationReason, this.description, this.notes, this.assignedAdminId, required this.totalAmount, required this.currency, final  List<RequestDocument> documents = const [], final  List<RequestMilestone> milestones = const [], final  List<ServiceRequestTransaction> transactions = const [], final  List<ServiceRequestReview> reviews = const [], required this.createdAt, required this.updatedAt}): _documents = documents,_milestones = milestones,_transactions = transactions,_reviews = reviews;
  factory _ServiceRequest.fromJson(Map<String, dynamic> json) => _$ServiceRequestFromJson(json);

@override final  String id;
@override final  String studentId;
@override final  String serviceId;
@override final  String serviceName;
@override final  String studentName;
@override final  String providerName;
@override final  ServiceRequestStatus status;
@override final  DateTime initiatedDate;
@override final  DateTime? requiredByDate;
@override final  DateTime? expectedCompletionDate;
@override final  DateTime? completedDate;
@override final  DateTime? cancelledDate;
@override final  String? cancellationReason;
@override final  String? description;
@override final  String? notes;
@override final  String? assignedAdminId;
@override final  double totalAmount;
@override final  String currency;
 final  List<RequestDocument> _documents;
@override@JsonKey() List<RequestDocument> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

 final  List<RequestMilestone> _milestones;
@override@JsonKey() List<RequestMilestone> get milestones {
  if (_milestones is EqualUnmodifiableListView) return _milestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_milestones);
}

 final  List<ServiceRequestTransaction> _transactions;
@override@JsonKey() List<ServiceRequestTransaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

 final  List<ServiceRequestReview> _reviews;
@override@JsonKey() List<ServiceRequestReview> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.status, status) || other.status == status)&&(identical(other.initiatedDate, initiatedDate) || other.initiatedDate == initiatedDate)&&(identical(other.requiredByDate, requiredByDate) || other.requiredByDate == requiredByDate)&&(identical(other.expectedCompletionDate, expectedCompletionDate) || other.expectedCompletionDate == expectedCompletionDate)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.cancelledDate, cancelledDate) || other.cancelledDate == cancelledDate)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.description, description) || other.description == description)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.assignedAdminId, assignedAdminId) || other.assignedAdminId == assignedAdminId)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._documents, _documents)&&const DeepCollectionEquality().equals(other._milestones, _milestones)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,studentId,serviceId,serviceName,studentName,providerName,status,initiatedDate,requiredByDate,expectedCompletionDate,completedDate,cancelledDate,cancellationReason,description,notes,assignedAdminId,totalAmount,currency,const DeepCollectionEquality().hash(_documents),const DeepCollectionEquality().hash(_milestones),const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_reviews),createdAt,updatedAt]);

@override
String toString() {
  return 'ServiceRequest(id: $id, studentId: $studentId, serviceId: $serviceId, serviceName: $serviceName, studentName: $studentName, providerName: $providerName, status: $status, initiatedDate: $initiatedDate, requiredByDate: $requiredByDate, expectedCompletionDate: $expectedCompletionDate, completedDate: $completedDate, cancelledDate: $cancelledDate, cancellationReason: $cancellationReason, description: $description, notes: $notes, assignedAdminId: $assignedAdminId, totalAmount: $totalAmount, currency: $currency, documents: $documents, milestones: $milestones, transactions: $transactions, reviews: $reviews, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestCopyWith<$Res> implements $ServiceRequestCopyWith<$Res> {
  factory _$ServiceRequestCopyWith(_ServiceRequest value, $Res Function(_ServiceRequest) _then) = __$ServiceRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String studentId, String serviceId, String serviceName, String studentName, String providerName, ServiceRequestStatus status, DateTime initiatedDate, DateTime? requiredByDate, DateTime? expectedCompletionDate, DateTime? completedDate, DateTime? cancelledDate, String? cancellationReason, String? description, String? notes, String? assignedAdminId, double totalAmount, String currency, List<RequestDocument> documents, List<RequestMilestone> milestones, List<ServiceRequestTransaction> transactions, List<ServiceRequestReview> reviews, DateTime createdAt, DateTime updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentId = null,Object? serviceId = null,Object? serviceName = null,Object? studentName = null,Object? providerName = null,Object? status = null,Object? initiatedDate = null,Object? requiredByDate = freezed,Object? expectedCompletionDate = freezed,Object? completedDate = freezed,Object? cancelledDate = freezed,Object? cancellationReason = freezed,Object? description = freezed,Object? notes = freezed,Object? assignedAdminId = freezed,Object? totalAmount = null,Object? currency = null,Object? documents = null,Object? milestones = null,Object? transactions = null,Object? reviews = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ServiceRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus,initiatedDate: null == initiatedDate ? _self.initiatedDate : initiatedDate // ignore: cast_nullable_to_non_nullable
as DateTime,requiredByDate: freezed == requiredByDate ? _self.requiredByDate : requiredByDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedCompletionDate: freezed == expectedCompletionDate ? _self.expectedCompletionDate : expectedCompletionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledDate: freezed == cancelledDate ? _self.cancelledDate : cancelledDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,assignedAdminId: freezed == assignedAdminId ? _self.assignedAdminId : assignedAdminId // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<RequestDocument>,milestones: null == milestones ? _self._milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<RequestMilestone>,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestTransaction>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestReview>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ServiceRequestListItem {

 String get id; String get studentId; String get serviceId; String get serviceName; String get studentName; String get providerName; ServiceRequestStatus get status; DateTime get initiatedDate; DateTime? get requiredByDate; DateTime? get completedDate; double get totalAmount; String get currency; int get documentsCount; int get milestonesCount; bool get hasUnreadMessages; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ServiceRequestListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestListItemCopyWith<ServiceRequestListItem> get copyWith => _$ServiceRequestListItemCopyWithImpl<ServiceRequestListItem>(this as ServiceRequestListItem, _$identity);

  /// Serializes this ServiceRequestListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.status, status) || other.status == status)&&(identical(other.initiatedDate, initiatedDate) || other.initiatedDate == initiatedDate)&&(identical(other.requiredByDate, requiredByDate) || other.requiredByDate == requiredByDate)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.documentsCount, documentsCount) || other.documentsCount == documentsCount)&&(identical(other.milestonesCount, milestonesCount) || other.milestonesCount == milestonesCount)&&(identical(other.hasUnreadMessages, hasUnreadMessages) || other.hasUnreadMessages == hasUnreadMessages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,studentId,serviceId,serviceName,studentName,providerName,status,initiatedDate,requiredByDate,completedDate,totalAmount,currency,documentsCount,milestonesCount,hasUnreadMessages,createdAt,updatedAt);

@override
String toString() {
  return 'ServiceRequestListItem(id: $id, studentId: $studentId, serviceId: $serviceId, serviceName: $serviceName, studentName: $studentName, providerName: $providerName, status: $status, initiatedDate: $initiatedDate, requiredByDate: $requiredByDate, completedDate: $completedDate, totalAmount: $totalAmount, currency: $currency, documentsCount: $documentsCount, milestonesCount: $milestonesCount, hasUnreadMessages: $hasUnreadMessages, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestListItemCopyWith<$Res>  {
  factory $ServiceRequestListItemCopyWith(ServiceRequestListItem value, $Res Function(ServiceRequestListItem) _then) = _$ServiceRequestListItemCopyWithImpl;
@useResult
$Res call({
 String id, String studentId, String serviceId, String serviceName, String studentName, String providerName, ServiceRequestStatus status, DateTime initiatedDate, DateTime? requiredByDate, DateTime? completedDate, double totalAmount, String currency, int documentsCount, int milestonesCount, bool hasUnreadMessages, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ServiceRequestListItemCopyWithImpl<$Res>
    implements $ServiceRequestListItemCopyWith<$Res> {
  _$ServiceRequestListItemCopyWithImpl(this._self, this._then);

  final ServiceRequestListItem _self;
  final $Res Function(ServiceRequestListItem) _then;

/// Create a copy of ServiceRequestListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentId = null,Object? serviceId = null,Object? serviceName = null,Object? studentName = null,Object? providerName = null,Object? status = null,Object? initiatedDate = null,Object? requiredByDate = freezed,Object? completedDate = freezed,Object? totalAmount = null,Object? currency = null,Object? documentsCount = null,Object? milestonesCount = null,Object? hasUnreadMessages = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus,initiatedDate: null == initiatedDate ? _self.initiatedDate : initiatedDate // ignore: cast_nullable_to_non_nullable
as DateTime,requiredByDate: freezed == requiredByDate ? _self.requiredByDate : requiredByDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,documentsCount: null == documentsCount ? _self.documentsCount : documentsCount // ignore: cast_nullable_to_non_nullable
as int,milestonesCount: null == milestonesCount ? _self.milestonesCount : milestonesCount // ignore: cast_nullable_to_non_nullable
as int,hasUnreadMessages: null == hasUnreadMessages ? _self.hasUnreadMessages : hasUnreadMessages // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequestListItem implements ServiceRequestListItem {
  const _ServiceRequestListItem({required this.id, required this.studentId, required this.serviceId, required this.serviceName, required this.studentName, required this.providerName, required this.status, required this.initiatedDate, this.requiredByDate, this.completedDate, required this.totalAmount, required this.currency, required this.documentsCount, required this.milestonesCount, required this.hasUnreadMessages, required this.createdAt, required this.updatedAt});
  factory _ServiceRequestListItem.fromJson(Map<String, dynamic> json) => _$ServiceRequestListItemFromJson(json);

@override final  String id;
@override final  String studentId;
@override final  String serviceId;
@override final  String serviceName;
@override final  String studentName;
@override final  String providerName;
@override final  ServiceRequestStatus status;
@override final  DateTime initiatedDate;
@override final  DateTime? requiredByDate;
@override final  DateTime? completedDate;
@override final  double totalAmount;
@override final  String currency;
@override final  int documentsCount;
@override final  int milestonesCount;
@override final  bool hasUnreadMessages;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ServiceRequestListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestListItemCopyWith<_ServiceRequestListItem> get copyWith => __$ServiceRequestListItemCopyWithImpl<_ServiceRequestListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequestListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.status, status) || other.status == status)&&(identical(other.initiatedDate, initiatedDate) || other.initiatedDate == initiatedDate)&&(identical(other.requiredByDate, requiredByDate) || other.requiredByDate == requiredByDate)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.documentsCount, documentsCount) || other.documentsCount == documentsCount)&&(identical(other.milestonesCount, milestonesCount) || other.milestonesCount == milestonesCount)&&(identical(other.hasUnreadMessages, hasUnreadMessages) || other.hasUnreadMessages == hasUnreadMessages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,studentId,serviceId,serviceName,studentName,providerName,status,initiatedDate,requiredByDate,completedDate,totalAmount,currency,documentsCount,milestonesCount,hasUnreadMessages,createdAt,updatedAt);

@override
String toString() {
  return 'ServiceRequestListItem(id: $id, studentId: $studentId, serviceId: $serviceId, serviceName: $serviceName, studentName: $studentName, providerName: $providerName, status: $status, initiatedDate: $initiatedDate, requiredByDate: $requiredByDate, completedDate: $completedDate, totalAmount: $totalAmount, currency: $currency, documentsCount: $documentsCount, milestonesCount: $milestonesCount, hasUnreadMessages: $hasUnreadMessages, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestListItemCopyWith<$Res> implements $ServiceRequestListItemCopyWith<$Res> {
  factory _$ServiceRequestListItemCopyWith(_ServiceRequestListItem value, $Res Function(_ServiceRequestListItem) _then) = __$ServiceRequestListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String studentId, String serviceId, String serviceName, String studentName, String providerName, ServiceRequestStatus status, DateTime initiatedDate, DateTime? requiredByDate, DateTime? completedDate, double totalAmount, String currency, int documentsCount, int milestonesCount, bool hasUnreadMessages, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ServiceRequestListItemCopyWithImpl<$Res>
    implements _$ServiceRequestListItemCopyWith<$Res> {
  __$ServiceRequestListItemCopyWithImpl(this._self, this._then);

  final _ServiceRequestListItem _self;
  final $Res Function(_ServiceRequestListItem) _then;

/// Create a copy of ServiceRequestListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentId = null,Object? serviceId = null,Object? serviceName = null,Object? studentName = null,Object? providerName = null,Object? status = null,Object? initiatedDate = null,Object? requiredByDate = freezed,Object? completedDate = freezed,Object? totalAmount = null,Object? currency = null,Object? documentsCount = null,Object? milestonesCount = null,Object? hasUnreadMessages = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ServiceRequestListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus,initiatedDate: null == initiatedDate ? _self.initiatedDate : initiatedDate // ignore: cast_nullable_to_non_nullable
as DateTime,requiredByDate: freezed == requiredByDate ? _self.requiredByDate : requiredByDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,documentsCount: null == documentsCount ? _self.documentsCount : documentsCount // ignore: cast_nullable_to_non_nullable
as int,milestonesCount: null == milestonesCount ? _self.milestonesCount : milestonesCount // ignore: cast_nullable_to_non_nullable
as int,hasUnreadMessages: null == hasUnreadMessages ? _self.hasUnreadMessages : hasUnreadMessages // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$RequestDocument {

 String get id; String get requestId; String get documentTypeId; String get documentName; String get fileUrl; int get fileSize; DateTime get uploadDate; DocumentStatus get status; String? get verifiedById; DateTime? get verificationDate; String? get verificationNotes; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of RequestDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestDocumentCopyWith<RequestDocument> get copyWith => _$RequestDocumentCopyWithImpl<RequestDocument>(this as RequestDocument, _$identity);

  /// Serializes this RequestDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.documentTypeId, documentTypeId) || other.documentTypeId == documentTypeId)&&(identical(other.documentName, documentName) || other.documentName == documentName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.uploadDate, uploadDate) || other.uploadDate == uploadDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.verifiedById, verifiedById) || other.verifiedById == verifiedById)&&(identical(other.verificationDate, verificationDate) || other.verificationDate == verificationDate)&&(identical(other.verificationNotes, verificationNotes) || other.verificationNotes == verificationNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestId,documentTypeId,documentName,fileUrl,fileSize,uploadDate,status,verifiedById,verificationDate,verificationNotes,createdAt,updatedAt);

@override
String toString() {
  return 'RequestDocument(id: $id, requestId: $requestId, documentTypeId: $documentTypeId, documentName: $documentName, fileUrl: $fileUrl, fileSize: $fileSize, uploadDate: $uploadDate, status: $status, verifiedById: $verifiedById, verificationDate: $verificationDate, verificationNotes: $verificationNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RequestDocumentCopyWith<$Res>  {
  factory $RequestDocumentCopyWith(RequestDocument value, $Res Function(RequestDocument) _then) = _$RequestDocumentCopyWithImpl;
@useResult
$Res call({
 String id, String requestId, String documentTypeId, String documentName, String fileUrl, int fileSize, DateTime uploadDate, DocumentStatus status, String? verifiedById, DateTime? verificationDate, String? verificationNotes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$RequestDocumentCopyWithImpl<$Res>
    implements $RequestDocumentCopyWith<$Res> {
  _$RequestDocumentCopyWithImpl(this._self, this._then);

  final RequestDocument _self;
  final $Res Function(RequestDocument) _then;

/// Create a copy of RequestDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requestId = null,Object? documentTypeId = null,Object? documentName = null,Object? fileUrl = null,Object? fileSize = null,Object? uploadDate = null,Object? status = null,Object? verifiedById = freezed,Object? verificationDate = freezed,Object? verificationNotes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,documentTypeId: null == documentTypeId ? _self.documentTypeId : documentTypeId // ignore: cast_nullable_to_non_nullable
as String,documentName: null == documentName ? _self.documentName : documentName // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,uploadDate: null == uploadDate ? _self.uploadDate : uploadDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,verifiedById: freezed == verifiedById ? _self.verifiedById : verifiedById // ignore: cast_nullable_to_non_nullable
as String?,verificationDate: freezed == verificationDate ? _self.verificationDate : verificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,verificationNotes: freezed == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RequestDocument implements RequestDocument {
  const _RequestDocument({required this.id, required this.requestId, required this.documentTypeId, required this.documentName, required this.fileUrl, required this.fileSize, required this.uploadDate, required this.status, this.verifiedById, this.verificationDate, this.verificationNotes, required this.createdAt, required this.updatedAt});
  factory _RequestDocument.fromJson(Map<String, dynamic> json) => _$RequestDocumentFromJson(json);

@override final  String id;
@override final  String requestId;
@override final  String documentTypeId;
@override final  String documentName;
@override final  String fileUrl;
@override final  int fileSize;
@override final  DateTime uploadDate;
@override final  DocumentStatus status;
@override final  String? verifiedById;
@override final  DateTime? verificationDate;
@override final  String? verificationNotes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of RequestDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestDocumentCopyWith<_RequestDocument> get copyWith => __$RequestDocumentCopyWithImpl<_RequestDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.documentTypeId, documentTypeId) || other.documentTypeId == documentTypeId)&&(identical(other.documentName, documentName) || other.documentName == documentName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.uploadDate, uploadDate) || other.uploadDate == uploadDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.verifiedById, verifiedById) || other.verifiedById == verifiedById)&&(identical(other.verificationDate, verificationDate) || other.verificationDate == verificationDate)&&(identical(other.verificationNotes, verificationNotes) || other.verificationNotes == verificationNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestId,documentTypeId,documentName,fileUrl,fileSize,uploadDate,status,verifiedById,verificationDate,verificationNotes,createdAt,updatedAt);

@override
String toString() {
  return 'RequestDocument(id: $id, requestId: $requestId, documentTypeId: $documentTypeId, documentName: $documentName, fileUrl: $fileUrl, fileSize: $fileSize, uploadDate: $uploadDate, status: $status, verifiedById: $verifiedById, verificationDate: $verificationDate, verificationNotes: $verificationNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RequestDocumentCopyWith<$Res> implements $RequestDocumentCopyWith<$Res> {
  factory _$RequestDocumentCopyWith(_RequestDocument value, $Res Function(_RequestDocument) _then) = __$RequestDocumentCopyWithImpl;
@override @useResult
$Res call({
 String id, String requestId, String documentTypeId, String documentName, String fileUrl, int fileSize, DateTime uploadDate, DocumentStatus status, String? verifiedById, DateTime? verificationDate, String? verificationNotes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$RequestDocumentCopyWithImpl<$Res>
    implements _$RequestDocumentCopyWith<$Res> {
  __$RequestDocumentCopyWithImpl(this._self, this._then);

  final _RequestDocument _self;
  final $Res Function(_RequestDocument) _then;

/// Create a copy of RequestDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? requestId = null,Object? documentTypeId = null,Object? documentName = null,Object? fileUrl = null,Object? fileSize = null,Object? uploadDate = null,Object? status = null,Object? verifiedById = freezed,Object? verificationDate = freezed,Object? verificationNotes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RequestDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,documentTypeId: null == documentTypeId ? _self.documentTypeId : documentTypeId // ignore: cast_nullable_to_non_nullable
as String,documentName: null == documentName ? _self.documentName : documentName // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,uploadDate: null == uploadDate ? _self.uploadDate : uploadDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,verifiedById: freezed == verifiedById ? _self.verifiedById : verifiedById // ignore: cast_nullable_to_non_nullable
as String?,verificationDate: freezed == verificationDate ? _self.verificationDate : verificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,verificationNotes: freezed == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$RequestMilestone {

 String get id; String get requestId; String get milestoneName; String? get description; DateTime? get dueDate; DateTime? get completionDate; MilestoneStatus get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of RequestMilestone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestMilestoneCopyWith<RequestMilestone> get copyWith => _$RequestMilestoneCopyWithImpl<RequestMilestone>(this as RequestMilestone, _$identity);

  /// Serializes this RequestMilestone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.milestoneName, milestoneName) || other.milestoneName == milestoneName)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completionDate, completionDate) || other.completionDate == completionDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestId,milestoneName,description,dueDate,completionDate,status,createdAt,updatedAt);

@override
String toString() {
  return 'RequestMilestone(id: $id, requestId: $requestId, milestoneName: $milestoneName, description: $description, dueDate: $dueDate, completionDate: $completionDate, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RequestMilestoneCopyWith<$Res>  {
  factory $RequestMilestoneCopyWith(RequestMilestone value, $Res Function(RequestMilestone) _then) = _$RequestMilestoneCopyWithImpl;
@useResult
$Res call({
 String id, String requestId, String milestoneName, String? description, DateTime? dueDate, DateTime? completionDate, MilestoneStatus status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$RequestMilestoneCopyWithImpl<$Res>
    implements $RequestMilestoneCopyWith<$Res> {
  _$RequestMilestoneCopyWithImpl(this._self, this._then);

  final RequestMilestone _self;
  final $Res Function(RequestMilestone) _then;

/// Create a copy of RequestMilestone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requestId = null,Object? milestoneName = null,Object? description = freezed,Object? dueDate = freezed,Object? completionDate = freezed,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,milestoneName: null == milestoneName ? _self.milestoneName : milestoneName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completionDate: freezed == completionDate ? _self.completionDate : completionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MilestoneStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RequestMilestone implements RequestMilestone {
  const _RequestMilestone({required this.id, required this.requestId, required this.milestoneName, this.description, this.dueDate, this.completionDate, required this.status, required this.createdAt, required this.updatedAt});
  factory _RequestMilestone.fromJson(Map<String, dynamic> json) => _$RequestMilestoneFromJson(json);

@override final  String id;
@override final  String requestId;
@override final  String milestoneName;
@override final  String? description;
@override final  DateTime? dueDate;
@override final  DateTime? completionDate;
@override final  MilestoneStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of RequestMilestone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestMilestoneCopyWith<_RequestMilestone> get copyWith => __$RequestMilestoneCopyWithImpl<_RequestMilestone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestMilestoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.milestoneName, milestoneName) || other.milestoneName == milestoneName)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completionDate, completionDate) || other.completionDate == completionDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestId,milestoneName,description,dueDate,completionDate,status,createdAt,updatedAt);

@override
String toString() {
  return 'RequestMilestone(id: $id, requestId: $requestId, milestoneName: $milestoneName, description: $description, dueDate: $dueDate, completionDate: $completionDate, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RequestMilestoneCopyWith<$Res> implements $RequestMilestoneCopyWith<$Res> {
  factory _$RequestMilestoneCopyWith(_RequestMilestone value, $Res Function(_RequestMilestone) _then) = __$RequestMilestoneCopyWithImpl;
@override @useResult
$Res call({
 String id, String requestId, String milestoneName, String? description, DateTime? dueDate, DateTime? completionDate, MilestoneStatus status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$RequestMilestoneCopyWithImpl<$Res>
    implements _$RequestMilestoneCopyWith<$Res> {
  __$RequestMilestoneCopyWithImpl(this._self, this._then);

  final _RequestMilestone _self;
  final $Res Function(_RequestMilestone) _then;

/// Create a copy of RequestMilestone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? requestId = null,Object? milestoneName = null,Object? description = freezed,Object? dueDate = freezed,Object? completionDate = freezed,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RequestMilestone(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,milestoneName: null == milestoneName ? _self.milestoneName : milestoneName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completionDate: freezed == completionDate ? _self.completionDate : completionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MilestoneStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ServiceRequestTransaction {

 String get id; String get requestId; TransactionType get type; double get amount; String get currency; TransactionStatus get status; String? get description; DateTime get createdAt;
/// Create a copy of ServiceRequestTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestTransactionCopyWith<ServiceRequestTransaction> get copyWith => _$ServiceRequestTransactionCopyWithImpl<ServiceRequestTransaction>(this as ServiceRequestTransaction, _$identity);

  /// Serializes this ServiceRequestTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestId,type,amount,currency,status,description,createdAt);

@override
String toString() {
  return 'ServiceRequestTransaction(id: $id, requestId: $requestId, type: $type, amount: $amount, currency: $currency, status: $status, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestTransactionCopyWith<$Res>  {
  factory $ServiceRequestTransactionCopyWith(ServiceRequestTransaction value, $Res Function(ServiceRequestTransaction) _then) = _$ServiceRequestTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String requestId, TransactionType type, double amount, String currency, TransactionStatus status, String? description, DateTime createdAt
});




}
/// @nodoc
class _$ServiceRequestTransactionCopyWithImpl<$Res>
    implements $ServiceRequestTransactionCopyWith<$Res> {
  _$ServiceRequestTransactionCopyWithImpl(this._self, this._then);

  final ServiceRequestTransaction _self;
  final $Res Function(ServiceRequestTransaction) _then;

/// Create a copy of ServiceRequestTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requestId = null,Object? type = null,Object? amount = null,Object? currency = null,Object? status = null,Object? description = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequestTransaction implements ServiceRequestTransaction {
  const _ServiceRequestTransaction({required this.id, required this.requestId, required this.type, required this.amount, required this.currency, required this.status, this.description, required this.createdAt});
  factory _ServiceRequestTransaction.fromJson(Map<String, dynamic> json) => _$ServiceRequestTransactionFromJson(json);

@override final  String id;
@override final  String requestId;
@override final  TransactionType type;
@override final  double amount;
@override final  String currency;
@override final  TransactionStatus status;
@override final  String? description;
@override final  DateTime createdAt;

/// Create a copy of ServiceRequestTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestTransactionCopyWith<_ServiceRequestTransaction> get copyWith => __$ServiceRequestTransactionCopyWithImpl<_ServiceRequestTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequestTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestId,type,amount,currency,status,description,createdAt);

@override
String toString() {
  return 'ServiceRequestTransaction(id: $id, requestId: $requestId, type: $type, amount: $amount, currency: $currency, status: $status, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestTransactionCopyWith<$Res> implements $ServiceRequestTransactionCopyWith<$Res> {
  factory _$ServiceRequestTransactionCopyWith(_ServiceRequestTransaction value, $Res Function(_ServiceRequestTransaction) _then) = __$ServiceRequestTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String requestId, TransactionType type, double amount, String currency, TransactionStatus status, String? description, DateTime createdAt
});




}
/// @nodoc
class __$ServiceRequestTransactionCopyWithImpl<$Res>
    implements _$ServiceRequestTransactionCopyWith<$Res> {
  __$ServiceRequestTransactionCopyWithImpl(this._self, this._then);

  final _ServiceRequestTransaction _self;
  final $Res Function(_ServiceRequestTransaction) _then;

/// Create a copy of ServiceRequestTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? requestId = null,Object? type = null,Object? amount = null,Object? currency = null,Object? status = null,Object? description = freezed,Object? createdAt = null,}) {
  return _then(_ServiceRequestTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ServiceRequestReview {

 String get id; String get requestId; String get reviewerId; String get reviewerName; int get rating; String? get comment; DateTime get reviewDate; String? get response; DateTime? get responseDate; DateTime get createdAt;
/// Create a copy of ServiceRequestReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestReviewCopyWith<ServiceRequestReview> get copyWith => _$ServiceRequestReviewCopyWithImpl<ServiceRequestReview>(this as ServiceRequestReview, _$identity);

  /// Serializes this ServiceRequestReview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestReview&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reviewDate, reviewDate) || other.reviewDate == reviewDate)&&(identical(other.response, response) || other.response == response)&&(identical(other.responseDate, responseDate) || other.responseDate == responseDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestId,reviewerId,reviewerName,rating,comment,reviewDate,response,responseDate,createdAt);

@override
String toString() {
  return 'ServiceRequestReview(id: $id, requestId: $requestId, reviewerId: $reviewerId, reviewerName: $reviewerName, rating: $rating, comment: $comment, reviewDate: $reviewDate, response: $response, responseDate: $responseDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestReviewCopyWith<$Res>  {
  factory $ServiceRequestReviewCopyWith(ServiceRequestReview value, $Res Function(ServiceRequestReview) _then) = _$ServiceRequestReviewCopyWithImpl;
@useResult
$Res call({
 String id, String requestId, String reviewerId, String reviewerName, int rating, String? comment, DateTime reviewDate, String? response, DateTime? responseDate, DateTime createdAt
});




}
/// @nodoc
class _$ServiceRequestReviewCopyWithImpl<$Res>
    implements $ServiceRequestReviewCopyWith<$Res> {
  _$ServiceRequestReviewCopyWithImpl(this._self, this._then);

  final ServiceRequestReview _self;
  final $Res Function(ServiceRequestReview) _then;

/// Create a copy of ServiceRequestReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requestId = null,Object? reviewerId = null,Object? reviewerName = null,Object? rating = null,Object? comment = freezed,Object? reviewDate = null,Object? response = freezed,Object? responseDate = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,reviewerId: null == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,reviewDate: null == reviewDate ? _self.reviewDate : reviewDate // ignore: cast_nullable_to_non_nullable
as DateTime,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as String?,responseDate: freezed == responseDate ? _self.responseDate : responseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequestReview implements ServiceRequestReview {
  const _ServiceRequestReview({required this.id, required this.requestId, required this.reviewerId, required this.reviewerName, required this.rating, this.comment, required this.reviewDate, this.response, this.responseDate, required this.createdAt});
  factory _ServiceRequestReview.fromJson(Map<String, dynamic> json) => _$ServiceRequestReviewFromJson(json);

@override final  String id;
@override final  String requestId;
@override final  String reviewerId;
@override final  String reviewerName;
@override final  int rating;
@override final  String? comment;
@override final  DateTime reviewDate;
@override final  String? response;
@override final  DateTime? responseDate;
@override final  DateTime createdAt;

/// Create a copy of ServiceRequestReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestReviewCopyWith<_ServiceRequestReview> get copyWith => __$ServiceRequestReviewCopyWithImpl<_ServiceRequestReview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequestReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestReview&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reviewDate, reviewDate) || other.reviewDate == reviewDate)&&(identical(other.response, response) || other.response == response)&&(identical(other.responseDate, responseDate) || other.responseDate == responseDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestId,reviewerId,reviewerName,rating,comment,reviewDate,response,responseDate,createdAt);

@override
String toString() {
  return 'ServiceRequestReview(id: $id, requestId: $requestId, reviewerId: $reviewerId, reviewerName: $reviewerName, rating: $rating, comment: $comment, reviewDate: $reviewDate, response: $response, responseDate: $responseDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestReviewCopyWith<$Res> implements $ServiceRequestReviewCopyWith<$Res> {
  factory _$ServiceRequestReviewCopyWith(_ServiceRequestReview value, $Res Function(_ServiceRequestReview) _then) = __$ServiceRequestReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String requestId, String reviewerId, String reviewerName, int rating, String? comment, DateTime reviewDate, String? response, DateTime? responseDate, DateTime createdAt
});




}
/// @nodoc
class __$ServiceRequestReviewCopyWithImpl<$Res>
    implements _$ServiceRequestReviewCopyWith<$Res> {
  __$ServiceRequestReviewCopyWithImpl(this._self, this._then);

  final _ServiceRequestReview _self;
  final $Res Function(_ServiceRequestReview) _then;

/// Create a copy of ServiceRequestReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? requestId = null,Object? reviewerId = null,Object? reviewerName = null,Object? rating = null,Object? comment = freezed,Object? reviewDate = null,Object? response = freezed,Object? responseDate = freezed,Object? createdAt = null,}) {
  return _then(_ServiceRequestReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,reviewerId: null == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,reviewDate: null == reviewDate ? _self.reviewDate : reviewDate // ignore: cast_nullable_to_non_nullable
as DateTime,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as String?,responseDate: freezed == responseDate ? _self.responseDate : responseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ServiceRequestUpdateRequest {

 ServiceRequestStatus? get status; DateTime? get requiredByDate; DateTime? get completedDate; String? get cancellationReason; String? get notes;
/// Create a copy of ServiceRequestUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestUpdateRequestCopyWith<ServiceRequestUpdateRequest> get copyWith => _$ServiceRequestUpdateRequestCopyWithImpl<ServiceRequestUpdateRequest>(this as ServiceRequestUpdateRequest, _$identity);

  /// Serializes this ServiceRequestUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestUpdateRequest&&(identical(other.status, status) || other.status == status)&&(identical(other.requiredByDate, requiredByDate) || other.requiredByDate == requiredByDate)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,requiredByDate,completedDate,cancellationReason,notes);

@override
String toString() {
  return 'ServiceRequestUpdateRequest(status: $status, requiredByDate: $requiredByDate, completedDate: $completedDate, cancellationReason: $cancellationReason, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestUpdateRequestCopyWith<$Res>  {
  factory $ServiceRequestUpdateRequestCopyWith(ServiceRequestUpdateRequest value, $Res Function(ServiceRequestUpdateRequest) _then) = _$ServiceRequestUpdateRequestCopyWithImpl;
@useResult
$Res call({
 ServiceRequestStatus? status, DateTime? requiredByDate, DateTime? completedDate, String? cancellationReason, String? notes
});




}
/// @nodoc
class _$ServiceRequestUpdateRequestCopyWithImpl<$Res>
    implements $ServiceRequestUpdateRequestCopyWith<$Res> {
  _$ServiceRequestUpdateRequestCopyWithImpl(this._self, this._then);

  final ServiceRequestUpdateRequest _self;
  final $Res Function(ServiceRequestUpdateRequest) _then;

/// Create a copy of ServiceRequestUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? requiredByDate = freezed,Object? completedDate = freezed,Object? cancellationReason = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus?,requiredByDate: freezed == requiredByDate ? _self.requiredByDate : requiredByDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequestUpdateRequest implements ServiceRequestUpdateRequest {
  const _ServiceRequestUpdateRequest({this.status, this.requiredByDate, this.completedDate, this.cancellationReason, this.notes});
  factory _ServiceRequestUpdateRequest.fromJson(Map<String, dynamic> json) => _$ServiceRequestUpdateRequestFromJson(json);

@override final  ServiceRequestStatus? status;
@override final  DateTime? requiredByDate;
@override final  DateTime? completedDate;
@override final  String? cancellationReason;
@override final  String? notes;

/// Create a copy of ServiceRequestUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestUpdateRequestCopyWith<_ServiceRequestUpdateRequest> get copyWith => __$ServiceRequestUpdateRequestCopyWithImpl<_ServiceRequestUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequestUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestUpdateRequest&&(identical(other.status, status) || other.status == status)&&(identical(other.requiredByDate, requiredByDate) || other.requiredByDate == requiredByDate)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,requiredByDate,completedDate,cancellationReason,notes);

@override
String toString() {
  return 'ServiceRequestUpdateRequest(status: $status, requiredByDate: $requiredByDate, completedDate: $completedDate, cancellationReason: $cancellationReason, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestUpdateRequestCopyWith<$Res> implements $ServiceRequestUpdateRequestCopyWith<$Res> {
  factory _$ServiceRequestUpdateRequestCopyWith(_ServiceRequestUpdateRequest value, $Res Function(_ServiceRequestUpdateRequest) _then) = __$ServiceRequestUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 ServiceRequestStatus? status, DateTime? requiredByDate, DateTime? completedDate, String? cancellationReason, String? notes
});




}
/// @nodoc
class __$ServiceRequestUpdateRequestCopyWithImpl<$Res>
    implements _$ServiceRequestUpdateRequestCopyWith<$Res> {
  __$ServiceRequestUpdateRequestCopyWithImpl(this._self, this._then);

  final _ServiceRequestUpdateRequest _self;
  final $Res Function(_ServiceRequestUpdateRequest) _then;

/// Create a copy of ServiceRequestUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? requiredByDate = freezed,Object? completedDate = freezed,Object? cancellationReason = freezed,Object? notes = freezed,}) {
  return _then(_ServiceRequestUpdateRequest(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus?,requiredByDate: freezed == requiredByDate ? _self.requiredByDate : requiredByDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DocumentVerificationRequest {

 String get documentId; DocumentStatus get status; String? get verificationNotes; String get verifiedBy;
/// Create a copy of DocumentVerificationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentVerificationRequestCopyWith<DocumentVerificationRequest> get copyWith => _$DocumentVerificationRequestCopyWithImpl<DocumentVerificationRequest>(this as DocumentVerificationRequest, _$identity);

  /// Serializes this DocumentVerificationRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentVerificationRequest&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.verificationNotes, verificationNotes) || other.verificationNotes == verificationNotes)&&(identical(other.verifiedBy, verifiedBy) || other.verifiedBy == verifiedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentId,status,verificationNotes,verifiedBy);

@override
String toString() {
  return 'DocumentVerificationRequest(documentId: $documentId, status: $status, verificationNotes: $verificationNotes, verifiedBy: $verifiedBy)';
}


}

/// @nodoc
abstract mixin class $DocumentVerificationRequestCopyWith<$Res>  {
  factory $DocumentVerificationRequestCopyWith(DocumentVerificationRequest value, $Res Function(DocumentVerificationRequest) _then) = _$DocumentVerificationRequestCopyWithImpl;
@useResult
$Res call({
 String documentId, DocumentStatus status, String? verificationNotes, String verifiedBy
});




}
/// @nodoc
class _$DocumentVerificationRequestCopyWithImpl<$Res>
    implements $DocumentVerificationRequestCopyWith<$Res> {
  _$DocumentVerificationRequestCopyWithImpl(this._self, this._then);

  final DocumentVerificationRequest _self;
  final $Res Function(DocumentVerificationRequest) _then;

/// Create a copy of DocumentVerificationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documentId = null,Object? status = null,Object? verificationNotes = freezed,Object? verifiedBy = null,}) {
  return _then(_self.copyWith(
documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,verificationNotes: freezed == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String?,verifiedBy: null == verifiedBy ? _self.verifiedBy : verifiedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DocumentVerificationRequest implements DocumentVerificationRequest {
  const _DocumentVerificationRequest({required this.documentId, required this.status, this.verificationNotes, required this.verifiedBy});
  factory _DocumentVerificationRequest.fromJson(Map<String, dynamic> json) => _$DocumentVerificationRequestFromJson(json);

@override final  String documentId;
@override final  DocumentStatus status;
@override final  String? verificationNotes;
@override final  String verifiedBy;

/// Create a copy of DocumentVerificationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentVerificationRequestCopyWith<_DocumentVerificationRequest> get copyWith => __$DocumentVerificationRequestCopyWithImpl<_DocumentVerificationRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentVerificationRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentVerificationRequest&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.verificationNotes, verificationNotes) || other.verificationNotes == verificationNotes)&&(identical(other.verifiedBy, verifiedBy) || other.verifiedBy == verifiedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentId,status,verificationNotes,verifiedBy);

@override
String toString() {
  return 'DocumentVerificationRequest(documentId: $documentId, status: $status, verificationNotes: $verificationNotes, verifiedBy: $verifiedBy)';
}


}

/// @nodoc
abstract mixin class _$DocumentVerificationRequestCopyWith<$Res> implements $DocumentVerificationRequestCopyWith<$Res> {
  factory _$DocumentVerificationRequestCopyWith(_DocumentVerificationRequest value, $Res Function(_DocumentVerificationRequest) _then) = __$DocumentVerificationRequestCopyWithImpl;
@override @useResult
$Res call({
 String documentId, DocumentStatus status, String? verificationNotes, String verifiedBy
});




}
/// @nodoc
class __$DocumentVerificationRequestCopyWithImpl<$Res>
    implements _$DocumentVerificationRequestCopyWith<$Res> {
  __$DocumentVerificationRequestCopyWithImpl(this._self, this._then);

  final _DocumentVerificationRequest _self;
  final $Res Function(_DocumentVerificationRequest) _then;

/// Create a copy of DocumentVerificationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documentId = null,Object? status = null,Object? verificationNotes = freezed,Object? verifiedBy = null,}) {
  return _then(_DocumentVerificationRequest(
documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,verificationNotes: freezed == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String?,verifiedBy: null == verifiedBy ? _self.verifiedBy : verifiedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MilestoneUpdateRequest {

 String get milestoneId; MilestoneStatus get status; DateTime? get completionDate; String? get notes;
/// Create a copy of MilestoneUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilestoneUpdateRequestCopyWith<MilestoneUpdateRequest> get copyWith => _$MilestoneUpdateRequestCopyWithImpl<MilestoneUpdateRequest>(this as MilestoneUpdateRequest, _$identity);

  /// Serializes this MilestoneUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MilestoneUpdateRequest&&(identical(other.milestoneId, milestoneId) || other.milestoneId == milestoneId)&&(identical(other.status, status) || other.status == status)&&(identical(other.completionDate, completionDate) || other.completionDate == completionDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,milestoneId,status,completionDate,notes);

@override
String toString() {
  return 'MilestoneUpdateRequest(milestoneId: $milestoneId, status: $status, completionDate: $completionDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $MilestoneUpdateRequestCopyWith<$Res>  {
  factory $MilestoneUpdateRequestCopyWith(MilestoneUpdateRequest value, $Res Function(MilestoneUpdateRequest) _then) = _$MilestoneUpdateRequestCopyWithImpl;
@useResult
$Res call({
 String milestoneId, MilestoneStatus status, DateTime? completionDate, String? notes
});




}
/// @nodoc
class _$MilestoneUpdateRequestCopyWithImpl<$Res>
    implements $MilestoneUpdateRequestCopyWith<$Res> {
  _$MilestoneUpdateRequestCopyWithImpl(this._self, this._then);

  final MilestoneUpdateRequest _self;
  final $Res Function(MilestoneUpdateRequest) _then;

/// Create a copy of MilestoneUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? milestoneId = null,Object? status = null,Object? completionDate = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
milestoneId: null == milestoneId ? _self.milestoneId : milestoneId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MilestoneStatus,completionDate: freezed == completionDate ? _self.completionDate : completionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MilestoneUpdateRequest implements MilestoneUpdateRequest {
  const _MilestoneUpdateRequest({required this.milestoneId, required this.status, this.completionDate, this.notes});
  factory _MilestoneUpdateRequest.fromJson(Map<String, dynamic> json) => _$MilestoneUpdateRequestFromJson(json);

@override final  String milestoneId;
@override final  MilestoneStatus status;
@override final  DateTime? completionDate;
@override final  String? notes;

/// Create a copy of MilestoneUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilestoneUpdateRequestCopyWith<_MilestoneUpdateRequest> get copyWith => __$MilestoneUpdateRequestCopyWithImpl<_MilestoneUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MilestoneUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MilestoneUpdateRequest&&(identical(other.milestoneId, milestoneId) || other.milestoneId == milestoneId)&&(identical(other.status, status) || other.status == status)&&(identical(other.completionDate, completionDate) || other.completionDate == completionDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,milestoneId,status,completionDate,notes);

@override
String toString() {
  return 'MilestoneUpdateRequest(milestoneId: $milestoneId, status: $status, completionDate: $completionDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$MilestoneUpdateRequestCopyWith<$Res> implements $MilestoneUpdateRequestCopyWith<$Res> {
  factory _$MilestoneUpdateRequestCopyWith(_MilestoneUpdateRequest value, $Res Function(_MilestoneUpdateRequest) _then) = __$MilestoneUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 String milestoneId, MilestoneStatus status, DateTime? completionDate, String? notes
});




}
/// @nodoc
class __$MilestoneUpdateRequestCopyWithImpl<$Res>
    implements _$MilestoneUpdateRequestCopyWith<$Res> {
  __$MilestoneUpdateRequestCopyWithImpl(this._self, this._then);

  final _MilestoneUpdateRequest _self;
  final $Res Function(_MilestoneUpdateRequest) _then;

/// Create a copy of MilestoneUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? milestoneId = null,Object? status = null,Object? completionDate = freezed,Object? notes = freezed,}) {
  return _then(_MilestoneUpdateRequest(
milestoneId: null == milestoneId ? _self.milestoneId : milestoneId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MilestoneStatus,completionDate: freezed == completionDate ? _self.completionDate : completionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ServiceRequestStats {

 int get totalRequests; int get pendingRequests; int get inProgressRequests; int get completedRequests; int get cancelledRequests; int get disputedRequests; double get totalRevenue; double get pendingRevenue; double get completedRevenue; double get averageCompletionTime;// in days
 double get customerSatisfactionRate;
/// Create a copy of ServiceRequestStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestStatsCopyWith<ServiceRequestStats> get copyWith => _$ServiceRequestStatsCopyWithImpl<ServiceRequestStats>(this as ServiceRequestStats, _$identity);

  /// Serializes this ServiceRequestStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestStats&&(identical(other.totalRequests, totalRequests) || other.totalRequests == totalRequests)&&(identical(other.pendingRequests, pendingRequests) || other.pendingRequests == pendingRequests)&&(identical(other.inProgressRequests, inProgressRequests) || other.inProgressRequests == inProgressRequests)&&(identical(other.completedRequests, completedRequests) || other.completedRequests == completedRequests)&&(identical(other.cancelledRequests, cancelledRequests) || other.cancelledRequests == cancelledRequests)&&(identical(other.disputedRequests, disputedRequests) || other.disputedRequests == disputedRequests)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.pendingRevenue, pendingRevenue) || other.pendingRevenue == pendingRevenue)&&(identical(other.completedRevenue, completedRevenue) || other.completedRevenue == completedRevenue)&&(identical(other.averageCompletionTime, averageCompletionTime) || other.averageCompletionTime == averageCompletionTime)&&(identical(other.customerSatisfactionRate, customerSatisfactionRate) || other.customerSatisfactionRate == customerSatisfactionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRequests,pendingRequests,inProgressRequests,completedRequests,cancelledRequests,disputedRequests,totalRevenue,pendingRevenue,completedRevenue,averageCompletionTime,customerSatisfactionRate);

@override
String toString() {
  return 'ServiceRequestStats(totalRequests: $totalRequests, pendingRequests: $pendingRequests, inProgressRequests: $inProgressRequests, completedRequests: $completedRequests, cancelledRequests: $cancelledRequests, disputedRequests: $disputedRequests, totalRevenue: $totalRevenue, pendingRevenue: $pendingRevenue, completedRevenue: $completedRevenue, averageCompletionTime: $averageCompletionTime, customerSatisfactionRate: $customerSatisfactionRate)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestStatsCopyWith<$Res>  {
  factory $ServiceRequestStatsCopyWith(ServiceRequestStats value, $Res Function(ServiceRequestStats) _then) = _$ServiceRequestStatsCopyWithImpl;
@useResult
$Res call({
 int totalRequests, int pendingRequests, int inProgressRequests, int completedRequests, int cancelledRequests, int disputedRequests, double totalRevenue, double pendingRevenue, double completedRevenue, double averageCompletionTime, double customerSatisfactionRate
});




}
/// @nodoc
class _$ServiceRequestStatsCopyWithImpl<$Res>
    implements $ServiceRequestStatsCopyWith<$Res> {
  _$ServiceRequestStatsCopyWithImpl(this._self, this._then);

  final ServiceRequestStats _self;
  final $Res Function(ServiceRequestStats) _then;

/// Create a copy of ServiceRequestStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRequests = null,Object? pendingRequests = null,Object? inProgressRequests = null,Object? completedRequests = null,Object? cancelledRequests = null,Object? disputedRequests = null,Object? totalRevenue = null,Object? pendingRevenue = null,Object? completedRevenue = null,Object? averageCompletionTime = null,Object? customerSatisfactionRate = null,}) {
  return _then(_self.copyWith(
totalRequests: null == totalRequests ? _self.totalRequests : totalRequests // ignore: cast_nullable_to_non_nullable
as int,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as int,inProgressRequests: null == inProgressRequests ? _self.inProgressRequests : inProgressRequests // ignore: cast_nullable_to_non_nullable
as int,completedRequests: null == completedRequests ? _self.completedRequests : completedRequests // ignore: cast_nullable_to_non_nullable
as int,cancelledRequests: null == cancelledRequests ? _self.cancelledRequests : cancelledRequests // ignore: cast_nullable_to_non_nullable
as int,disputedRequests: null == disputedRequests ? _self.disputedRequests : disputedRequests // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,pendingRevenue: null == pendingRevenue ? _self.pendingRevenue : pendingRevenue // ignore: cast_nullable_to_non_nullable
as double,completedRevenue: null == completedRevenue ? _self.completedRevenue : completedRevenue // ignore: cast_nullable_to_non_nullable
as double,averageCompletionTime: null == averageCompletionTime ? _self.averageCompletionTime : averageCompletionTime // ignore: cast_nullable_to_non_nullable
as double,customerSatisfactionRate: null == customerSatisfactionRate ? _self.customerSatisfactionRate : customerSatisfactionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequestStats implements ServiceRequestStats {
  const _ServiceRequestStats({this.totalRequests = 0, this.pendingRequests = 0, this.inProgressRequests = 0, this.completedRequests = 0, this.cancelledRequests = 0, this.disputedRequests = 0, this.totalRevenue = 0.0, this.pendingRevenue = 0.0, this.completedRevenue = 0.0, this.averageCompletionTime = 0.0, this.customerSatisfactionRate = 0.0});
  factory _ServiceRequestStats.fromJson(Map<String, dynamic> json) => _$ServiceRequestStatsFromJson(json);

@override@JsonKey() final  int totalRequests;
@override@JsonKey() final  int pendingRequests;
@override@JsonKey() final  int inProgressRequests;
@override@JsonKey() final  int completedRequests;
@override@JsonKey() final  int cancelledRequests;
@override@JsonKey() final  int disputedRequests;
@override@JsonKey() final  double totalRevenue;
@override@JsonKey() final  double pendingRevenue;
@override@JsonKey() final  double completedRevenue;
@override@JsonKey() final  double averageCompletionTime;
// in days
@override@JsonKey() final  double customerSatisfactionRate;

/// Create a copy of ServiceRequestStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestStatsCopyWith<_ServiceRequestStats> get copyWith => __$ServiceRequestStatsCopyWithImpl<_ServiceRequestStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequestStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestStats&&(identical(other.totalRequests, totalRequests) || other.totalRequests == totalRequests)&&(identical(other.pendingRequests, pendingRequests) || other.pendingRequests == pendingRequests)&&(identical(other.inProgressRequests, inProgressRequests) || other.inProgressRequests == inProgressRequests)&&(identical(other.completedRequests, completedRequests) || other.completedRequests == completedRequests)&&(identical(other.cancelledRequests, cancelledRequests) || other.cancelledRequests == cancelledRequests)&&(identical(other.disputedRequests, disputedRequests) || other.disputedRequests == disputedRequests)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.pendingRevenue, pendingRevenue) || other.pendingRevenue == pendingRevenue)&&(identical(other.completedRevenue, completedRevenue) || other.completedRevenue == completedRevenue)&&(identical(other.averageCompletionTime, averageCompletionTime) || other.averageCompletionTime == averageCompletionTime)&&(identical(other.customerSatisfactionRate, customerSatisfactionRate) || other.customerSatisfactionRate == customerSatisfactionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRequests,pendingRequests,inProgressRequests,completedRequests,cancelledRequests,disputedRequests,totalRevenue,pendingRevenue,completedRevenue,averageCompletionTime,customerSatisfactionRate);

@override
String toString() {
  return 'ServiceRequestStats(totalRequests: $totalRequests, pendingRequests: $pendingRequests, inProgressRequests: $inProgressRequests, completedRequests: $completedRequests, cancelledRequests: $cancelledRequests, disputedRequests: $disputedRequests, totalRevenue: $totalRevenue, pendingRevenue: $pendingRevenue, completedRevenue: $completedRevenue, averageCompletionTime: $averageCompletionTime, customerSatisfactionRate: $customerSatisfactionRate)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestStatsCopyWith<$Res> implements $ServiceRequestStatsCopyWith<$Res> {
  factory _$ServiceRequestStatsCopyWith(_ServiceRequestStats value, $Res Function(_ServiceRequestStats) _then) = __$ServiceRequestStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalRequests, int pendingRequests, int inProgressRequests, int completedRequests, int cancelledRequests, int disputedRequests, double totalRevenue, double pendingRevenue, double completedRevenue, double averageCompletionTime, double customerSatisfactionRate
});




}
/// @nodoc
class __$ServiceRequestStatsCopyWithImpl<$Res>
    implements _$ServiceRequestStatsCopyWith<$Res> {
  __$ServiceRequestStatsCopyWithImpl(this._self, this._then);

  final _ServiceRequestStats _self;
  final $Res Function(_ServiceRequestStats) _then;

/// Create a copy of ServiceRequestStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRequests = null,Object? pendingRequests = null,Object? inProgressRequests = null,Object? completedRequests = null,Object? cancelledRequests = null,Object? disputedRequests = null,Object? totalRevenue = null,Object? pendingRevenue = null,Object? completedRevenue = null,Object? averageCompletionTime = null,Object? customerSatisfactionRate = null,}) {
  return _then(_ServiceRequestStats(
totalRequests: null == totalRequests ? _self.totalRequests : totalRequests // ignore: cast_nullable_to_non_nullable
as int,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as int,inProgressRequests: null == inProgressRequests ? _self.inProgressRequests : inProgressRequests // ignore: cast_nullable_to_non_nullable
as int,completedRequests: null == completedRequests ? _self.completedRequests : completedRequests // ignore: cast_nullable_to_non_nullable
as int,cancelledRequests: null == cancelledRequests ? _self.cancelledRequests : cancelledRequests // ignore: cast_nullable_to_non_nullable
as int,disputedRequests: null == disputedRequests ? _self.disputedRequests : disputedRequests // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,pendingRevenue: null == pendingRevenue ? _self.pendingRevenue : pendingRevenue // ignore: cast_nullable_to_non_nullable
as double,completedRevenue: null == completedRevenue ? _self.completedRevenue : completedRevenue // ignore: cast_nullable_to_non_nullable
as double,averageCompletionTime: null == averageCompletionTime ? _self.averageCompletionTime : averageCompletionTime // ignore: cast_nullable_to_non_nullable
as double,customerSatisfactionRate: null == customerSatisfactionRate ? _self.customerSatisfactionRate : customerSatisfactionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
