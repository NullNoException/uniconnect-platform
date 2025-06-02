// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EscrowPayment {

 String get id; String get transactionId; String get orderId; String get customerId; String get providerId; double get amount; String get currency; EscrowStatus get status; DateTime get createdAt; DateTime? get releasedAt; DateTime? get refundedAt; String? get releaseNotes; String? get refundReason; String? get adminId;// Customer info for display
 String? get customerName; String? get customerEmail;// Provider info for display
 String? get providerName; String? get providerEmail;// Order info for display
 String? get serviceTitle; String? get orderDescription;
/// Create a copy of EscrowPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EscrowPaymentCopyWith<EscrowPayment> get copyWith => _$EscrowPaymentCopyWithImpl<EscrowPayment>(this as EscrowPayment, _$identity);

  /// Serializes this EscrowPayment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EscrowPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.releasedAt, releasedAt) || other.releasedAt == releasedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerEmail, providerEmail) || other.providerEmail == providerEmail)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle)&&(identical(other.orderDescription, orderDescription) || other.orderDescription == orderDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,transactionId,orderId,customerId,providerId,amount,currency,status,createdAt,releasedAt,refundedAt,releaseNotes,refundReason,adminId,customerName,customerEmail,providerName,providerEmail,serviceTitle,orderDescription]);

@override
String toString() {
  return 'EscrowPayment(id: $id, transactionId: $transactionId, orderId: $orderId, customerId: $customerId, providerId: $providerId, amount: $amount, currency: $currency, status: $status, createdAt: $createdAt, releasedAt: $releasedAt, refundedAt: $refundedAt, releaseNotes: $releaseNotes, refundReason: $refundReason, adminId: $adminId, customerName: $customerName, customerEmail: $customerEmail, providerName: $providerName, providerEmail: $providerEmail, serviceTitle: $serviceTitle, orderDescription: $orderDescription)';
}


}

/// @nodoc
abstract mixin class $EscrowPaymentCopyWith<$Res>  {
  factory $EscrowPaymentCopyWith(EscrowPayment value, $Res Function(EscrowPayment) _then) = _$EscrowPaymentCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, String orderId, String customerId, String providerId, double amount, String currency, EscrowStatus status, DateTime createdAt, DateTime? releasedAt, DateTime? refundedAt, String? releaseNotes, String? refundReason, String? adminId, String? customerName, String? customerEmail, String? providerName, String? providerEmail, String? serviceTitle, String? orderDescription
});




}
/// @nodoc
class _$EscrowPaymentCopyWithImpl<$Res>
    implements $EscrowPaymentCopyWith<$Res> {
  _$EscrowPaymentCopyWithImpl(this._self, this._then);

  final EscrowPayment _self;
  final $Res Function(EscrowPayment) _then;

/// Create a copy of EscrowPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? orderId = null,Object? customerId = null,Object? providerId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? createdAt = null,Object? releasedAt = freezed,Object? refundedAt = freezed,Object? releaseNotes = freezed,Object? refundReason = freezed,Object? adminId = freezed,Object? customerName = freezed,Object? customerEmail = freezed,Object? providerName = freezed,Object? providerEmail = freezed,Object? serviceTitle = freezed,Object? orderDescription = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EscrowStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,releasedAt: freezed == releasedAt ? _self.releasedAt : releasedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,releaseNotes: freezed == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String?,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String?,adminId: freezed == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,providerEmail: freezed == providerEmail ? _self.providerEmail : providerEmail // ignore: cast_nullable_to_non_nullable
as String?,serviceTitle: freezed == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String?,orderDescription: freezed == orderDescription ? _self.orderDescription : orderDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EscrowPayment implements EscrowPayment {
  const _EscrowPayment({required this.id, required this.transactionId, required this.orderId, required this.customerId, required this.providerId, required this.amount, required this.currency, required this.status, required this.createdAt, this.releasedAt, this.refundedAt, this.releaseNotes, this.refundReason, this.adminId, this.customerName, this.customerEmail, this.providerName, this.providerEmail, this.serviceTitle, this.orderDescription});
  factory _EscrowPayment.fromJson(Map<String, dynamic> json) => _$EscrowPaymentFromJson(json);

@override final  String id;
@override final  String transactionId;
@override final  String orderId;
@override final  String customerId;
@override final  String providerId;
@override final  double amount;
@override final  String currency;
@override final  EscrowStatus status;
@override final  DateTime createdAt;
@override final  DateTime? releasedAt;
@override final  DateTime? refundedAt;
@override final  String? releaseNotes;
@override final  String? refundReason;
@override final  String? adminId;
// Customer info for display
@override final  String? customerName;
@override final  String? customerEmail;
// Provider info for display
@override final  String? providerName;
@override final  String? providerEmail;
// Order info for display
@override final  String? serviceTitle;
@override final  String? orderDescription;

/// Create a copy of EscrowPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EscrowPaymentCopyWith<_EscrowPayment> get copyWith => __$EscrowPaymentCopyWithImpl<_EscrowPayment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EscrowPaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EscrowPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.releasedAt, releasedAt) || other.releasedAt == releasedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerEmail, providerEmail) || other.providerEmail == providerEmail)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle)&&(identical(other.orderDescription, orderDescription) || other.orderDescription == orderDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,transactionId,orderId,customerId,providerId,amount,currency,status,createdAt,releasedAt,refundedAt,releaseNotes,refundReason,adminId,customerName,customerEmail,providerName,providerEmail,serviceTitle,orderDescription]);

@override
String toString() {
  return 'EscrowPayment(id: $id, transactionId: $transactionId, orderId: $orderId, customerId: $customerId, providerId: $providerId, amount: $amount, currency: $currency, status: $status, createdAt: $createdAt, releasedAt: $releasedAt, refundedAt: $refundedAt, releaseNotes: $releaseNotes, refundReason: $refundReason, adminId: $adminId, customerName: $customerName, customerEmail: $customerEmail, providerName: $providerName, providerEmail: $providerEmail, serviceTitle: $serviceTitle, orderDescription: $orderDescription)';
}


}

/// @nodoc
abstract mixin class _$EscrowPaymentCopyWith<$Res> implements $EscrowPaymentCopyWith<$Res> {
  factory _$EscrowPaymentCopyWith(_EscrowPayment value, $Res Function(_EscrowPayment) _then) = __$EscrowPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, String orderId, String customerId, String providerId, double amount, String currency, EscrowStatus status, DateTime createdAt, DateTime? releasedAt, DateTime? refundedAt, String? releaseNotes, String? refundReason, String? adminId, String? customerName, String? customerEmail, String? providerName, String? providerEmail, String? serviceTitle, String? orderDescription
});




}
/// @nodoc
class __$EscrowPaymentCopyWithImpl<$Res>
    implements _$EscrowPaymentCopyWith<$Res> {
  __$EscrowPaymentCopyWithImpl(this._self, this._then);

  final _EscrowPayment _self;
  final $Res Function(_EscrowPayment) _then;

/// Create a copy of EscrowPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? orderId = null,Object? customerId = null,Object? providerId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? createdAt = null,Object? releasedAt = freezed,Object? refundedAt = freezed,Object? releaseNotes = freezed,Object? refundReason = freezed,Object? adminId = freezed,Object? customerName = freezed,Object? customerEmail = freezed,Object? providerName = freezed,Object? providerEmail = freezed,Object? serviceTitle = freezed,Object? orderDescription = freezed,}) {
  return _then(_EscrowPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EscrowStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,releasedAt: freezed == releasedAt ? _self.releasedAt : releasedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,releaseNotes: freezed == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String?,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String?,adminId: freezed == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,providerEmail: freezed == providerEmail ? _self.providerEmail : providerEmail // ignore: cast_nullable_to_non_nullable
as String?,serviceTitle: freezed == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String?,orderDescription: freezed == orderDescription ? _self.orderDescription : orderDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EscrowPaymentListItem {

 String get id; String get transactionId; String get customerName; String get providerName; String get serviceTitle; double get amount; String get currency; EscrowStatus get status; DateTime get createdAt; DateTime? get releasedAt; DateTime? get refundedAt;
/// Create a copy of EscrowPaymentListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EscrowPaymentListItemCopyWith<EscrowPaymentListItem> get copyWith => _$EscrowPaymentListItemCopyWithImpl<EscrowPaymentListItem>(this as EscrowPaymentListItem, _$identity);

  /// Serializes this EscrowPaymentListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EscrowPaymentListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.releasedAt, releasedAt) || other.releasedAt == releasedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,customerName,providerName,serviceTitle,amount,currency,status,createdAt,releasedAt,refundedAt);

@override
String toString() {
  return 'EscrowPaymentListItem(id: $id, transactionId: $transactionId, customerName: $customerName, providerName: $providerName, serviceTitle: $serviceTitle, amount: $amount, currency: $currency, status: $status, createdAt: $createdAt, releasedAt: $releasedAt, refundedAt: $refundedAt)';
}


}

/// @nodoc
abstract mixin class $EscrowPaymentListItemCopyWith<$Res>  {
  factory $EscrowPaymentListItemCopyWith(EscrowPaymentListItem value, $Res Function(EscrowPaymentListItem) _then) = _$EscrowPaymentListItemCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, String customerName, String providerName, String serviceTitle, double amount, String currency, EscrowStatus status, DateTime createdAt, DateTime? releasedAt, DateTime? refundedAt
});




}
/// @nodoc
class _$EscrowPaymentListItemCopyWithImpl<$Res>
    implements $EscrowPaymentListItemCopyWith<$Res> {
  _$EscrowPaymentListItemCopyWithImpl(this._self, this._then);

  final EscrowPaymentListItem _self;
  final $Res Function(EscrowPaymentListItem) _then;

/// Create a copy of EscrowPaymentListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? customerName = null,Object? providerName = null,Object? serviceTitle = null,Object? amount = null,Object? currency = null,Object? status = null,Object? createdAt = null,Object? releasedAt = freezed,Object? refundedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,serviceTitle: null == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EscrowStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,releasedAt: freezed == releasedAt ? _self.releasedAt : releasedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EscrowPaymentListItem implements EscrowPaymentListItem {
  const _EscrowPaymentListItem({required this.id, required this.transactionId, required this.customerName, required this.providerName, required this.serviceTitle, required this.amount, required this.currency, required this.status, required this.createdAt, this.releasedAt, this.refundedAt});
  factory _EscrowPaymentListItem.fromJson(Map<String, dynamic> json) => _$EscrowPaymentListItemFromJson(json);

@override final  String id;
@override final  String transactionId;
@override final  String customerName;
@override final  String providerName;
@override final  String serviceTitle;
@override final  double amount;
@override final  String currency;
@override final  EscrowStatus status;
@override final  DateTime createdAt;
@override final  DateTime? releasedAt;
@override final  DateTime? refundedAt;

/// Create a copy of EscrowPaymentListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EscrowPaymentListItemCopyWith<_EscrowPaymentListItem> get copyWith => __$EscrowPaymentListItemCopyWithImpl<_EscrowPaymentListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EscrowPaymentListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EscrowPaymentListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.releasedAt, releasedAt) || other.releasedAt == releasedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,customerName,providerName,serviceTitle,amount,currency,status,createdAt,releasedAt,refundedAt);

@override
String toString() {
  return 'EscrowPaymentListItem(id: $id, transactionId: $transactionId, customerName: $customerName, providerName: $providerName, serviceTitle: $serviceTitle, amount: $amount, currency: $currency, status: $status, createdAt: $createdAt, releasedAt: $releasedAt, refundedAt: $refundedAt)';
}


}

/// @nodoc
abstract mixin class _$EscrowPaymentListItemCopyWith<$Res> implements $EscrowPaymentListItemCopyWith<$Res> {
  factory _$EscrowPaymentListItemCopyWith(_EscrowPaymentListItem value, $Res Function(_EscrowPaymentListItem) _then) = __$EscrowPaymentListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, String customerName, String providerName, String serviceTitle, double amount, String currency, EscrowStatus status, DateTime createdAt, DateTime? releasedAt, DateTime? refundedAt
});




}
/// @nodoc
class __$EscrowPaymentListItemCopyWithImpl<$Res>
    implements _$EscrowPaymentListItemCopyWith<$Res> {
  __$EscrowPaymentListItemCopyWithImpl(this._self, this._then);

  final _EscrowPaymentListItem _self;
  final $Res Function(_EscrowPaymentListItem) _then;

/// Create a copy of EscrowPaymentListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? customerName = null,Object? providerName = null,Object? serviceTitle = null,Object? amount = null,Object? currency = null,Object? status = null,Object? createdAt = null,Object? releasedAt = freezed,Object? refundedAt = freezed,}) {
  return _then(_EscrowPaymentListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,serviceTitle: null == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EscrowStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,releasedAt: freezed == releasedAt ? _self.releasedAt : releasedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ReleaseEscrowRequest {

 String get escrowPaymentId; String get adminId; String? get releaseNotes; bool get confirmRelease;
/// Create a copy of ReleaseEscrowRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReleaseEscrowRequestCopyWith<ReleaseEscrowRequest> get copyWith => _$ReleaseEscrowRequestCopyWithImpl<ReleaseEscrowRequest>(this as ReleaseEscrowRequest, _$identity);

  /// Serializes this ReleaseEscrowRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReleaseEscrowRequest&&(identical(other.escrowPaymentId, escrowPaymentId) || other.escrowPaymentId == escrowPaymentId)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes)&&(identical(other.confirmRelease, confirmRelease) || other.confirmRelease == confirmRelease));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,escrowPaymentId,adminId,releaseNotes,confirmRelease);

@override
String toString() {
  return 'ReleaseEscrowRequest(escrowPaymentId: $escrowPaymentId, adminId: $adminId, releaseNotes: $releaseNotes, confirmRelease: $confirmRelease)';
}


}

/// @nodoc
abstract mixin class $ReleaseEscrowRequestCopyWith<$Res>  {
  factory $ReleaseEscrowRequestCopyWith(ReleaseEscrowRequest value, $Res Function(ReleaseEscrowRequest) _then) = _$ReleaseEscrowRequestCopyWithImpl;
@useResult
$Res call({
 String escrowPaymentId, String adminId, String? releaseNotes, bool confirmRelease
});




}
/// @nodoc
class _$ReleaseEscrowRequestCopyWithImpl<$Res>
    implements $ReleaseEscrowRequestCopyWith<$Res> {
  _$ReleaseEscrowRequestCopyWithImpl(this._self, this._then);

  final ReleaseEscrowRequest _self;
  final $Res Function(ReleaseEscrowRequest) _then;

/// Create a copy of ReleaseEscrowRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? escrowPaymentId = null,Object? adminId = null,Object? releaseNotes = freezed,Object? confirmRelease = null,}) {
  return _then(_self.copyWith(
escrowPaymentId: null == escrowPaymentId ? _self.escrowPaymentId : escrowPaymentId // ignore: cast_nullable_to_non_nullable
as String,adminId: null == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String,releaseNotes: freezed == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String?,confirmRelease: null == confirmRelease ? _self.confirmRelease : confirmRelease // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ReleaseEscrowRequest implements ReleaseEscrowRequest {
  const _ReleaseEscrowRequest({required this.escrowPaymentId, required this.adminId, this.releaseNotes, required this.confirmRelease});
  factory _ReleaseEscrowRequest.fromJson(Map<String, dynamic> json) => _$ReleaseEscrowRequestFromJson(json);

@override final  String escrowPaymentId;
@override final  String adminId;
@override final  String? releaseNotes;
@override final  bool confirmRelease;

/// Create a copy of ReleaseEscrowRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReleaseEscrowRequestCopyWith<_ReleaseEscrowRequest> get copyWith => __$ReleaseEscrowRequestCopyWithImpl<_ReleaseEscrowRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReleaseEscrowRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReleaseEscrowRequest&&(identical(other.escrowPaymentId, escrowPaymentId) || other.escrowPaymentId == escrowPaymentId)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes)&&(identical(other.confirmRelease, confirmRelease) || other.confirmRelease == confirmRelease));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,escrowPaymentId,adminId,releaseNotes,confirmRelease);

@override
String toString() {
  return 'ReleaseEscrowRequest(escrowPaymentId: $escrowPaymentId, adminId: $adminId, releaseNotes: $releaseNotes, confirmRelease: $confirmRelease)';
}


}

/// @nodoc
abstract mixin class _$ReleaseEscrowRequestCopyWith<$Res> implements $ReleaseEscrowRequestCopyWith<$Res> {
  factory _$ReleaseEscrowRequestCopyWith(_ReleaseEscrowRequest value, $Res Function(_ReleaseEscrowRequest) _then) = __$ReleaseEscrowRequestCopyWithImpl;
@override @useResult
$Res call({
 String escrowPaymentId, String adminId, String? releaseNotes, bool confirmRelease
});




}
/// @nodoc
class __$ReleaseEscrowRequestCopyWithImpl<$Res>
    implements _$ReleaseEscrowRequestCopyWith<$Res> {
  __$ReleaseEscrowRequestCopyWithImpl(this._self, this._then);

  final _ReleaseEscrowRequest _self;
  final $Res Function(_ReleaseEscrowRequest) _then;

/// Create a copy of ReleaseEscrowRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? escrowPaymentId = null,Object? adminId = null,Object? releaseNotes = freezed,Object? confirmRelease = null,}) {
  return _then(_ReleaseEscrowRequest(
escrowPaymentId: null == escrowPaymentId ? _self.escrowPaymentId : escrowPaymentId // ignore: cast_nullable_to_non_nullable
as String,adminId: null == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String,releaseNotes: freezed == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String?,confirmRelease: null == confirmRelease ? _self.confirmRelease : confirmRelease // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Dispute {

 String get id; String get transactionId; String get orderId; String get customerId; String get providerId; DisputeType get type; DisputeStatus get status; String get reason; String? get description; DateTime get createdAt; DateTime? get resolvedAt; String? get resolution; String? get adminId; double? get refundAmount; List<DisputeEvidence>? get evidence; List<DisputeMessage>? get messages;// Display info
 String? get customerName; String? get providerName; String? get serviceTitle; double? get originalAmount; String? get currency;
/// Create a copy of Dispute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeCopyWith<Dispute> get copyWith => _$DisputeCopyWithImpl<Dispute>(this as Dispute, _$identity);

  /// Serializes this Dispute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dispute&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&const DeepCollectionEquality().equals(other.evidence, evidence)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle)&&(identical(other.originalAmount, originalAmount) || other.originalAmount == originalAmount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,transactionId,orderId,customerId,providerId,type,status,reason,description,createdAt,resolvedAt,resolution,adminId,refundAmount,const DeepCollectionEquality().hash(evidence),const DeepCollectionEquality().hash(messages),customerName,providerName,serviceTitle,originalAmount,currency]);

@override
String toString() {
  return 'Dispute(id: $id, transactionId: $transactionId, orderId: $orderId, customerId: $customerId, providerId: $providerId, type: $type, status: $status, reason: $reason, description: $description, createdAt: $createdAt, resolvedAt: $resolvedAt, resolution: $resolution, adminId: $adminId, refundAmount: $refundAmount, evidence: $evidence, messages: $messages, customerName: $customerName, providerName: $providerName, serviceTitle: $serviceTitle, originalAmount: $originalAmount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $DisputeCopyWith<$Res>  {
  factory $DisputeCopyWith(Dispute value, $Res Function(Dispute) _then) = _$DisputeCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, String orderId, String customerId, String providerId, DisputeType type, DisputeStatus status, String reason, String? description, DateTime createdAt, DateTime? resolvedAt, String? resolution, String? adminId, double? refundAmount, List<DisputeEvidence>? evidence, List<DisputeMessage>? messages, String? customerName, String? providerName, String? serviceTitle, double? originalAmount, String? currency
});




}
/// @nodoc
class _$DisputeCopyWithImpl<$Res>
    implements $DisputeCopyWith<$Res> {
  _$DisputeCopyWithImpl(this._self, this._then);

  final Dispute _self;
  final $Res Function(Dispute) _then;

/// Create a copy of Dispute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? orderId = null,Object? customerId = null,Object? providerId = null,Object? type = null,Object? status = null,Object? reason = null,Object? description = freezed,Object? createdAt = null,Object? resolvedAt = freezed,Object? resolution = freezed,Object? adminId = freezed,Object? refundAmount = freezed,Object? evidence = freezed,Object? messages = freezed,Object? customerName = freezed,Object? providerName = freezed,Object? serviceTitle = freezed,Object? originalAmount = freezed,Object? currency = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DisputeType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DisputeStatus,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,adminId: freezed == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String?,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as double?,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as List<DisputeEvidence>?,messages: freezed == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<DisputeMessage>?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,serviceTitle: freezed == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String?,originalAmount: freezed == originalAmount ? _self.originalAmount : originalAmount // ignore: cast_nullable_to_non_nullable
as double?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Dispute implements Dispute {
  const _Dispute({required this.id, required this.transactionId, required this.orderId, required this.customerId, required this.providerId, required this.type, required this.status, required this.reason, this.description, required this.createdAt, this.resolvedAt, this.resolution, this.adminId, this.refundAmount, final  List<DisputeEvidence>? evidence, final  List<DisputeMessage>? messages, this.customerName, this.providerName, this.serviceTitle, this.originalAmount, this.currency}): _evidence = evidence,_messages = messages;
  factory _Dispute.fromJson(Map<String, dynamic> json) => _$DisputeFromJson(json);

@override final  String id;
@override final  String transactionId;
@override final  String orderId;
@override final  String customerId;
@override final  String providerId;
@override final  DisputeType type;
@override final  DisputeStatus status;
@override final  String reason;
@override final  String? description;
@override final  DateTime createdAt;
@override final  DateTime? resolvedAt;
@override final  String? resolution;
@override final  String? adminId;
@override final  double? refundAmount;
 final  List<DisputeEvidence>? _evidence;
@override List<DisputeEvidence>? get evidence {
  final value = _evidence;
  if (value == null) return null;
  if (_evidence is EqualUnmodifiableListView) return _evidence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DisputeMessage>? _messages;
@override List<DisputeMessage>? get messages {
  final value = _messages;
  if (value == null) return null;
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// Display info
@override final  String? customerName;
@override final  String? providerName;
@override final  String? serviceTitle;
@override final  double? originalAmount;
@override final  String? currency;

/// Create a copy of Dispute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeCopyWith<_Dispute> get copyWith => __$DisputeCopyWithImpl<_Dispute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisputeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dispute&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&const DeepCollectionEquality().equals(other._evidence, _evidence)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle)&&(identical(other.originalAmount, originalAmount) || other.originalAmount == originalAmount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,transactionId,orderId,customerId,providerId,type,status,reason,description,createdAt,resolvedAt,resolution,adminId,refundAmount,const DeepCollectionEquality().hash(_evidence),const DeepCollectionEquality().hash(_messages),customerName,providerName,serviceTitle,originalAmount,currency]);

@override
String toString() {
  return 'Dispute(id: $id, transactionId: $transactionId, orderId: $orderId, customerId: $customerId, providerId: $providerId, type: $type, status: $status, reason: $reason, description: $description, createdAt: $createdAt, resolvedAt: $resolvedAt, resolution: $resolution, adminId: $adminId, refundAmount: $refundAmount, evidence: $evidence, messages: $messages, customerName: $customerName, providerName: $providerName, serviceTitle: $serviceTitle, originalAmount: $originalAmount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$DisputeCopyWith<$Res> implements $DisputeCopyWith<$Res> {
  factory _$DisputeCopyWith(_Dispute value, $Res Function(_Dispute) _then) = __$DisputeCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, String orderId, String customerId, String providerId, DisputeType type, DisputeStatus status, String reason, String? description, DateTime createdAt, DateTime? resolvedAt, String? resolution, String? adminId, double? refundAmount, List<DisputeEvidence>? evidence, List<DisputeMessage>? messages, String? customerName, String? providerName, String? serviceTitle, double? originalAmount, String? currency
});




}
/// @nodoc
class __$DisputeCopyWithImpl<$Res>
    implements _$DisputeCopyWith<$Res> {
  __$DisputeCopyWithImpl(this._self, this._then);

  final _Dispute _self;
  final $Res Function(_Dispute) _then;

/// Create a copy of Dispute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? orderId = null,Object? customerId = null,Object? providerId = null,Object? type = null,Object? status = null,Object? reason = null,Object? description = freezed,Object? createdAt = null,Object? resolvedAt = freezed,Object? resolution = freezed,Object? adminId = freezed,Object? refundAmount = freezed,Object? evidence = freezed,Object? messages = freezed,Object? customerName = freezed,Object? providerName = freezed,Object? serviceTitle = freezed,Object? originalAmount = freezed,Object? currency = freezed,}) {
  return _then(_Dispute(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DisputeType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DisputeStatus,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,adminId: freezed == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String?,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as double?,evidence: freezed == evidence ? _self._evidence : evidence // ignore: cast_nullable_to_non_nullable
as List<DisputeEvidence>?,messages: freezed == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<DisputeMessage>?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,serviceTitle: freezed == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String?,originalAmount: freezed == originalAmount ? _self.originalAmount : originalAmount // ignore: cast_nullable_to_non_nullable
as double?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DisputeListItem {

 String get id; String get customerName; String get providerName; String get serviceTitle; DisputeType get type; DisputeStatus get status; double get originalAmount; String get currency; DateTime get createdAt; DateTime? get resolvedAt; bool? get isUrgent;
/// Create a copy of DisputeListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeListItemCopyWith<DisputeListItem> get copyWith => _$DisputeListItemCopyWithImpl<DisputeListItem>(this as DisputeListItem, _$identity);

  /// Serializes this DisputeListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.originalAmount, originalAmount) || other.originalAmount == originalAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerName,providerName,serviceTitle,type,status,originalAmount,currency,createdAt,resolvedAt,isUrgent);

@override
String toString() {
  return 'DisputeListItem(id: $id, customerName: $customerName, providerName: $providerName, serviceTitle: $serviceTitle, type: $type, status: $status, originalAmount: $originalAmount, currency: $currency, createdAt: $createdAt, resolvedAt: $resolvedAt, isUrgent: $isUrgent)';
}


}

/// @nodoc
abstract mixin class $DisputeListItemCopyWith<$Res>  {
  factory $DisputeListItemCopyWith(DisputeListItem value, $Res Function(DisputeListItem) _then) = _$DisputeListItemCopyWithImpl;
@useResult
$Res call({
 String id, String customerName, String providerName, String serviceTitle, DisputeType type, DisputeStatus status, double originalAmount, String currency, DateTime createdAt, DateTime? resolvedAt, bool? isUrgent
});




}
/// @nodoc
class _$DisputeListItemCopyWithImpl<$Res>
    implements $DisputeListItemCopyWith<$Res> {
  _$DisputeListItemCopyWithImpl(this._self, this._then);

  final DisputeListItem _self;
  final $Res Function(DisputeListItem) _then;

/// Create a copy of DisputeListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerName = null,Object? providerName = null,Object? serviceTitle = null,Object? type = null,Object? status = null,Object? originalAmount = null,Object? currency = null,Object? createdAt = null,Object? resolvedAt = freezed,Object? isUrgent = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,serviceTitle: null == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DisputeType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DisputeStatus,originalAmount: null == originalAmount ? _self.originalAmount : originalAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isUrgent: freezed == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DisputeListItem implements DisputeListItem {
  const _DisputeListItem({required this.id, required this.customerName, required this.providerName, required this.serviceTitle, required this.type, required this.status, required this.originalAmount, required this.currency, required this.createdAt, this.resolvedAt, this.isUrgent});
  factory _DisputeListItem.fromJson(Map<String, dynamic> json) => _$DisputeListItemFromJson(json);

@override final  String id;
@override final  String customerName;
@override final  String providerName;
@override final  String serviceTitle;
@override final  DisputeType type;
@override final  DisputeStatus status;
@override final  double originalAmount;
@override final  String currency;
@override final  DateTime createdAt;
@override final  DateTime? resolvedAt;
@override final  bool? isUrgent;

/// Create a copy of DisputeListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeListItemCopyWith<_DisputeListItem> get copyWith => __$DisputeListItemCopyWithImpl<_DisputeListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisputeListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.serviceTitle, serviceTitle) || other.serviceTitle == serviceTitle)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.originalAmount, originalAmount) || other.originalAmount == originalAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerName,providerName,serviceTitle,type,status,originalAmount,currency,createdAt,resolvedAt,isUrgent);

@override
String toString() {
  return 'DisputeListItem(id: $id, customerName: $customerName, providerName: $providerName, serviceTitle: $serviceTitle, type: $type, status: $status, originalAmount: $originalAmount, currency: $currency, createdAt: $createdAt, resolvedAt: $resolvedAt, isUrgent: $isUrgent)';
}


}

/// @nodoc
abstract mixin class _$DisputeListItemCopyWith<$Res> implements $DisputeListItemCopyWith<$Res> {
  factory _$DisputeListItemCopyWith(_DisputeListItem value, $Res Function(_DisputeListItem) _then) = __$DisputeListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerName, String providerName, String serviceTitle, DisputeType type, DisputeStatus status, double originalAmount, String currency, DateTime createdAt, DateTime? resolvedAt, bool? isUrgent
});




}
/// @nodoc
class __$DisputeListItemCopyWithImpl<$Res>
    implements _$DisputeListItemCopyWith<$Res> {
  __$DisputeListItemCopyWithImpl(this._self, this._then);

  final _DisputeListItem _self;
  final $Res Function(_DisputeListItem) _then;

/// Create a copy of DisputeListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerName = null,Object? providerName = null,Object? serviceTitle = null,Object? type = null,Object? status = null,Object? originalAmount = null,Object? currency = null,Object? createdAt = null,Object? resolvedAt = freezed,Object? isUrgent = freezed,}) {
  return _then(_DisputeListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,serviceTitle: null == serviceTitle ? _self.serviceTitle : serviceTitle // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DisputeType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DisputeStatus,originalAmount: null == originalAmount ? _self.originalAmount : originalAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isUrgent: freezed == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$DisputeEvidence {

 String get id; String get disputeId; String get uploadedBy; EvidenceType get type; String get fileName; String get fileUrl; String? get description; DateTime get uploadedAt;
/// Create a copy of DisputeEvidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeEvidenceCopyWith<DisputeEvidence> get copyWith => _$DisputeEvidenceCopyWithImpl<DisputeEvidence>(this as DisputeEvidence, _$identity);

  /// Serializes this DisputeEvidence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeEvidence&&(identical(other.id, id) || other.id == id)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.type, type) || other.type == type)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,disputeId,uploadedBy,type,fileName,fileUrl,description,uploadedAt);

@override
String toString() {
  return 'DisputeEvidence(id: $id, disputeId: $disputeId, uploadedBy: $uploadedBy, type: $type, fileName: $fileName, fileUrl: $fileUrl, description: $description, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class $DisputeEvidenceCopyWith<$Res>  {
  factory $DisputeEvidenceCopyWith(DisputeEvidence value, $Res Function(DisputeEvidence) _then) = _$DisputeEvidenceCopyWithImpl;
@useResult
$Res call({
 String id, String disputeId, String uploadedBy, EvidenceType type, String fileName, String fileUrl, String? description, DateTime uploadedAt
});




}
/// @nodoc
class _$DisputeEvidenceCopyWithImpl<$Res>
    implements $DisputeEvidenceCopyWith<$Res> {
  _$DisputeEvidenceCopyWithImpl(this._self, this._then);

  final DisputeEvidence _self;
  final $Res Function(DisputeEvidence) _then;

/// Create a copy of DisputeEvidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? disputeId = null,Object? uploadedBy = null,Object? type = null,Object? fileName = null,Object? fileUrl = null,Object? description = freezed,Object? uploadedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,disputeId: null == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String,uploadedBy: null == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EvidenceType,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DisputeEvidence implements DisputeEvidence {
  const _DisputeEvidence({required this.id, required this.disputeId, required this.uploadedBy, required this.type, required this.fileName, required this.fileUrl, this.description, required this.uploadedAt});
  factory _DisputeEvidence.fromJson(Map<String, dynamic> json) => _$DisputeEvidenceFromJson(json);

@override final  String id;
@override final  String disputeId;
@override final  String uploadedBy;
@override final  EvidenceType type;
@override final  String fileName;
@override final  String fileUrl;
@override final  String? description;
@override final  DateTime uploadedAt;

/// Create a copy of DisputeEvidence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeEvidenceCopyWith<_DisputeEvidence> get copyWith => __$DisputeEvidenceCopyWithImpl<_DisputeEvidence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisputeEvidenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeEvidence&&(identical(other.id, id) || other.id == id)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.type, type) || other.type == type)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,disputeId,uploadedBy,type,fileName,fileUrl,description,uploadedAt);

@override
String toString() {
  return 'DisputeEvidence(id: $id, disputeId: $disputeId, uploadedBy: $uploadedBy, type: $type, fileName: $fileName, fileUrl: $fileUrl, description: $description, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class _$DisputeEvidenceCopyWith<$Res> implements $DisputeEvidenceCopyWith<$Res> {
  factory _$DisputeEvidenceCopyWith(_DisputeEvidence value, $Res Function(_DisputeEvidence) _then) = __$DisputeEvidenceCopyWithImpl;
@override @useResult
$Res call({
 String id, String disputeId, String uploadedBy, EvidenceType type, String fileName, String fileUrl, String? description, DateTime uploadedAt
});




}
/// @nodoc
class __$DisputeEvidenceCopyWithImpl<$Res>
    implements _$DisputeEvidenceCopyWith<$Res> {
  __$DisputeEvidenceCopyWithImpl(this._self, this._then);

  final _DisputeEvidence _self;
  final $Res Function(_DisputeEvidence) _then;

/// Create a copy of DisputeEvidence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? disputeId = null,Object? uploadedBy = null,Object? type = null,Object? fileName = null,Object? fileUrl = null,Object? description = freezed,Object? uploadedAt = null,}) {
  return _then(_DisputeEvidence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,disputeId: null == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String,uploadedBy: null == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EvidenceType,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$DisputeMessage {

 String get id; String get disputeId; String get senderId; String get senderName; String get message; DateTime get sentAt; bool? get isAdminMessage;
/// Create a copy of DisputeMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeMessageCopyWith<DisputeMessage> get copyWith => _$DisputeMessageCopyWithImpl<DisputeMessage>(this as DisputeMessage, _$identity);

  /// Serializes this DisputeMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.message, message) || other.message == message)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.isAdminMessage, isAdminMessage) || other.isAdminMessage == isAdminMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,disputeId,senderId,senderName,message,sentAt,isAdminMessage);

@override
String toString() {
  return 'DisputeMessage(id: $id, disputeId: $disputeId, senderId: $senderId, senderName: $senderName, message: $message, sentAt: $sentAt, isAdminMessage: $isAdminMessage)';
}


}

/// @nodoc
abstract mixin class $DisputeMessageCopyWith<$Res>  {
  factory $DisputeMessageCopyWith(DisputeMessage value, $Res Function(DisputeMessage) _then) = _$DisputeMessageCopyWithImpl;
@useResult
$Res call({
 String id, String disputeId, String senderId, String senderName, String message, DateTime sentAt, bool? isAdminMessage
});




}
/// @nodoc
class _$DisputeMessageCopyWithImpl<$Res>
    implements $DisputeMessageCopyWith<$Res> {
  _$DisputeMessageCopyWithImpl(this._self, this._then);

  final DisputeMessage _self;
  final $Res Function(DisputeMessage) _then;

/// Create a copy of DisputeMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? disputeId = null,Object? senderId = null,Object? senderName = null,Object? message = null,Object? sentAt = null,Object? isAdminMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,disputeId: null == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,isAdminMessage: freezed == isAdminMessage ? _self.isAdminMessage : isAdminMessage // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DisputeMessage implements DisputeMessage {
  const _DisputeMessage({required this.id, required this.disputeId, required this.senderId, required this.senderName, required this.message, required this.sentAt, this.isAdminMessage});
  factory _DisputeMessage.fromJson(Map<String, dynamic> json) => _$DisputeMessageFromJson(json);

@override final  String id;
@override final  String disputeId;
@override final  String senderId;
@override final  String senderName;
@override final  String message;
@override final  DateTime sentAt;
@override final  bool? isAdminMessage;

/// Create a copy of DisputeMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeMessageCopyWith<_DisputeMessage> get copyWith => __$DisputeMessageCopyWithImpl<_DisputeMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisputeMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.message, message) || other.message == message)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.isAdminMessage, isAdminMessage) || other.isAdminMessage == isAdminMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,disputeId,senderId,senderName,message,sentAt,isAdminMessage);

@override
String toString() {
  return 'DisputeMessage(id: $id, disputeId: $disputeId, senderId: $senderId, senderName: $senderName, message: $message, sentAt: $sentAt, isAdminMessage: $isAdminMessage)';
}


}

/// @nodoc
abstract mixin class _$DisputeMessageCopyWith<$Res> implements $DisputeMessageCopyWith<$Res> {
  factory _$DisputeMessageCopyWith(_DisputeMessage value, $Res Function(_DisputeMessage) _then) = __$DisputeMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String disputeId, String senderId, String senderName, String message, DateTime sentAt, bool? isAdminMessage
});




}
/// @nodoc
class __$DisputeMessageCopyWithImpl<$Res>
    implements _$DisputeMessageCopyWith<$Res> {
  __$DisputeMessageCopyWithImpl(this._self, this._then);

  final _DisputeMessage _self;
  final $Res Function(_DisputeMessage) _then;

/// Create a copy of DisputeMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? disputeId = null,Object? senderId = null,Object? senderName = null,Object? message = null,Object? sentAt = null,Object? isAdminMessage = freezed,}) {
  return _then(_DisputeMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,disputeId: null == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,isAdminMessage: freezed == isAdminMessage ? _self.isAdminMessage : isAdminMessage // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ResolveDisputeRequest {

 String get disputeId; String get adminId; DisputeResolution get resolution; String? get resolutionNotes; double? get refundAmount; String? get refundReason;
/// Create a copy of ResolveDisputeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResolveDisputeRequestCopyWith<ResolveDisputeRequest> get copyWith => _$ResolveDisputeRequestCopyWithImpl<ResolveDisputeRequest>(this as ResolveDisputeRequest, _$identity);

  /// Serializes this ResolveDisputeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResolveDisputeRequest&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.resolutionNotes, resolutionNotes) || other.resolutionNotes == resolutionNotes)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,disputeId,adminId,resolution,resolutionNotes,refundAmount,refundReason);

@override
String toString() {
  return 'ResolveDisputeRequest(disputeId: $disputeId, adminId: $adminId, resolution: $resolution, resolutionNotes: $resolutionNotes, refundAmount: $refundAmount, refundReason: $refundReason)';
}


}

/// @nodoc
abstract mixin class $ResolveDisputeRequestCopyWith<$Res>  {
  factory $ResolveDisputeRequestCopyWith(ResolveDisputeRequest value, $Res Function(ResolveDisputeRequest) _then) = _$ResolveDisputeRequestCopyWithImpl;
@useResult
$Res call({
 String disputeId, String adminId, DisputeResolution resolution, String? resolutionNotes, double? refundAmount, String? refundReason
});




}
/// @nodoc
class _$ResolveDisputeRequestCopyWithImpl<$Res>
    implements $ResolveDisputeRequestCopyWith<$Res> {
  _$ResolveDisputeRequestCopyWithImpl(this._self, this._then);

  final ResolveDisputeRequest _self;
  final $Res Function(ResolveDisputeRequest) _then;

/// Create a copy of ResolveDisputeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? disputeId = null,Object? adminId = null,Object? resolution = null,Object? resolutionNotes = freezed,Object? refundAmount = freezed,Object? refundReason = freezed,}) {
  return _then(_self.copyWith(
disputeId: null == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String,adminId: null == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String,resolution: null == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as DisputeResolution,resolutionNotes: freezed == resolutionNotes ? _self.resolutionNotes : resolutionNotes // ignore: cast_nullable_to_non_nullable
as String?,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as double?,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ResolveDisputeRequest implements ResolveDisputeRequest {
  const _ResolveDisputeRequest({required this.disputeId, required this.adminId, required this.resolution, this.resolutionNotes, this.refundAmount, this.refundReason});
  factory _ResolveDisputeRequest.fromJson(Map<String, dynamic> json) => _$ResolveDisputeRequestFromJson(json);

@override final  String disputeId;
@override final  String adminId;
@override final  DisputeResolution resolution;
@override final  String? resolutionNotes;
@override final  double? refundAmount;
@override final  String? refundReason;

/// Create a copy of ResolveDisputeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResolveDisputeRequestCopyWith<_ResolveDisputeRequest> get copyWith => __$ResolveDisputeRequestCopyWithImpl<_ResolveDisputeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResolveDisputeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResolveDisputeRequest&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.resolutionNotes, resolutionNotes) || other.resolutionNotes == resolutionNotes)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,disputeId,adminId,resolution,resolutionNotes,refundAmount,refundReason);

@override
String toString() {
  return 'ResolveDisputeRequest(disputeId: $disputeId, adminId: $adminId, resolution: $resolution, resolutionNotes: $resolutionNotes, refundAmount: $refundAmount, refundReason: $refundReason)';
}


}

/// @nodoc
abstract mixin class _$ResolveDisputeRequestCopyWith<$Res> implements $ResolveDisputeRequestCopyWith<$Res> {
  factory _$ResolveDisputeRequestCopyWith(_ResolveDisputeRequest value, $Res Function(_ResolveDisputeRequest) _then) = __$ResolveDisputeRequestCopyWithImpl;
@override @useResult
$Res call({
 String disputeId, String adminId, DisputeResolution resolution, String? resolutionNotes, double? refundAmount, String? refundReason
});




}
/// @nodoc
class __$ResolveDisputeRequestCopyWithImpl<$Res>
    implements _$ResolveDisputeRequestCopyWith<$Res> {
  __$ResolveDisputeRequestCopyWithImpl(this._self, this._then);

  final _ResolveDisputeRequest _self;
  final $Res Function(_ResolveDisputeRequest) _then;

/// Create a copy of ResolveDisputeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? disputeId = null,Object? adminId = null,Object? resolution = null,Object? resolutionNotes = freezed,Object? refundAmount = freezed,Object? refundReason = freezed,}) {
  return _then(_ResolveDisputeRequest(
disputeId: null == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String,adminId: null == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String,resolution: null == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as DisputeResolution,resolutionNotes: freezed == resolutionNotes ? _self.resolutionNotes : resolutionNotes // ignore: cast_nullable_to_non_nullable
as String?,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as double?,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RefundRequest {

 String get transactionId; String get adminId; double get refundAmount; String get refundReason; String? get refundNotes; bool get confirmRefund;
/// Create a copy of RefundRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundRequestCopyWith<RefundRequest> get copyWith => _$RefundRequestCopyWithImpl<RefundRequest>(this as RefundRequest, _$identity);

  /// Serializes this RefundRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundRequest&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.refundNotes, refundNotes) || other.refundNotes == refundNotes)&&(identical(other.confirmRefund, confirmRefund) || other.confirmRefund == confirmRefund));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,adminId,refundAmount,refundReason,refundNotes,confirmRefund);

@override
String toString() {
  return 'RefundRequest(transactionId: $transactionId, adminId: $adminId, refundAmount: $refundAmount, refundReason: $refundReason, refundNotes: $refundNotes, confirmRefund: $confirmRefund)';
}


}

/// @nodoc
abstract mixin class $RefundRequestCopyWith<$Res>  {
  factory $RefundRequestCopyWith(RefundRequest value, $Res Function(RefundRequest) _then) = _$RefundRequestCopyWithImpl;
@useResult
$Res call({
 String transactionId, String adminId, double refundAmount, String refundReason, String? refundNotes, bool confirmRefund
});




}
/// @nodoc
class _$RefundRequestCopyWithImpl<$Res>
    implements $RefundRequestCopyWith<$Res> {
  _$RefundRequestCopyWithImpl(this._self, this._then);

  final RefundRequest _self;
  final $Res Function(RefundRequest) _then;

/// Create a copy of RefundRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? adminId = null,Object? refundAmount = null,Object? refundReason = null,Object? refundNotes = freezed,Object? confirmRefund = null,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,adminId: null == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String,refundAmount: null == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as double,refundReason: null == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String,refundNotes: freezed == refundNotes ? _self.refundNotes : refundNotes // ignore: cast_nullable_to_non_nullable
as String?,confirmRefund: null == confirmRefund ? _self.confirmRefund : confirmRefund // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RefundRequest implements RefundRequest {
  const _RefundRequest({required this.transactionId, required this.adminId, required this.refundAmount, required this.refundReason, this.refundNotes, required this.confirmRefund});
  factory _RefundRequest.fromJson(Map<String, dynamic> json) => _$RefundRequestFromJson(json);

@override final  String transactionId;
@override final  String adminId;
@override final  double refundAmount;
@override final  String refundReason;
@override final  String? refundNotes;
@override final  bool confirmRefund;

/// Create a copy of RefundRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundRequestCopyWith<_RefundRequest> get copyWith => __$RefundRequestCopyWithImpl<_RefundRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefundRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundRequest&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.adminId, adminId) || other.adminId == adminId)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.refundNotes, refundNotes) || other.refundNotes == refundNotes)&&(identical(other.confirmRefund, confirmRefund) || other.confirmRefund == confirmRefund));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,adminId,refundAmount,refundReason,refundNotes,confirmRefund);

@override
String toString() {
  return 'RefundRequest(transactionId: $transactionId, adminId: $adminId, refundAmount: $refundAmount, refundReason: $refundReason, refundNotes: $refundNotes, confirmRefund: $confirmRefund)';
}


}

/// @nodoc
abstract mixin class _$RefundRequestCopyWith<$Res> implements $RefundRequestCopyWith<$Res> {
  factory _$RefundRequestCopyWith(_RefundRequest value, $Res Function(_RefundRequest) _then) = __$RefundRequestCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, String adminId, double refundAmount, String refundReason, String? refundNotes, bool confirmRefund
});




}
/// @nodoc
class __$RefundRequestCopyWithImpl<$Res>
    implements _$RefundRequestCopyWith<$Res> {
  __$RefundRequestCopyWithImpl(this._self, this._then);

  final _RefundRequest _self;
  final $Res Function(_RefundRequest) _then;

/// Create a copy of RefundRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? adminId = null,Object? refundAmount = null,Object? refundReason = null,Object? refundNotes = freezed,Object? confirmRefund = null,}) {
  return _then(_RefundRequest(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,adminId: null == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String,refundAmount: null == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as double,refundReason: null == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String,refundNotes: freezed == refundNotes ? _self.refundNotes : refundNotes // ignore: cast_nullable_to_non_nullable
as String?,confirmRefund: null == confirmRefund ? _self.confirmRefund : confirmRefund // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FinancialMetrics {

 double get totalRevenue; double get totalEscrowHeld; double get totalRefunded; int get totalTransactions; int get pendingEscrows; int get activeDisputes; double get averageTransactionValue; double get refundRate; Map<String, double> get revenueByMonth; Map<String, int> get transactionsByStatus; List<TopProvider> get topProviders;
/// Create a copy of FinancialMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialMetricsCopyWith<FinancialMetrics> get copyWith => _$FinancialMetricsCopyWithImpl<FinancialMetrics>(this as FinancialMetrics, _$identity);

  /// Serializes this FinancialMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialMetrics&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalEscrowHeld, totalEscrowHeld) || other.totalEscrowHeld == totalEscrowHeld)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.totalTransactions, totalTransactions) || other.totalTransactions == totalTransactions)&&(identical(other.pendingEscrows, pendingEscrows) || other.pendingEscrows == pendingEscrows)&&(identical(other.activeDisputes, activeDisputes) || other.activeDisputes == activeDisputes)&&(identical(other.averageTransactionValue, averageTransactionValue) || other.averageTransactionValue == averageTransactionValue)&&(identical(other.refundRate, refundRate) || other.refundRate == refundRate)&&const DeepCollectionEquality().equals(other.revenueByMonth, revenueByMonth)&&const DeepCollectionEquality().equals(other.transactionsByStatus, transactionsByStatus)&&const DeepCollectionEquality().equals(other.topProviders, topProviders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalEscrowHeld,totalRefunded,totalTransactions,pendingEscrows,activeDisputes,averageTransactionValue,refundRate,const DeepCollectionEquality().hash(revenueByMonth),const DeepCollectionEquality().hash(transactionsByStatus),const DeepCollectionEquality().hash(topProviders));

@override
String toString() {
  return 'FinancialMetrics(totalRevenue: $totalRevenue, totalEscrowHeld: $totalEscrowHeld, totalRefunded: $totalRefunded, totalTransactions: $totalTransactions, pendingEscrows: $pendingEscrows, activeDisputes: $activeDisputes, averageTransactionValue: $averageTransactionValue, refundRate: $refundRate, revenueByMonth: $revenueByMonth, transactionsByStatus: $transactionsByStatus, topProviders: $topProviders)';
}


}

/// @nodoc
abstract mixin class $FinancialMetricsCopyWith<$Res>  {
  factory $FinancialMetricsCopyWith(FinancialMetrics value, $Res Function(FinancialMetrics) _then) = _$FinancialMetricsCopyWithImpl;
@useResult
$Res call({
 double totalRevenue, double totalEscrowHeld, double totalRefunded, int totalTransactions, int pendingEscrows, int activeDisputes, double averageTransactionValue, double refundRate, Map<String, double> revenueByMonth, Map<String, int> transactionsByStatus, List<TopProvider> topProviders
});




}
/// @nodoc
class _$FinancialMetricsCopyWithImpl<$Res>
    implements $FinancialMetricsCopyWith<$Res> {
  _$FinancialMetricsCopyWithImpl(this._self, this._then);

  final FinancialMetrics _self;
  final $Res Function(FinancialMetrics) _then;

/// Create a copy of FinancialMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRevenue = null,Object? totalEscrowHeld = null,Object? totalRefunded = null,Object? totalTransactions = null,Object? pendingEscrows = null,Object? activeDisputes = null,Object? averageTransactionValue = null,Object? refundRate = null,Object? revenueByMonth = null,Object? transactionsByStatus = null,Object? topProviders = null,}) {
  return _then(_self.copyWith(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalEscrowHeld: null == totalEscrowHeld ? _self.totalEscrowHeld : totalEscrowHeld // ignore: cast_nullable_to_non_nullable
as double,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,totalTransactions: null == totalTransactions ? _self.totalTransactions : totalTransactions // ignore: cast_nullable_to_non_nullable
as int,pendingEscrows: null == pendingEscrows ? _self.pendingEscrows : pendingEscrows // ignore: cast_nullable_to_non_nullable
as int,activeDisputes: null == activeDisputes ? _self.activeDisputes : activeDisputes // ignore: cast_nullable_to_non_nullable
as int,averageTransactionValue: null == averageTransactionValue ? _self.averageTransactionValue : averageTransactionValue // ignore: cast_nullable_to_non_nullable
as double,refundRate: null == refundRate ? _self.refundRate : refundRate // ignore: cast_nullable_to_non_nullable
as double,revenueByMonth: null == revenueByMonth ? _self.revenueByMonth : revenueByMonth // ignore: cast_nullable_to_non_nullable
as Map<String, double>,transactionsByStatus: null == transactionsByStatus ? _self.transactionsByStatus : transactionsByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,topProviders: null == topProviders ? _self.topProviders : topProviders // ignore: cast_nullable_to_non_nullable
as List<TopProvider>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FinancialMetrics implements FinancialMetrics {
  const _FinancialMetrics({required this.totalRevenue, required this.totalEscrowHeld, required this.totalRefunded, required this.totalTransactions, required this.pendingEscrows, required this.activeDisputes, required this.averageTransactionValue, required this.refundRate, required final  Map<String, double> revenueByMonth, required final  Map<String, int> transactionsByStatus, required final  List<TopProvider> topProviders}): _revenueByMonth = revenueByMonth,_transactionsByStatus = transactionsByStatus,_topProviders = topProviders;
  factory _FinancialMetrics.fromJson(Map<String, dynamic> json) => _$FinancialMetricsFromJson(json);

@override final  double totalRevenue;
@override final  double totalEscrowHeld;
@override final  double totalRefunded;
@override final  int totalTransactions;
@override final  int pendingEscrows;
@override final  int activeDisputes;
@override final  double averageTransactionValue;
@override final  double refundRate;
 final  Map<String, double> _revenueByMonth;
@override Map<String, double> get revenueByMonth {
  if (_revenueByMonth is EqualUnmodifiableMapView) return _revenueByMonth;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_revenueByMonth);
}

 final  Map<String, int> _transactionsByStatus;
@override Map<String, int> get transactionsByStatus {
  if (_transactionsByStatus is EqualUnmodifiableMapView) return _transactionsByStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_transactionsByStatus);
}

 final  List<TopProvider> _topProviders;
@override List<TopProvider> get topProviders {
  if (_topProviders is EqualUnmodifiableListView) return _topProviders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topProviders);
}


/// Create a copy of FinancialMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialMetricsCopyWith<_FinancialMetrics> get copyWith => __$FinancialMetricsCopyWithImpl<_FinancialMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinancialMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialMetrics&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalEscrowHeld, totalEscrowHeld) || other.totalEscrowHeld == totalEscrowHeld)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.totalTransactions, totalTransactions) || other.totalTransactions == totalTransactions)&&(identical(other.pendingEscrows, pendingEscrows) || other.pendingEscrows == pendingEscrows)&&(identical(other.activeDisputes, activeDisputes) || other.activeDisputes == activeDisputes)&&(identical(other.averageTransactionValue, averageTransactionValue) || other.averageTransactionValue == averageTransactionValue)&&(identical(other.refundRate, refundRate) || other.refundRate == refundRate)&&const DeepCollectionEquality().equals(other._revenueByMonth, _revenueByMonth)&&const DeepCollectionEquality().equals(other._transactionsByStatus, _transactionsByStatus)&&const DeepCollectionEquality().equals(other._topProviders, _topProviders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalEscrowHeld,totalRefunded,totalTransactions,pendingEscrows,activeDisputes,averageTransactionValue,refundRate,const DeepCollectionEquality().hash(_revenueByMonth),const DeepCollectionEquality().hash(_transactionsByStatus),const DeepCollectionEquality().hash(_topProviders));

@override
String toString() {
  return 'FinancialMetrics(totalRevenue: $totalRevenue, totalEscrowHeld: $totalEscrowHeld, totalRefunded: $totalRefunded, totalTransactions: $totalTransactions, pendingEscrows: $pendingEscrows, activeDisputes: $activeDisputes, averageTransactionValue: $averageTransactionValue, refundRate: $refundRate, revenueByMonth: $revenueByMonth, transactionsByStatus: $transactionsByStatus, topProviders: $topProviders)';
}


}

/// @nodoc
abstract mixin class _$FinancialMetricsCopyWith<$Res> implements $FinancialMetricsCopyWith<$Res> {
  factory _$FinancialMetricsCopyWith(_FinancialMetrics value, $Res Function(_FinancialMetrics) _then) = __$FinancialMetricsCopyWithImpl;
@override @useResult
$Res call({
 double totalRevenue, double totalEscrowHeld, double totalRefunded, int totalTransactions, int pendingEscrows, int activeDisputes, double averageTransactionValue, double refundRate, Map<String, double> revenueByMonth, Map<String, int> transactionsByStatus, List<TopProvider> topProviders
});




}
/// @nodoc
class __$FinancialMetricsCopyWithImpl<$Res>
    implements _$FinancialMetricsCopyWith<$Res> {
  __$FinancialMetricsCopyWithImpl(this._self, this._then);

  final _FinancialMetrics _self;
  final $Res Function(_FinancialMetrics) _then;

/// Create a copy of FinancialMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRevenue = null,Object? totalEscrowHeld = null,Object? totalRefunded = null,Object? totalTransactions = null,Object? pendingEscrows = null,Object? activeDisputes = null,Object? averageTransactionValue = null,Object? refundRate = null,Object? revenueByMonth = null,Object? transactionsByStatus = null,Object? topProviders = null,}) {
  return _then(_FinancialMetrics(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalEscrowHeld: null == totalEscrowHeld ? _self.totalEscrowHeld : totalEscrowHeld // ignore: cast_nullable_to_non_nullable
as double,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,totalTransactions: null == totalTransactions ? _self.totalTransactions : totalTransactions // ignore: cast_nullable_to_non_nullable
as int,pendingEscrows: null == pendingEscrows ? _self.pendingEscrows : pendingEscrows // ignore: cast_nullable_to_non_nullable
as int,activeDisputes: null == activeDisputes ? _self.activeDisputes : activeDisputes // ignore: cast_nullable_to_non_nullable
as int,averageTransactionValue: null == averageTransactionValue ? _self.averageTransactionValue : averageTransactionValue // ignore: cast_nullable_to_non_nullable
as double,refundRate: null == refundRate ? _self.refundRate : refundRate // ignore: cast_nullable_to_non_nullable
as double,revenueByMonth: null == revenueByMonth ? _self._revenueByMonth : revenueByMonth // ignore: cast_nullable_to_non_nullable
as Map<String, double>,transactionsByStatus: null == transactionsByStatus ? _self._transactionsByStatus : transactionsByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,topProviders: null == topProviders ? _self._topProviders : topProviders // ignore: cast_nullable_to_non_nullable
as List<TopProvider>,
  ));
}


}


/// @nodoc
mixin _$TopProvider {

 String get providerId; String get providerName; double get totalRevenue; int get totalOrders; double get averageOrderValue;
/// Create a copy of TopProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopProviderCopyWith<TopProvider> get copyWith => _$TopProviderCopyWithImpl<TopProvider>(this as TopProvider, _$identity);

  /// Serializes this TopProvider to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopProvider&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.averageOrderValue, averageOrderValue) || other.averageOrderValue == averageOrderValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,providerId,providerName,totalRevenue,totalOrders,averageOrderValue);

@override
String toString() {
  return 'TopProvider(providerId: $providerId, providerName: $providerName, totalRevenue: $totalRevenue, totalOrders: $totalOrders, averageOrderValue: $averageOrderValue)';
}


}

/// @nodoc
abstract mixin class $TopProviderCopyWith<$Res>  {
  factory $TopProviderCopyWith(TopProvider value, $Res Function(TopProvider) _then) = _$TopProviderCopyWithImpl;
@useResult
$Res call({
 String providerId, String providerName, double totalRevenue, int totalOrders, double averageOrderValue
});




}
/// @nodoc
class _$TopProviderCopyWithImpl<$Res>
    implements $TopProviderCopyWith<$Res> {
  _$TopProviderCopyWithImpl(this._self, this._then);

  final TopProvider _self;
  final $Res Function(TopProvider) _then;

/// Create a copy of TopProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? providerId = null,Object? providerName = null,Object? totalRevenue = null,Object? totalOrders = null,Object? averageOrderValue = null,}) {
  return _then(_self.copyWith(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,averageOrderValue: null == averageOrderValue ? _self.averageOrderValue : averageOrderValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TopProvider implements TopProvider {
  const _TopProvider({required this.providerId, required this.providerName, required this.totalRevenue, required this.totalOrders, required this.averageOrderValue});
  factory _TopProvider.fromJson(Map<String, dynamic> json) => _$TopProviderFromJson(json);

@override final  String providerId;
@override final  String providerName;
@override final  double totalRevenue;
@override final  int totalOrders;
@override final  double averageOrderValue;

/// Create a copy of TopProvider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopProviderCopyWith<_TopProvider> get copyWith => __$TopProviderCopyWithImpl<_TopProvider>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopProviderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopProvider&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.averageOrderValue, averageOrderValue) || other.averageOrderValue == averageOrderValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,providerId,providerName,totalRevenue,totalOrders,averageOrderValue);

@override
String toString() {
  return 'TopProvider(providerId: $providerId, providerName: $providerName, totalRevenue: $totalRevenue, totalOrders: $totalOrders, averageOrderValue: $averageOrderValue)';
}


}

/// @nodoc
abstract mixin class _$TopProviderCopyWith<$Res> implements $TopProviderCopyWith<$Res> {
  factory _$TopProviderCopyWith(_TopProvider value, $Res Function(_TopProvider) _then) = __$TopProviderCopyWithImpl;
@override @useResult
$Res call({
 String providerId, String providerName, double totalRevenue, int totalOrders, double averageOrderValue
});




}
/// @nodoc
class __$TopProviderCopyWithImpl<$Res>
    implements _$TopProviderCopyWith<$Res> {
  __$TopProviderCopyWithImpl(this._self, this._then);

  final _TopProvider _self;
  final $Res Function(_TopProvider) _then;

/// Create a copy of TopProvider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? providerId = null,Object? providerName = null,Object? totalRevenue = null,Object? totalOrders = null,Object? averageOrderValue = null,}) {
  return _then(_TopProvider(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,averageOrderValue: null == averageOrderValue ? _self.averageOrderValue : averageOrderValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
