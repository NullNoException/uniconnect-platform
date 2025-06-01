// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardFilter {

 DashboardTimeRange get timeRange; DateTime? get startDate; DateTime? get endDate; List<String> get serviceCategories; List<String> get providerIds; String get searchQuery;
/// Create a copy of DashboardFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardFilterCopyWith<DashboardFilter> get copyWith => _$DashboardFilterCopyWithImpl<DashboardFilter>(this as DashboardFilter, _$identity);

  /// Serializes this DashboardFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardFilter&&(identical(other.timeRange, timeRange) || other.timeRange == timeRange)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.serviceCategories, serviceCategories)&&const DeepCollectionEquality().equals(other.providerIds, providerIds)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeRange,startDate,endDate,const DeepCollectionEquality().hash(serviceCategories),const DeepCollectionEquality().hash(providerIds),searchQuery);

@override
String toString() {
  return 'DashboardFilter(timeRange: $timeRange, startDate: $startDate, endDate: $endDate, serviceCategories: $serviceCategories, providerIds: $providerIds, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $DashboardFilterCopyWith<$Res>  {
  factory $DashboardFilterCopyWith(DashboardFilter value, $Res Function(DashboardFilter) _then) = _$DashboardFilterCopyWithImpl;
@useResult
$Res call({
 DashboardTimeRange timeRange, DateTime? startDate, DateTime? endDate, List<String> serviceCategories, List<String> providerIds, String searchQuery
});




}
/// @nodoc
class _$DashboardFilterCopyWithImpl<$Res>
    implements $DashboardFilterCopyWith<$Res> {
  _$DashboardFilterCopyWithImpl(this._self, this._then);

  final DashboardFilter _self;
  final $Res Function(DashboardFilter) _then;

/// Create a copy of DashboardFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timeRange = null,Object? startDate = freezed,Object? endDate = freezed,Object? serviceCategories = null,Object? providerIds = null,Object? searchQuery = null,}) {
  return _then(_self.copyWith(
timeRange: null == timeRange ? _self.timeRange : timeRange // ignore: cast_nullable_to_non_nullable
as DashboardTimeRange,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,serviceCategories: null == serviceCategories ? _self.serviceCategories : serviceCategories // ignore: cast_nullable_to_non_nullable
as List<String>,providerIds: null == providerIds ? _self.providerIds : providerIds // ignore: cast_nullable_to_non_nullable
as List<String>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DashboardFilter implements DashboardFilter {
  const _DashboardFilter({this.timeRange = DashboardTimeRange.thisMonth, this.startDate, this.endDate, final  List<String> serviceCategories = const [], final  List<String> providerIds = const [], this.searchQuery = ''}): _serviceCategories = serviceCategories,_providerIds = providerIds;
  factory _DashboardFilter.fromJson(Map<String, dynamic> json) => _$DashboardFilterFromJson(json);

@override@JsonKey() final  DashboardTimeRange timeRange;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
 final  List<String> _serviceCategories;
@override@JsonKey() List<String> get serviceCategories {
  if (_serviceCategories is EqualUnmodifiableListView) return _serviceCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceCategories);
}

 final  List<String> _providerIds;
@override@JsonKey() List<String> get providerIds {
  if (_providerIds is EqualUnmodifiableListView) return _providerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providerIds);
}

@override@JsonKey() final  String searchQuery;

/// Create a copy of DashboardFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardFilterCopyWith<_DashboardFilter> get copyWith => __$DashboardFilterCopyWithImpl<_DashboardFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardFilter&&(identical(other.timeRange, timeRange) || other.timeRange == timeRange)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other._serviceCategories, _serviceCategories)&&const DeepCollectionEquality().equals(other._providerIds, _providerIds)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeRange,startDate,endDate,const DeepCollectionEquality().hash(_serviceCategories),const DeepCollectionEquality().hash(_providerIds),searchQuery);

@override
String toString() {
  return 'DashboardFilter(timeRange: $timeRange, startDate: $startDate, endDate: $endDate, serviceCategories: $serviceCategories, providerIds: $providerIds, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$DashboardFilterCopyWith<$Res> implements $DashboardFilterCopyWith<$Res> {
  factory _$DashboardFilterCopyWith(_DashboardFilter value, $Res Function(_DashboardFilter) _then) = __$DashboardFilterCopyWithImpl;
@override @useResult
$Res call({
 DashboardTimeRange timeRange, DateTime? startDate, DateTime? endDate, List<String> serviceCategories, List<String> providerIds, String searchQuery
});




}
/// @nodoc
class __$DashboardFilterCopyWithImpl<$Res>
    implements _$DashboardFilterCopyWith<$Res> {
  __$DashboardFilterCopyWithImpl(this._self, this._then);

  final _DashboardFilter _self;
  final $Res Function(_DashboardFilter) _then;

/// Create a copy of DashboardFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timeRange = null,Object? startDate = freezed,Object? endDate = freezed,Object? serviceCategories = null,Object? providerIds = null,Object? searchQuery = null,}) {
  return _then(_DashboardFilter(
timeRange: null == timeRange ? _self.timeRange : timeRange // ignore: cast_nullable_to_non_nullable
as DashboardTimeRange,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,serviceCategories: null == serviceCategories ? _self._serviceCategories : serviceCategories // ignore: cast_nullable_to_non_nullable
as List<String>,providerIds: null == providerIds ? _self._providerIds : providerIds // ignore: cast_nullable_to_non_nullable
as List<String>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
