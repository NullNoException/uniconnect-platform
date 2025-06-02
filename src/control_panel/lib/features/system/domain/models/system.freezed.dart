// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlatformSettings {

 String get id; String get settingKey; String get settingValue; SettingCategory get category; SettingType get type; String get displayName; String get description; bool get isPublic; bool get isEditable; String? get defaultValue; String? get validationRules; DateTime get createdAt; DateTime get updatedAt; String? get updatedBy;
/// Create a copy of PlatformSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformSettingsCopyWith<PlatformSettings> get copyWith => _$PlatformSettingsCopyWithImpl<PlatformSettings>(this as PlatformSettings, _$identity);

  /// Serializes this PlatformSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.settingKey, settingKey) || other.settingKey == settingKey)&&(identical(other.settingValue, settingValue) || other.settingValue == settingValue)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.isEditable, isEditable) || other.isEditable == isEditable)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue)&&(identical(other.validationRules, validationRules) || other.validationRules == validationRules)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,settingKey,settingValue,category,type,displayName,description,isPublic,isEditable,defaultValue,validationRules,createdAt,updatedAt,updatedBy);

@override
String toString() {
  return 'PlatformSettings(id: $id, settingKey: $settingKey, settingValue: $settingValue, category: $category, type: $type, displayName: $displayName, description: $description, isPublic: $isPublic, isEditable: $isEditable, defaultValue: $defaultValue, validationRules: $validationRules, createdAt: $createdAt, updatedAt: $updatedAt, updatedBy: $updatedBy)';
}


}

/// @nodoc
abstract mixin class $PlatformSettingsCopyWith<$Res>  {
  factory $PlatformSettingsCopyWith(PlatformSettings value, $Res Function(PlatformSettings) _then) = _$PlatformSettingsCopyWithImpl;
@useResult
$Res call({
 String id, String settingKey, String settingValue, SettingCategory category, SettingType type, String displayName, String description, bool isPublic, bool isEditable, String? defaultValue, String? validationRules, DateTime createdAt, DateTime updatedAt, String? updatedBy
});




}
/// @nodoc
class _$PlatformSettingsCopyWithImpl<$Res>
    implements $PlatformSettingsCopyWith<$Res> {
  _$PlatformSettingsCopyWithImpl(this._self, this._then);

  final PlatformSettings _self;
  final $Res Function(PlatformSettings) _then;

/// Create a copy of PlatformSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? settingKey = null,Object? settingValue = null,Object? category = null,Object? type = null,Object? displayName = null,Object? description = null,Object? isPublic = null,Object? isEditable = null,Object? defaultValue = freezed,Object? validationRules = freezed,Object? createdAt = null,Object? updatedAt = null,Object? updatedBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,settingKey: null == settingKey ? _self.settingKey : settingKey // ignore: cast_nullable_to_non_nullable
as String,settingValue: null == settingValue ? _self.settingValue : settingValue // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SettingCategory,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SettingType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,isEditable: null == isEditable ? _self.isEditable : isEditable // ignore: cast_nullable_to_non_nullable
as bool,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as String?,validationRules: freezed == validationRules ? _self.validationRules : validationRules // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedBy: freezed == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PlatformSettings implements PlatformSettings {
  const _PlatformSettings({required this.id, required this.settingKey, required this.settingValue, required this.category, required this.type, required this.displayName, required this.description, required this.isPublic, required this.isEditable, this.defaultValue, this.validationRules, required this.createdAt, required this.updatedAt, this.updatedBy});
  factory _PlatformSettings.fromJson(Map<String, dynamic> json) => _$PlatformSettingsFromJson(json);

@override final  String id;
@override final  String settingKey;
@override final  String settingValue;
@override final  SettingCategory category;
@override final  SettingType type;
@override final  String displayName;
@override final  String description;
@override final  bool isPublic;
@override final  bool isEditable;
@override final  String? defaultValue;
@override final  String? validationRules;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? updatedBy;

/// Create a copy of PlatformSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformSettingsCopyWith<_PlatformSettings> get copyWith => __$PlatformSettingsCopyWithImpl<_PlatformSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.settingKey, settingKey) || other.settingKey == settingKey)&&(identical(other.settingValue, settingValue) || other.settingValue == settingValue)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.isEditable, isEditable) || other.isEditable == isEditable)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue)&&(identical(other.validationRules, validationRules) || other.validationRules == validationRules)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,settingKey,settingValue,category,type,displayName,description,isPublic,isEditable,defaultValue,validationRules,createdAt,updatedAt,updatedBy);

@override
String toString() {
  return 'PlatformSettings(id: $id, settingKey: $settingKey, settingValue: $settingValue, category: $category, type: $type, displayName: $displayName, description: $description, isPublic: $isPublic, isEditable: $isEditable, defaultValue: $defaultValue, validationRules: $validationRules, createdAt: $createdAt, updatedAt: $updatedAt, updatedBy: $updatedBy)';
}


}

/// @nodoc
abstract mixin class _$PlatformSettingsCopyWith<$Res> implements $PlatformSettingsCopyWith<$Res> {
  factory _$PlatformSettingsCopyWith(_PlatformSettings value, $Res Function(_PlatformSettings) _then) = __$PlatformSettingsCopyWithImpl;
@override @useResult
$Res call({
 String id, String settingKey, String settingValue, SettingCategory category, SettingType type, String displayName, String description, bool isPublic, bool isEditable, String? defaultValue, String? validationRules, DateTime createdAt, DateTime updatedAt, String? updatedBy
});




}
/// @nodoc
class __$PlatformSettingsCopyWithImpl<$Res>
    implements _$PlatformSettingsCopyWith<$Res> {
  __$PlatformSettingsCopyWithImpl(this._self, this._then);

  final _PlatformSettings _self;
  final $Res Function(_PlatformSettings) _then;

/// Create a copy of PlatformSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? settingKey = null,Object? settingValue = null,Object? category = null,Object? type = null,Object? displayName = null,Object? description = null,Object? isPublic = null,Object? isEditable = null,Object? defaultValue = freezed,Object? validationRules = freezed,Object? createdAt = null,Object? updatedAt = null,Object? updatedBy = freezed,}) {
  return _then(_PlatformSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,settingKey: null == settingKey ? _self.settingKey : settingKey // ignore: cast_nullable_to_non_nullable
as String,settingValue: null == settingValue ? _self.settingValue : settingValue // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SettingCategory,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SettingType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,isEditable: null == isEditable ? _self.isEditable : isEditable // ignore: cast_nullable_to_non_nullable
as bool,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as String?,validationRules: freezed == validationRules ? _self.validationRules : validationRules // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedBy: freezed == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PlatformSettingsListItem {

 String get id; String get settingKey; String get settingValue; SettingCategory get category; SettingType get type; String get displayName; bool get isEditable; DateTime get updatedAt;
/// Create a copy of PlatformSettingsListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformSettingsListItemCopyWith<PlatformSettingsListItem> get copyWith => _$PlatformSettingsListItemCopyWithImpl<PlatformSettingsListItem>(this as PlatformSettingsListItem, _$identity);

  /// Serializes this PlatformSettingsListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformSettingsListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.settingKey, settingKey) || other.settingKey == settingKey)&&(identical(other.settingValue, settingValue) || other.settingValue == settingValue)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isEditable, isEditable) || other.isEditable == isEditable)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,settingKey,settingValue,category,type,displayName,isEditable,updatedAt);

@override
String toString() {
  return 'PlatformSettingsListItem(id: $id, settingKey: $settingKey, settingValue: $settingValue, category: $category, type: $type, displayName: $displayName, isEditable: $isEditable, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlatformSettingsListItemCopyWith<$Res>  {
  factory $PlatformSettingsListItemCopyWith(PlatformSettingsListItem value, $Res Function(PlatformSettingsListItem) _then) = _$PlatformSettingsListItemCopyWithImpl;
@useResult
$Res call({
 String id, String settingKey, String settingValue, SettingCategory category, SettingType type, String displayName, bool isEditable, DateTime updatedAt
});




}
/// @nodoc
class _$PlatformSettingsListItemCopyWithImpl<$Res>
    implements $PlatformSettingsListItemCopyWith<$Res> {
  _$PlatformSettingsListItemCopyWithImpl(this._self, this._then);

  final PlatformSettingsListItem _self;
  final $Res Function(PlatformSettingsListItem) _then;

/// Create a copy of PlatformSettingsListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? settingKey = null,Object? settingValue = null,Object? category = null,Object? type = null,Object? displayName = null,Object? isEditable = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,settingKey: null == settingKey ? _self.settingKey : settingKey // ignore: cast_nullable_to_non_nullable
as String,settingValue: null == settingValue ? _self.settingValue : settingValue // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SettingCategory,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SettingType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isEditable: null == isEditable ? _self.isEditable : isEditable // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PlatformSettingsListItem implements PlatformSettingsListItem {
  const _PlatformSettingsListItem({required this.id, required this.settingKey, required this.settingValue, required this.category, required this.type, required this.displayName, required this.isEditable, required this.updatedAt});
  factory _PlatformSettingsListItem.fromJson(Map<String, dynamic> json) => _$PlatformSettingsListItemFromJson(json);

@override final  String id;
@override final  String settingKey;
@override final  String settingValue;
@override final  SettingCategory category;
@override final  SettingType type;
@override final  String displayName;
@override final  bool isEditable;
@override final  DateTime updatedAt;

/// Create a copy of PlatformSettingsListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformSettingsListItemCopyWith<_PlatformSettingsListItem> get copyWith => __$PlatformSettingsListItemCopyWithImpl<_PlatformSettingsListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformSettingsListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformSettingsListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.settingKey, settingKey) || other.settingKey == settingKey)&&(identical(other.settingValue, settingValue) || other.settingValue == settingValue)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isEditable, isEditable) || other.isEditable == isEditable)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,settingKey,settingValue,category,type,displayName,isEditable,updatedAt);

@override
String toString() {
  return 'PlatformSettingsListItem(id: $id, settingKey: $settingKey, settingValue: $settingValue, category: $category, type: $type, displayName: $displayName, isEditable: $isEditable, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlatformSettingsListItemCopyWith<$Res> implements $PlatformSettingsListItemCopyWith<$Res> {
  factory _$PlatformSettingsListItemCopyWith(_PlatformSettingsListItem value, $Res Function(_PlatformSettingsListItem) _then) = __$PlatformSettingsListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String settingKey, String settingValue, SettingCategory category, SettingType type, String displayName, bool isEditable, DateTime updatedAt
});




}
/// @nodoc
class __$PlatformSettingsListItemCopyWithImpl<$Res>
    implements _$PlatformSettingsListItemCopyWith<$Res> {
  __$PlatformSettingsListItemCopyWithImpl(this._self, this._then);

  final _PlatformSettingsListItem _self;
  final $Res Function(_PlatformSettingsListItem) _then;

/// Create a copy of PlatformSettingsListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? settingKey = null,Object? settingValue = null,Object? category = null,Object? type = null,Object? displayName = null,Object? isEditable = null,Object? updatedAt = null,}) {
  return _then(_PlatformSettingsListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,settingKey: null == settingKey ? _self.settingKey : settingKey // ignore: cast_nullable_to_non_nullable
as String,settingValue: null == settingValue ? _self.settingValue : settingValue // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SettingCategory,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SettingType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isEditable: null == isEditable ? _self.isEditable : isEditable // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SettingsUpdateRequest {

 String get settingValue; String? get reason;
/// Create a copy of SettingsUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsUpdateRequestCopyWith<SettingsUpdateRequest> get copyWith => _$SettingsUpdateRequestCopyWithImpl<SettingsUpdateRequest>(this as SettingsUpdateRequest, _$identity);

  /// Serializes this SettingsUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsUpdateRequest&&(identical(other.settingValue, settingValue) || other.settingValue == settingValue)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,settingValue,reason);

@override
String toString() {
  return 'SettingsUpdateRequest(settingValue: $settingValue, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $SettingsUpdateRequestCopyWith<$Res>  {
  factory $SettingsUpdateRequestCopyWith(SettingsUpdateRequest value, $Res Function(SettingsUpdateRequest) _then) = _$SettingsUpdateRequestCopyWithImpl;
@useResult
$Res call({
 String settingValue, String? reason
});




}
/// @nodoc
class _$SettingsUpdateRequestCopyWithImpl<$Res>
    implements $SettingsUpdateRequestCopyWith<$Res> {
  _$SettingsUpdateRequestCopyWithImpl(this._self, this._then);

  final SettingsUpdateRequest _self;
  final $Res Function(SettingsUpdateRequest) _then;

/// Create a copy of SettingsUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settingValue = null,Object? reason = freezed,}) {
  return _then(_self.copyWith(
settingValue: null == settingValue ? _self.settingValue : settingValue // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SettingsUpdateRequest implements SettingsUpdateRequest {
  const _SettingsUpdateRequest({required this.settingValue, this.reason});
  factory _SettingsUpdateRequest.fromJson(Map<String, dynamic> json) => _$SettingsUpdateRequestFromJson(json);

@override final  String settingValue;
@override final  String? reason;

/// Create a copy of SettingsUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsUpdateRequestCopyWith<_SettingsUpdateRequest> get copyWith => __$SettingsUpdateRequestCopyWithImpl<_SettingsUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsUpdateRequest&&(identical(other.settingValue, settingValue) || other.settingValue == settingValue)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,settingValue,reason);

@override
String toString() {
  return 'SettingsUpdateRequest(settingValue: $settingValue, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$SettingsUpdateRequestCopyWith<$Res> implements $SettingsUpdateRequestCopyWith<$Res> {
  factory _$SettingsUpdateRequestCopyWith(_SettingsUpdateRequest value, $Res Function(_SettingsUpdateRequest) _then) = __$SettingsUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 String settingValue, String? reason
});




}
/// @nodoc
class __$SettingsUpdateRequestCopyWithImpl<$Res>
    implements _$SettingsUpdateRequestCopyWith<$Res> {
  __$SettingsUpdateRequestCopyWithImpl(this._self, this._then);

  final _SettingsUpdateRequest _self;
  final $Res Function(_SettingsUpdateRequest) _then;

/// Create a copy of SettingsUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settingValue = null,Object? reason = freezed,}) {
  return _then(_SettingsUpdateRequest(
settingValue: null == settingValue ? _self.settingValue : settingValue // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SystemConfiguration {

 String get version; Map<String, String> get settings; Map<String, bool> get featureFlags; bool get maintenanceMode; DateTime get lastUpdated; String get environment;
/// Create a copy of SystemConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemConfigurationCopyWith<SystemConfiguration> get copyWith => _$SystemConfigurationCopyWithImpl<SystemConfiguration>(this as SystemConfiguration, _$identity);

  /// Serializes this SystemConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemConfiguration&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.settings, settings)&&const DeepCollectionEquality().equals(other.featureFlags, featureFlags)&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.environment, environment) || other.environment == environment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,const DeepCollectionEquality().hash(settings),const DeepCollectionEquality().hash(featureFlags),maintenanceMode,lastUpdated,environment);

@override
String toString() {
  return 'SystemConfiguration(version: $version, settings: $settings, featureFlags: $featureFlags, maintenanceMode: $maintenanceMode, lastUpdated: $lastUpdated, environment: $environment)';
}


}

/// @nodoc
abstract mixin class $SystemConfigurationCopyWith<$Res>  {
  factory $SystemConfigurationCopyWith(SystemConfiguration value, $Res Function(SystemConfiguration) _then) = _$SystemConfigurationCopyWithImpl;
@useResult
$Res call({
 String version, Map<String, String> settings, Map<String, bool> featureFlags, bool maintenanceMode, DateTime lastUpdated, String environment
});




}
/// @nodoc
class _$SystemConfigurationCopyWithImpl<$Res>
    implements $SystemConfigurationCopyWith<$Res> {
  _$SystemConfigurationCopyWithImpl(this._self, this._then);

  final SystemConfiguration _self;
  final $Res Function(SystemConfiguration) _then;

/// Create a copy of SystemConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? settings = null,Object? featureFlags = null,Object? maintenanceMode = null,Object? lastUpdated = null,Object? environment = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, String>,featureFlags: null == featureFlags ? _self.featureFlags : featureFlags // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SystemConfiguration implements SystemConfiguration {
  const _SystemConfiguration({required this.version, required final  Map<String, String> settings, required final  Map<String, bool> featureFlags, required this.maintenanceMode, required this.lastUpdated, required this.environment}): _settings = settings,_featureFlags = featureFlags;
  factory _SystemConfiguration.fromJson(Map<String, dynamic> json) => _$SystemConfigurationFromJson(json);

@override final  String version;
 final  Map<String, String> _settings;
@override Map<String, String> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}

 final  Map<String, bool> _featureFlags;
@override Map<String, bool> get featureFlags {
  if (_featureFlags is EqualUnmodifiableMapView) return _featureFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_featureFlags);
}

@override final  bool maintenanceMode;
@override final  DateTime lastUpdated;
@override final  String environment;

/// Create a copy of SystemConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystemConfigurationCopyWith<_SystemConfiguration> get copyWith => __$SystemConfigurationCopyWithImpl<_SystemConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SystemConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystemConfiguration&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._settings, _settings)&&const DeepCollectionEquality().equals(other._featureFlags, _featureFlags)&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.environment, environment) || other.environment == environment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,const DeepCollectionEquality().hash(_settings),const DeepCollectionEquality().hash(_featureFlags),maintenanceMode,lastUpdated,environment);

@override
String toString() {
  return 'SystemConfiguration(version: $version, settings: $settings, featureFlags: $featureFlags, maintenanceMode: $maintenanceMode, lastUpdated: $lastUpdated, environment: $environment)';
}


}

/// @nodoc
abstract mixin class _$SystemConfigurationCopyWith<$Res> implements $SystemConfigurationCopyWith<$Res> {
  factory _$SystemConfigurationCopyWith(_SystemConfiguration value, $Res Function(_SystemConfiguration) _then) = __$SystemConfigurationCopyWithImpl;
@override @useResult
$Res call({
 String version, Map<String, String> settings, Map<String, bool> featureFlags, bool maintenanceMode, DateTime lastUpdated, String environment
});




}
/// @nodoc
class __$SystemConfigurationCopyWithImpl<$Res>
    implements _$SystemConfigurationCopyWith<$Res> {
  __$SystemConfigurationCopyWithImpl(this._self, this._then);

  final _SystemConfiguration _self;
  final $Res Function(_SystemConfiguration) _then;

/// Create a copy of SystemConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? settings = null,Object? featureFlags = null,Object? maintenanceMode = null,Object? lastUpdated = null,Object? environment = null,}) {
  return _then(_SystemConfiguration(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, String>,featureFlags: null == featureFlags ? _self._featureFlags : featureFlags // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$University {

 String get id; String get name; String get country; String get city; String? get website; String? get logoUrl; String? get description; bool get isActive; int? get rankingNational; int? get rankingInternational; int? get establishedYear; int? get studentCount; String? get contactEmail; String? get contactPhone; List<String> get programs; List<String> get faculties; DateTime get createdAt; DateTime get updatedAt; String? get createdBy;
/// Create a copy of University
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversityCopyWith<University> get copyWith => _$UniversityCopyWithImpl<University>(this as University, _$identity);

  /// Serializes this University to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is University&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.website, website) || other.website == website)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rankingNational, rankingNational) || other.rankingNational == rankingNational)&&(identical(other.rankingInternational, rankingInternational) || other.rankingInternational == rankingInternational)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&(identical(other.studentCount, studentCount) || other.studentCount == studentCount)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&const DeepCollectionEquality().equals(other.programs, programs)&&const DeepCollectionEquality().equals(other.faculties, faculties)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,country,city,website,logoUrl,description,isActive,rankingNational,rankingInternational,establishedYear,studentCount,contactEmail,contactPhone,const DeepCollectionEquality().hash(programs),const DeepCollectionEquality().hash(faculties),createdAt,updatedAt,createdBy]);

@override
String toString() {
  return 'University(id: $id, name: $name, country: $country, city: $city, website: $website, logoUrl: $logoUrl, description: $description, isActive: $isActive, rankingNational: $rankingNational, rankingInternational: $rankingInternational, establishedYear: $establishedYear, studentCount: $studentCount, contactEmail: $contactEmail, contactPhone: $contactPhone, programs: $programs, faculties: $faculties, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $UniversityCopyWith<$Res>  {
  factory $UniversityCopyWith(University value, $Res Function(University) _then) = _$UniversityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String country, String city, String? website, String? logoUrl, String? description, bool isActive, int? rankingNational, int? rankingInternational, int? establishedYear, int? studentCount, String? contactEmail, String? contactPhone, List<String> programs, List<String> faculties, DateTime createdAt, DateTime updatedAt, String? createdBy
});




}
/// @nodoc
class _$UniversityCopyWithImpl<$Res>
    implements $UniversityCopyWith<$Res> {
  _$UniversityCopyWithImpl(this._self, this._then);

  final University _self;
  final $Res Function(University) _then;

/// Create a copy of University
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? country = null,Object? city = null,Object? website = freezed,Object? logoUrl = freezed,Object? description = freezed,Object? isActive = null,Object? rankingNational = freezed,Object? rankingInternational = freezed,Object? establishedYear = freezed,Object? studentCount = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? programs = null,Object? faculties = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rankingNational: freezed == rankingNational ? _self.rankingNational : rankingNational // ignore: cast_nullable_to_non_nullable
as int?,rankingInternational: freezed == rankingInternational ? _self.rankingInternational : rankingInternational // ignore: cast_nullable_to_non_nullable
as int?,establishedYear: freezed == establishedYear ? _self.establishedYear : establishedYear // ignore: cast_nullable_to_non_nullable
as int?,studentCount: freezed == studentCount ? _self.studentCount : studentCount // ignore: cast_nullable_to_non_nullable
as int?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,programs: null == programs ? _self.programs : programs // ignore: cast_nullable_to_non_nullable
as List<String>,faculties: null == faculties ? _self.faculties : faculties // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _University implements University {
  const _University({required this.id, required this.name, required this.country, required this.city, this.website, this.logoUrl, this.description, required this.isActive, this.rankingNational, this.rankingInternational, this.establishedYear, this.studentCount, this.contactEmail, this.contactPhone, required final  List<String> programs, required final  List<String> faculties, required this.createdAt, required this.updatedAt, this.createdBy}): _programs = programs,_faculties = faculties;
  factory _University.fromJson(Map<String, dynamic> json) => _$UniversityFromJson(json);

@override final  String id;
@override final  String name;
@override final  String country;
@override final  String city;
@override final  String? website;
@override final  String? logoUrl;
@override final  String? description;
@override final  bool isActive;
@override final  int? rankingNational;
@override final  int? rankingInternational;
@override final  int? establishedYear;
@override final  int? studentCount;
@override final  String? contactEmail;
@override final  String? contactPhone;
 final  List<String> _programs;
@override List<String> get programs {
  if (_programs is EqualUnmodifiableListView) return _programs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_programs);
}

 final  List<String> _faculties;
@override List<String> get faculties {
  if (_faculties is EqualUnmodifiableListView) return _faculties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faculties);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? createdBy;

/// Create a copy of University
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversityCopyWith<_University> get copyWith => __$UniversityCopyWithImpl<_University>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UniversityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _University&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.website, website) || other.website == website)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rankingNational, rankingNational) || other.rankingNational == rankingNational)&&(identical(other.rankingInternational, rankingInternational) || other.rankingInternational == rankingInternational)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&(identical(other.studentCount, studentCount) || other.studentCount == studentCount)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&const DeepCollectionEquality().equals(other._programs, _programs)&&const DeepCollectionEquality().equals(other._faculties, _faculties)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,country,city,website,logoUrl,description,isActive,rankingNational,rankingInternational,establishedYear,studentCount,contactEmail,contactPhone,const DeepCollectionEquality().hash(_programs),const DeepCollectionEquality().hash(_faculties),createdAt,updatedAt,createdBy]);

@override
String toString() {
  return 'University(id: $id, name: $name, country: $country, city: $city, website: $website, logoUrl: $logoUrl, description: $description, isActive: $isActive, rankingNational: $rankingNational, rankingInternational: $rankingInternational, establishedYear: $establishedYear, studentCount: $studentCount, contactEmail: $contactEmail, contactPhone: $contactPhone, programs: $programs, faculties: $faculties, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$UniversityCopyWith<$Res> implements $UniversityCopyWith<$Res> {
  factory _$UniversityCopyWith(_University value, $Res Function(_University) _then) = __$UniversityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String country, String city, String? website, String? logoUrl, String? description, bool isActive, int? rankingNational, int? rankingInternational, int? establishedYear, int? studentCount, String? contactEmail, String? contactPhone, List<String> programs, List<String> faculties, DateTime createdAt, DateTime updatedAt, String? createdBy
});




}
/// @nodoc
class __$UniversityCopyWithImpl<$Res>
    implements _$UniversityCopyWith<$Res> {
  __$UniversityCopyWithImpl(this._self, this._then);

  final _University _self;
  final $Res Function(_University) _then;

/// Create a copy of University
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? country = null,Object? city = null,Object? website = freezed,Object? logoUrl = freezed,Object? description = freezed,Object? isActive = null,Object? rankingNational = freezed,Object? rankingInternational = freezed,Object? establishedYear = freezed,Object? studentCount = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? programs = null,Object? faculties = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = freezed,}) {
  return _then(_University(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rankingNational: freezed == rankingNational ? _self.rankingNational : rankingNational // ignore: cast_nullable_to_non_nullable
as int?,rankingInternational: freezed == rankingInternational ? _self.rankingInternational : rankingInternational // ignore: cast_nullable_to_non_nullable
as int?,establishedYear: freezed == establishedYear ? _self.establishedYear : establishedYear // ignore: cast_nullable_to_non_nullable
as int?,studentCount: freezed == studentCount ? _self.studentCount : studentCount // ignore: cast_nullable_to_non_nullable
as int?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,programs: null == programs ? _self._programs : programs // ignore: cast_nullable_to_non_nullable
as List<String>,faculties: null == faculties ? _self._faculties : faculties // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UniversityListItem {

 String get id; String get name; String get country; String get city; bool get isActive; int? get rankingNational; int? get studentCount; int get programsCount; DateTime get updatedAt; String get type; String get description;
/// Create a copy of UniversityListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversityListItemCopyWith<UniversityListItem> get copyWith => _$UniversityListItemCopyWithImpl<UniversityListItem>(this as UniversityListItem, _$identity);

  /// Serializes this UniversityListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UniversityListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rankingNational, rankingNational) || other.rankingNational == rankingNational)&&(identical(other.studentCount, studentCount) || other.studentCount == studentCount)&&(identical(other.programsCount, programsCount) || other.programsCount == programsCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,country,city,isActive,rankingNational,studentCount,programsCount,updatedAt,type,description);

@override
String toString() {
  return 'UniversityListItem(id: $id, name: $name, country: $country, city: $city, isActive: $isActive, rankingNational: $rankingNational, studentCount: $studentCount, programsCount: $programsCount, updatedAt: $updatedAt, type: $type, description: $description)';
}


}

/// @nodoc
abstract mixin class $UniversityListItemCopyWith<$Res>  {
  factory $UniversityListItemCopyWith(UniversityListItem value, $Res Function(UniversityListItem) _then) = _$UniversityListItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String country, String city, bool isActive, int? rankingNational, int? studentCount, int programsCount, DateTime updatedAt, String type, String description
});




}
/// @nodoc
class _$UniversityListItemCopyWithImpl<$Res>
    implements $UniversityListItemCopyWith<$Res> {
  _$UniversityListItemCopyWithImpl(this._self, this._then);

  final UniversityListItem _self;
  final $Res Function(UniversityListItem) _then;

/// Create a copy of UniversityListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? country = null,Object? city = null,Object? isActive = null,Object? rankingNational = freezed,Object? studentCount = freezed,Object? programsCount = null,Object? updatedAt = null,Object? type = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rankingNational: freezed == rankingNational ? _self.rankingNational : rankingNational // ignore: cast_nullable_to_non_nullable
as int?,studentCount: freezed == studentCount ? _self.studentCount : studentCount // ignore: cast_nullable_to_non_nullable
as int?,programsCount: null == programsCount ? _self.programsCount : programsCount // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UniversityListItem implements UniversityListItem {
  const _UniversityListItem({required this.id, required this.name, required this.country, required this.city, required this.isActive, this.rankingNational, this.studentCount, required this.programsCount, required this.updatedAt, required this.type, required this.description});
  factory _UniversityListItem.fromJson(Map<String, dynamic> json) => _$UniversityListItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  String country;
@override final  String city;
@override final  bool isActive;
@override final  int? rankingNational;
@override final  int? studentCount;
@override final  int programsCount;
@override final  DateTime updatedAt;
@override final  String type;
@override final  String description;

/// Create a copy of UniversityListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversityListItemCopyWith<_UniversityListItem> get copyWith => __$UniversityListItemCopyWithImpl<_UniversityListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UniversityListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UniversityListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rankingNational, rankingNational) || other.rankingNational == rankingNational)&&(identical(other.studentCount, studentCount) || other.studentCount == studentCount)&&(identical(other.programsCount, programsCount) || other.programsCount == programsCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,country,city,isActive,rankingNational,studentCount,programsCount,updatedAt,type,description);

@override
String toString() {
  return 'UniversityListItem(id: $id, name: $name, country: $country, city: $city, isActive: $isActive, rankingNational: $rankingNational, studentCount: $studentCount, programsCount: $programsCount, updatedAt: $updatedAt, type: $type, description: $description)';
}


}

/// @nodoc
abstract mixin class _$UniversityListItemCopyWith<$Res> implements $UniversityListItemCopyWith<$Res> {
  factory _$UniversityListItemCopyWith(_UniversityListItem value, $Res Function(_UniversityListItem) _then) = __$UniversityListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String country, String city, bool isActive, int? rankingNational, int? studentCount, int programsCount, DateTime updatedAt, String type, String description
});




}
/// @nodoc
class __$UniversityListItemCopyWithImpl<$Res>
    implements _$UniversityListItemCopyWith<$Res> {
  __$UniversityListItemCopyWithImpl(this._self, this._then);

  final _UniversityListItem _self;
  final $Res Function(_UniversityListItem) _then;

/// Create a copy of UniversityListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? country = null,Object? city = null,Object? isActive = null,Object? rankingNational = freezed,Object? studentCount = freezed,Object? programsCount = null,Object? updatedAt = null,Object? type = null,Object? description = null,}) {
  return _then(_UniversityListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rankingNational: freezed == rankingNational ? _self.rankingNational : rankingNational // ignore: cast_nullable_to_non_nullable
as int?,studentCount: freezed == studentCount ? _self.studentCount : studentCount // ignore: cast_nullable_to_non_nullable
as int?,programsCount: null == programsCount ? _self.programsCount : programsCount // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UniversityRequest {

 String get name; String get country; String get city; String? get website; String? get logoUrl; String? get description; bool? get isActive; int? get rankingNational; int? get rankingInternational; int? get establishedYear; int? get studentCount; String? get contactEmail; String? get contactPhone; List<String>? get programs; List<String>? get faculties;
/// Create a copy of UniversityRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversityRequestCopyWith<UniversityRequest> get copyWith => _$UniversityRequestCopyWithImpl<UniversityRequest>(this as UniversityRequest, _$identity);

  /// Serializes this UniversityRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UniversityRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.website, website) || other.website == website)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rankingNational, rankingNational) || other.rankingNational == rankingNational)&&(identical(other.rankingInternational, rankingInternational) || other.rankingInternational == rankingInternational)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&(identical(other.studentCount, studentCount) || other.studentCount == studentCount)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&const DeepCollectionEquality().equals(other.programs, programs)&&const DeepCollectionEquality().equals(other.faculties, faculties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,country,city,website,logoUrl,description,isActive,rankingNational,rankingInternational,establishedYear,studentCount,contactEmail,contactPhone,const DeepCollectionEquality().hash(programs),const DeepCollectionEquality().hash(faculties));

@override
String toString() {
  return 'UniversityRequest(name: $name, country: $country, city: $city, website: $website, logoUrl: $logoUrl, description: $description, isActive: $isActive, rankingNational: $rankingNational, rankingInternational: $rankingInternational, establishedYear: $establishedYear, studentCount: $studentCount, contactEmail: $contactEmail, contactPhone: $contactPhone, programs: $programs, faculties: $faculties)';
}


}

/// @nodoc
abstract mixin class $UniversityRequestCopyWith<$Res>  {
  factory $UniversityRequestCopyWith(UniversityRequest value, $Res Function(UniversityRequest) _then) = _$UniversityRequestCopyWithImpl;
@useResult
$Res call({
 String name, String country, String city, String? website, String? logoUrl, String? description, bool? isActive, int? rankingNational, int? rankingInternational, int? establishedYear, int? studentCount, String? contactEmail, String? contactPhone, List<String>? programs, List<String>? faculties
});




}
/// @nodoc
class _$UniversityRequestCopyWithImpl<$Res>
    implements $UniversityRequestCopyWith<$Res> {
  _$UniversityRequestCopyWithImpl(this._self, this._then);

  final UniversityRequest _self;
  final $Res Function(UniversityRequest) _then;

/// Create a copy of UniversityRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? country = null,Object? city = null,Object? website = freezed,Object? logoUrl = freezed,Object? description = freezed,Object? isActive = freezed,Object? rankingNational = freezed,Object? rankingInternational = freezed,Object? establishedYear = freezed,Object? studentCount = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? programs = freezed,Object? faculties = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,rankingNational: freezed == rankingNational ? _self.rankingNational : rankingNational // ignore: cast_nullable_to_non_nullable
as int?,rankingInternational: freezed == rankingInternational ? _self.rankingInternational : rankingInternational // ignore: cast_nullable_to_non_nullable
as int?,establishedYear: freezed == establishedYear ? _self.establishedYear : establishedYear // ignore: cast_nullable_to_non_nullable
as int?,studentCount: freezed == studentCount ? _self.studentCount : studentCount // ignore: cast_nullable_to_non_nullable
as int?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,programs: freezed == programs ? _self.programs : programs // ignore: cast_nullable_to_non_nullable
as List<String>?,faculties: freezed == faculties ? _self.faculties : faculties // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UniversityRequest implements UniversityRequest {
  const _UniversityRequest({required this.name, required this.country, required this.city, this.website, this.logoUrl, this.description, this.isActive, this.rankingNational, this.rankingInternational, this.establishedYear, this.studentCount, this.contactEmail, this.contactPhone, final  List<String>? programs, final  List<String>? faculties}): _programs = programs,_faculties = faculties;
  factory _UniversityRequest.fromJson(Map<String, dynamic> json) => _$UniversityRequestFromJson(json);

@override final  String name;
@override final  String country;
@override final  String city;
@override final  String? website;
@override final  String? logoUrl;
@override final  String? description;
@override final  bool? isActive;
@override final  int? rankingNational;
@override final  int? rankingInternational;
@override final  int? establishedYear;
@override final  int? studentCount;
@override final  String? contactEmail;
@override final  String? contactPhone;
 final  List<String>? _programs;
@override List<String>? get programs {
  final value = _programs;
  if (value == null) return null;
  if (_programs is EqualUnmodifiableListView) return _programs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _faculties;
@override List<String>? get faculties {
  final value = _faculties;
  if (value == null) return null;
  if (_faculties is EqualUnmodifiableListView) return _faculties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UniversityRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversityRequestCopyWith<_UniversityRequest> get copyWith => __$UniversityRequestCopyWithImpl<_UniversityRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UniversityRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UniversityRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.website, website) || other.website == website)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rankingNational, rankingNational) || other.rankingNational == rankingNational)&&(identical(other.rankingInternational, rankingInternational) || other.rankingInternational == rankingInternational)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&(identical(other.studentCount, studentCount) || other.studentCount == studentCount)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&const DeepCollectionEquality().equals(other._programs, _programs)&&const DeepCollectionEquality().equals(other._faculties, _faculties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,country,city,website,logoUrl,description,isActive,rankingNational,rankingInternational,establishedYear,studentCount,contactEmail,contactPhone,const DeepCollectionEquality().hash(_programs),const DeepCollectionEquality().hash(_faculties));

@override
String toString() {
  return 'UniversityRequest(name: $name, country: $country, city: $city, website: $website, logoUrl: $logoUrl, description: $description, isActive: $isActive, rankingNational: $rankingNational, rankingInternational: $rankingInternational, establishedYear: $establishedYear, studentCount: $studentCount, contactEmail: $contactEmail, contactPhone: $contactPhone, programs: $programs, faculties: $faculties)';
}


}

/// @nodoc
abstract mixin class _$UniversityRequestCopyWith<$Res> implements $UniversityRequestCopyWith<$Res> {
  factory _$UniversityRequestCopyWith(_UniversityRequest value, $Res Function(_UniversityRequest) _then) = __$UniversityRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String country, String city, String? website, String? logoUrl, String? description, bool? isActive, int? rankingNational, int? rankingInternational, int? establishedYear, int? studentCount, String? contactEmail, String? contactPhone, List<String>? programs, List<String>? faculties
});




}
/// @nodoc
class __$UniversityRequestCopyWithImpl<$Res>
    implements _$UniversityRequestCopyWith<$Res> {
  __$UniversityRequestCopyWithImpl(this._self, this._then);

  final _UniversityRequest _self;
  final $Res Function(_UniversityRequest) _then;

/// Create a copy of UniversityRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? country = null,Object? city = null,Object? website = freezed,Object? logoUrl = freezed,Object? description = freezed,Object? isActive = freezed,Object? rankingNational = freezed,Object? rankingInternational = freezed,Object? establishedYear = freezed,Object? studentCount = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? programs = freezed,Object? faculties = freezed,}) {
  return _then(_UniversityRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,rankingNational: freezed == rankingNational ? _self.rankingNational : rankingNational // ignore: cast_nullable_to_non_nullable
as int?,rankingInternational: freezed == rankingInternational ? _self.rankingInternational : rankingInternational // ignore: cast_nullable_to_non_nullable
as int?,establishedYear: freezed == establishedYear ? _self.establishedYear : establishedYear // ignore: cast_nullable_to_non_nullable
as int?,studentCount: freezed == studentCount ? _self.studentCount : studentCount // ignore: cast_nullable_to_non_nullable
as int?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,programs: freezed == programs ? _self._programs : programs // ignore: cast_nullable_to_non_nullable
as List<String>?,faculties: freezed == faculties ? _self._faculties : faculties // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$UniversityImportRequest {

 String get source; Map<String, dynamic> get mappings; bool? get validateOnly; bool? get updateExisting;
/// Create a copy of UniversityImportRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversityImportRequestCopyWith<UniversityImportRequest> get copyWith => _$UniversityImportRequestCopyWithImpl<UniversityImportRequest>(this as UniversityImportRequest, _$identity);

  /// Serializes this UniversityImportRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UniversityImportRequest&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.mappings, mappings)&&(identical(other.validateOnly, validateOnly) || other.validateOnly == validateOnly)&&(identical(other.updateExisting, updateExisting) || other.updateExisting == updateExisting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,const DeepCollectionEquality().hash(mappings),validateOnly,updateExisting);

@override
String toString() {
  return 'UniversityImportRequest(source: $source, mappings: $mappings, validateOnly: $validateOnly, updateExisting: $updateExisting)';
}


}

/// @nodoc
abstract mixin class $UniversityImportRequestCopyWith<$Res>  {
  factory $UniversityImportRequestCopyWith(UniversityImportRequest value, $Res Function(UniversityImportRequest) _then) = _$UniversityImportRequestCopyWithImpl;
@useResult
$Res call({
 String source, Map<String, dynamic> mappings, bool? validateOnly, bool? updateExisting
});




}
/// @nodoc
class _$UniversityImportRequestCopyWithImpl<$Res>
    implements $UniversityImportRequestCopyWith<$Res> {
  _$UniversityImportRequestCopyWithImpl(this._self, this._then);

  final UniversityImportRequest _self;
  final $Res Function(UniversityImportRequest) _then;

/// Create a copy of UniversityImportRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? mappings = null,Object? validateOnly = freezed,Object? updateExisting = freezed,}) {
  return _then(_self.copyWith(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,mappings: null == mappings ? _self.mappings : mappings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,validateOnly: freezed == validateOnly ? _self.validateOnly : validateOnly // ignore: cast_nullable_to_non_nullable
as bool?,updateExisting: freezed == updateExisting ? _self.updateExisting : updateExisting // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UniversityImportRequest implements UniversityImportRequest {
  const _UniversityImportRequest({required this.source, required final  Map<String, dynamic> mappings, this.validateOnly, this.updateExisting}): _mappings = mappings;
  factory _UniversityImportRequest.fromJson(Map<String, dynamic> json) => _$UniversityImportRequestFromJson(json);

@override final  String source;
 final  Map<String, dynamic> _mappings;
@override Map<String, dynamic> get mappings {
  if (_mappings is EqualUnmodifiableMapView) return _mappings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_mappings);
}

@override final  bool? validateOnly;
@override final  bool? updateExisting;

/// Create a copy of UniversityImportRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversityImportRequestCopyWith<_UniversityImportRequest> get copyWith => __$UniversityImportRequestCopyWithImpl<_UniversityImportRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UniversityImportRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UniversityImportRequest&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._mappings, _mappings)&&(identical(other.validateOnly, validateOnly) || other.validateOnly == validateOnly)&&(identical(other.updateExisting, updateExisting) || other.updateExisting == updateExisting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,const DeepCollectionEquality().hash(_mappings),validateOnly,updateExisting);

@override
String toString() {
  return 'UniversityImportRequest(source: $source, mappings: $mappings, validateOnly: $validateOnly, updateExisting: $updateExisting)';
}


}

/// @nodoc
abstract mixin class _$UniversityImportRequestCopyWith<$Res> implements $UniversityImportRequestCopyWith<$Res> {
  factory _$UniversityImportRequestCopyWith(_UniversityImportRequest value, $Res Function(_UniversityImportRequest) _then) = __$UniversityImportRequestCopyWithImpl;
@override @useResult
$Res call({
 String source, Map<String, dynamic> mappings, bool? validateOnly, bool? updateExisting
});




}
/// @nodoc
class __$UniversityImportRequestCopyWithImpl<$Res>
    implements _$UniversityImportRequestCopyWith<$Res> {
  __$UniversityImportRequestCopyWithImpl(this._self, this._then);

  final _UniversityImportRequest _self;
  final $Res Function(_UniversityImportRequest) _then;

/// Create a copy of UniversityImportRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? mappings = null,Object? validateOnly = freezed,Object? updateExisting = freezed,}) {
  return _then(_UniversityImportRequest(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,mappings: null == mappings ? _self._mappings : mappings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,validateOnly: freezed == validateOnly ? _self.validateOnly : validateOnly // ignore: cast_nullable_to_non_nullable
as bool?,updateExisting: freezed == updateExisting ? _self.updateExisting : updateExisting // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$UniversityImportResult {

 int get totalProcessed; int get successfulImports; int get failedImports; int get updatedRecords; List<String> get errors; List<String> get warnings;
/// Create a copy of UniversityImportResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversityImportResultCopyWith<UniversityImportResult> get copyWith => _$UniversityImportResultCopyWithImpl<UniversityImportResult>(this as UniversityImportResult, _$identity);

  /// Serializes this UniversityImportResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UniversityImportResult&&(identical(other.totalProcessed, totalProcessed) || other.totalProcessed == totalProcessed)&&(identical(other.successfulImports, successfulImports) || other.successfulImports == successfulImports)&&(identical(other.failedImports, failedImports) || other.failedImports == failedImports)&&(identical(other.updatedRecords, updatedRecords) || other.updatedRecords == updatedRecords)&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.warnings, warnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalProcessed,successfulImports,failedImports,updatedRecords,const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(warnings));

@override
String toString() {
  return 'UniversityImportResult(totalProcessed: $totalProcessed, successfulImports: $successfulImports, failedImports: $failedImports, updatedRecords: $updatedRecords, errors: $errors, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class $UniversityImportResultCopyWith<$Res>  {
  factory $UniversityImportResultCopyWith(UniversityImportResult value, $Res Function(UniversityImportResult) _then) = _$UniversityImportResultCopyWithImpl;
@useResult
$Res call({
 int totalProcessed, int successfulImports, int failedImports, int updatedRecords, List<String> errors, List<String> warnings
});




}
/// @nodoc
class _$UniversityImportResultCopyWithImpl<$Res>
    implements $UniversityImportResultCopyWith<$Res> {
  _$UniversityImportResultCopyWithImpl(this._self, this._then);

  final UniversityImportResult _self;
  final $Res Function(UniversityImportResult) _then;

/// Create a copy of UniversityImportResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalProcessed = null,Object? successfulImports = null,Object? failedImports = null,Object? updatedRecords = null,Object? errors = null,Object? warnings = null,}) {
  return _then(_self.copyWith(
totalProcessed: null == totalProcessed ? _self.totalProcessed : totalProcessed // ignore: cast_nullable_to_non_nullable
as int,successfulImports: null == successfulImports ? _self.successfulImports : successfulImports // ignore: cast_nullable_to_non_nullable
as int,failedImports: null == failedImports ? _self.failedImports : failedImports // ignore: cast_nullable_to_non_nullable
as int,updatedRecords: null == updatedRecords ? _self.updatedRecords : updatedRecords // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UniversityImportResult implements UniversityImportResult {
  const _UniversityImportResult({required this.totalProcessed, required this.successfulImports, required this.failedImports, required this.updatedRecords, required final  List<String> errors, required final  List<String> warnings}): _errors = errors,_warnings = warnings;
  factory _UniversityImportResult.fromJson(Map<String, dynamic> json) => _$UniversityImportResultFromJson(json);

@override final  int totalProcessed;
@override final  int successfulImports;
@override final  int failedImports;
@override final  int updatedRecords;
 final  List<String> _errors;
@override List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}

 final  List<String> _warnings;
@override List<String> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}


/// Create a copy of UniversityImportResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversityImportResultCopyWith<_UniversityImportResult> get copyWith => __$UniversityImportResultCopyWithImpl<_UniversityImportResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UniversityImportResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UniversityImportResult&&(identical(other.totalProcessed, totalProcessed) || other.totalProcessed == totalProcessed)&&(identical(other.successfulImports, successfulImports) || other.successfulImports == successfulImports)&&(identical(other.failedImports, failedImports) || other.failedImports == failedImports)&&(identical(other.updatedRecords, updatedRecords) || other.updatedRecords == updatedRecords)&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other._warnings, _warnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalProcessed,successfulImports,failedImports,updatedRecords,const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(_warnings));

@override
String toString() {
  return 'UniversityImportResult(totalProcessed: $totalProcessed, successfulImports: $successfulImports, failedImports: $failedImports, updatedRecords: $updatedRecords, errors: $errors, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class _$UniversityImportResultCopyWith<$Res> implements $UniversityImportResultCopyWith<$Res> {
  factory _$UniversityImportResultCopyWith(_UniversityImportResult value, $Res Function(_UniversityImportResult) _then) = __$UniversityImportResultCopyWithImpl;
@override @useResult
$Res call({
 int totalProcessed, int successfulImports, int failedImports, int updatedRecords, List<String> errors, List<String> warnings
});




}
/// @nodoc
class __$UniversityImportResultCopyWithImpl<$Res>
    implements _$UniversityImportResultCopyWith<$Res> {
  __$UniversityImportResultCopyWithImpl(this._self, this._then);

  final _UniversityImportResult _self;
  final $Res Function(_UniversityImportResult) _then;

/// Create a copy of UniversityImportResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalProcessed = null,Object? successfulImports = null,Object? failedImports = null,Object? updatedRecords = null,Object? errors = null,Object? warnings = null,}) {
  return _then(_UniversityImportResult(
totalProcessed: null == totalProcessed ? _self.totalProcessed : totalProcessed // ignore: cast_nullable_to_non_nullable
as int,successfulImports: null == successfulImports ? _self.successfulImports : successfulImports // ignore: cast_nullable_to_non_nullable
as int,failedImports: null == failedImports ? _self.failedImports : failedImports // ignore: cast_nullable_to_non_nullable
as int,updatedRecords: null == updatedRecords ? _self.updatedRecords : updatedRecords // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$Country {

 String get code; String get name; String get region;
/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryCopyWith<Country> get copyWith => _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Country&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,region);

@override
String toString() {
  return 'Country(code: $code, name: $name, region: $region)';
}


}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res>  {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) = _$CountryCopyWithImpl;
@useResult
$Res call({
 String code, String name, String region
});




}
/// @nodoc
class _$CountryCopyWithImpl<$Res>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? region = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Country implements Country {
  const _Country({required this.code, required this.name, required this.region});
  factory _Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

@override final  String code;
@override final  String name;
@override final  String region;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCopyWith<_Country> get copyWith => __$CountryCopyWithImpl<_Country>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Country&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,region);

@override
String toString() {
  return 'Country(code: $code, name: $name, region: $region)';
}


}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) = __$CountryCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String region
});




}
/// @nodoc
class __$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? region = null,}) {
  return _then(_Country(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$City {

 String get name; String get country; String get region; int? get population;
/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityCopyWith<City> get copyWith => _$CityCopyWithImpl<City>(this as City, _$identity);

  /// Serializes this City to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is City&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.region, region) || other.region == region)&&(identical(other.population, population) || other.population == population));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,country,region,population);

@override
String toString() {
  return 'City(name: $name, country: $country, region: $region, population: $population)';
}


}

/// @nodoc
abstract mixin class $CityCopyWith<$Res>  {
  factory $CityCopyWith(City value, $Res Function(City) _then) = _$CityCopyWithImpl;
@useResult
$Res call({
 String name, String country, String region, int? population
});




}
/// @nodoc
class _$CityCopyWithImpl<$Res>
    implements $CityCopyWith<$Res> {
  _$CityCopyWithImpl(this._self, this._then);

  final City _self;
  final $Res Function(City) _then;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? country = null,Object? region = null,Object? population = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,population: freezed == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _City implements City {
  const _City({required this.name, required this.country, required this.region, this.population});
  factory _City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

@override final  String name;
@override final  String country;
@override final  String region;
@override final  int? population;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityCopyWith<_City> get copyWith => __$CityCopyWithImpl<_City>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _City&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.region, region) || other.region == region)&&(identical(other.population, population) || other.population == population));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,country,region,population);

@override
String toString() {
  return 'City(name: $name, country: $country, region: $region, population: $population)';
}


}

/// @nodoc
abstract mixin class _$CityCopyWith<$Res> implements $CityCopyWith<$Res> {
  factory _$CityCopyWith(_City value, $Res Function(_City) _then) = __$CityCopyWithImpl;
@override @useResult
$Res call({
 String name, String country, String region, int? population
});




}
/// @nodoc
class __$CityCopyWithImpl<$Res>
    implements _$CityCopyWith<$Res> {
  __$CityCopyWithImpl(this._self, this._then);

  final _City _self;
  final $Res Function(_City) _then;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? country = null,Object? region = null,Object? population = freezed,}) {
  return _then(_City(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,population: freezed == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$UniversityStats {

 int get totalUniversities; int get activeUniversities; int get inactiveUniversities; int get pendingUniversities; Map<String, int> get byCountry; Map<String, int> get byRegion;
/// Create a copy of UniversityStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversityStatsCopyWith<UniversityStats> get copyWith => _$UniversityStatsCopyWithImpl<UniversityStats>(this as UniversityStats, _$identity);

  /// Serializes this UniversityStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UniversityStats&&(identical(other.totalUniversities, totalUniversities) || other.totalUniversities == totalUniversities)&&(identical(other.activeUniversities, activeUniversities) || other.activeUniversities == activeUniversities)&&(identical(other.inactiveUniversities, inactiveUniversities) || other.inactiveUniversities == inactiveUniversities)&&(identical(other.pendingUniversities, pendingUniversities) || other.pendingUniversities == pendingUniversities)&&const DeepCollectionEquality().equals(other.byCountry, byCountry)&&const DeepCollectionEquality().equals(other.byRegion, byRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalUniversities,activeUniversities,inactiveUniversities,pendingUniversities,const DeepCollectionEquality().hash(byCountry),const DeepCollectionEquality().hash(byRegion));

@override
String toString() {
  return 'UniversityStats(totalUniversities: $totalUniversities, activeUniversities: $activeUniversities, inactiveUniversities: $inactiveUniversities, pendingUniversities: $pendingUniversities, byCountry: $byCountry, byRegion: $byRegion)';
}


}

/// @nodoc
abstract mixin class $UniversityStatsCopyWith<$Res>  {
  factory $UniversityStatsCopyWith(UniversityStats value, $Res Function(UniversityStats) _then) = _$UniversityStatsCopyWithImpl;
@useResult
$Res call({
 int totalUniversities, int activeUniversities, int inactiveUniversities, int pendingUniversities, Map<String, int> byCountry, Map<String, int> byRegion
});




}
/// @nodoc
class _$UniversityStatsCopyWithImpl<$Res>
    implements $UniversityStatsCopyWith<$Res> {
  _$UniversityStatsCopyWithImpl(this._self, this._then);

  final UniversityStats _self;
  final $Res Function(UniversityStats) _then;

/// Create a copy of UniversityStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalUniversities = null,Object? activeUniversities = null,Object? inactiveUniversities = null,Object? pendingUniversities = null,Object? byCountry = null,Object? byRegion = null,}) {
  return _then(_self.copyWith(
totalUniversities: null == totalUniversities ? _self.totalUniversities : totalUniversities // ignore: cast_nullable_to_non_nullable
as int,activeUniversities: null == activeUniversities ? _self.activeUniversities : activeUniversities // ignore: cast_nullable_to_non_nullable
as int,inactiveUniversities: null == inactiveUniversities ? _self.inactiveUniversities : inactiveUniversities // ignore: cast_nullable_to_non_nullable
as int,pendingUniversities: null == pendingUniversities ? _self.pendingUniversities : pendingUniversities // ignore: cast_nullable_to_non_nullable
as int,byCountry: null == byCountry ? _self.byCountry : byCountry // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byRegion: null == byRegion ? _self.byRegion : byRegion // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UniversityStats implements UniversityStats {
  const _UniversityStats({required this.totalUniversities, required this.activeUniversities, required this.inactiveUniversities, required this.pendingUniversities, required final  Map<String, int> byCountry, required final  Map<String, int> byRegion}): _byCountry = byCountry,_byRegion = byRegion;
  factory _UniversityStats.fromJson(Map<String, dynamic> json) => _$UniversityStatsFromJson(json);

@override final  int totalUniversities;
@override final  int activeUniversities;
@override final  int inactiveUniversities;
@override final  int pendingUniversities;
 final  Map<String, int> _byCountry;
@override Map<String, int> get byCountry {
  if (_byCountry is EqualUnmodifiableMapView) return _byCountry;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byCountry);
}

 final  Map<String, int> _byRegion;
@override Map<String, int> get byRegion {
  if (_byRegion is EqualUnmodifiableMapView) return _byRegion;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byRegion);
}


/// Create a copy of UniversityStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversityStatsCopyWith<_UniversityStats> get copyWith => __$UniversityStatsCopyWithImpl<_UniversityStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UniversityStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UniversityStats&&(identical(other.totalUniversities, totalUniversities) || other.totalUniversities == totalUniversities)&&(identical(other.activeUniversities, activeUniversities) || other.activeUniversities == activeUniversities)&&(identical(other.inactiveUniversities, inactiveUniversities) || other.inactiveUniversities == inactiveUniversities)&&(identical(other.pendingUniversities, pendingUniversities) || other.pendingUniversities == pendingUniversities)&&const DeepCollectionEquality().equals(other._byCountry, _byCountry)&&const DeepCollectionEquality().equals(other._byRegion, _byRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalUniversities,activeUniversities,inactiveUniversities,pendingUniversities,const DeepCollectionEquality().hash(_byCountry),const DeepCollectionEquality().hash(_byRegion));

@override
String toString() {
  return 'UniversityStats(totalUniversities: $totalUniversities, activeUniversities: $activeUniversities, inactiveUniversities: $inactiveUniversities, pendingUniversities: $pendingUniversities, byCountry: $byCountry, byRegion: $byRegion)';
}


}

/// @nodoc
abstract mixin class _$UniversityStatsCopyWith<$Res> implements $UniversityStatsCopyWith<$Res> {
  factory _$UniversityStatsCopyWith(_UniversityStats value, $Res Function(_UniversityStats) _then) = __$UniversityStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalUniversities, int activeUniversities, int inactiveUniversities, int pendingUniversities, Map<String, int> byCountry, Map<String, int> byRegion
});




}
/// @nodoc
class __$UniversityStatsCopyWithImpl<$Res>
    implements _$UniversityStatsCopyWith<$Res> {
  __$UniversityStatsCopyWithImpl(this._self, this._then);

  final _UniversityStats _self;
  final $Res Function(_UniversityStats) _then;

/// Create a copy of UniversityStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalUniversities = null,Object? activeUniversities = null,Object? inactiveUniversities = null,Object? pendingUniversities = null,Object? byCountry = null,Object? byRegion = null,}) {
  return _then(_UniversityStats(
totalUniversities: null == totalUniversities ? _self.totalUniversities : totalUniversities // ignore: cast_nullable_to_non_nullable
as int,activeUniversities: null == activeUniversities ? _self.activeUniversities : activeUniversities // ignore: cast_nullable_to_non_nullable
as int,inactiveUniversities: null == inactiveUniversities ? _self.inactiveUniversities : inactiveUniversities // ignore: cast_nullable_to_non_nullable
as int,pendingUniversities: null == pendingUniversities ? _self.pendingUniversities : pendingUniversities // ignore: cast_nullable_to_non_nullable
as int,byCountry: null == byCountry ? _self._byCountry : byCountry // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byRegion: null == byRegion ? _self._byRegion : byRegion // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
