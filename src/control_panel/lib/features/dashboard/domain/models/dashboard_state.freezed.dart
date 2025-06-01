// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {

 bool get isLoading; bool get isRefreshing; bool get isExporting; DashboardData? get data; DashboardStats? get stats; ServiceRequestChart? get chartData; List<ServiceCategoryData>? get categoryData; List<RecentServiceRequest>? get recentRequests; DashboardFilter get filter; String? get error; String? get exportUrl;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isExporting, isExporting) || other.isExporting == isExporting)&&(identical(other.data, data) || other.data == data)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.chartData, chartData) || other.chartData == chartData)&&const DeepCollectionEquality().equals(other.categoryData, categoryData)&&const DeepCollectionEquality().equals(other.recentRequests, recentRequests)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.error, error) || other.error == error)&&(identical(other.exportUrl, exportUrl) || other.exportUrl == exportUrl));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,isExporting,data,stats,chartData,const DeepCollectionEquality().hash(categoryData),const DeepCollectionEquality().hash(recentRequests),filter,error,exportUrl);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, isRefreshing: $isRefreshing, isExporting: $isExporting, data: $data, stats: $stats, chartData: $chartData, categoryData: $categoryData, recentRequests: $recentRequests, filter: $filter, error: $error, exportUrl: $exportUrl)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isRefreshing, bool isExporting, DashboardData? data, DashboardStats? stats, ServiceRequestChart? chartData, List<ServiceCategoryData>? categoryData, List<RecentServiceRequest>? recentRequests, DashboardFilter filter, String? error, String? exportUrl
});


$DashboardDataCopyWith<$Res>? get data;$DashboardStatsCopyWith<$Res>? get stats;$ServiceRequestChartCopyWith<$Res>? get chartData;$DashboardFilterCopyWith<$Res> get filter;

}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? isExporting = null,Object? data = freezed,Object? stats = freezed,Object? chartData = freezed,Object? categoryData = freezed,Object? recentRequests = freezed,Object? filter = null,Object? error = freezed,Object? exportUrl = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isExporting: null == isExporting ? _self.isExporting : isExporting // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DashboardData?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DashboardStats?,chartData: freezed == chartData ? _self.chartData : chartData // ignore: cast_nullable_to_non_nullable
as ServiceRequestChart?,categoryData: freezed == categoryData ? _self.categoryData : categoryData // ignore: cast_nullable_to_non_nullable
as List<ServiceCategoryData>?,recentRequests: freezed == recentRequests ? _self.recentRequests : recentRequests // ignore: cast_nullable_to_non_nullable
as List<RecentServiceRequest>?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as DashboardFilter,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,exportUrl: freezed == exportUrl ? _self.exportUrl : exportUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DashboardDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $DashboardStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceRequestChartCopyWith<$Res>? get chartData {
    if (_self.chartData == null) {
    return null;
  }

  return $ServiceRequestChartCopyWith<$Res>(_self.chartData!, (value) {
    return _then(_self.copyWith(chartData: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardFilterCopyWith<$Res> get filter {
  
  return $DashboardFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}


/// @nodoc


class _DashboardState extends DashboardState {
  const _DashboardState({this.isLoading = false, this.isRefreshing = false, this.isExporting = false, this.data, this.stats, this.chartData, final  List<ServiceCategoryData>? categoryData, final  List<RecentServiceRequest>? recentRequests, this.filter = const DashboardFilter(), this.error, this.exportUrl}): _categoryData = categoryData,_recentRequests = recentRequests,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isExporting;
@override final  DashboardData? data;
@override final  DashboardStats? stats;
@override final  ServiceRequestChart? chartData;
 final  List<ServiceCategoryData>? _categoryData;
@override List<ServiceCategoryData>? get categoryData {
  final value = _categoryData;
  if (value == null) return null;
  if (_categoryData is EqualUnmodifiableListView) return _categoryData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<RecentServiceRequest>? _recentRequests;
@override List<RecentServiceRequest>? get recentRequests {
  final value = _recentRequests;
  if (value == null) return null;
  if (_recentRequests is EqualUnmodifiableListView) return _recentRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  DashboardFilter filter;
@override final  String? error;
@override final  String? exportUrl;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isExporting, isExporting) || other.isExporting == isExporting)&&(identical(other.data, data) || other.data == data)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.chartData, chartData) || other.chartData == chartData)&&const DeepCollectionEquality().equals(other._categoryData, _categoryData)&&const DeepCollectionEquality().equals(other._recentRequests, _recentRequests)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.error, error) || other.error == error)&&(identical(other.exportUrl, exportUrl) || other.exportUrl == exportUrl));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,isExporting,data,stats,chartData,const DeepCollectionEquality().hash(_categoryData),const DeepCollectionEquality().hash(_recentRequests),filter,error,exportUrl);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, isRefreshing: $isRefreshing, isExporting: $isExporting, data: $data, stats: $stats, chartData: $chartData, categoryData: $categoryData, recentRequests: $recentRequests, filter: $filter, error: $error, exportUrl: $exportUrl)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isRefreshing, bool isExporting, DashboardData? data, DashboardStats? stats, ServiceRequestChart? chartData, List<ServiceCategoryData>? categoryData, List<RecentServiceRequest>? recentRequests, DashboardFilter filter, String? error, String? exportUrl
});


@override $DashboardDataCopyWith<$Res>? get data;@override $DashboardStatsCopyWith<$Res>? get stats;@override $ServiceRequestChartCopyWith<$Res>? get chartData;@override $DashboardFilterCopyWith<$Res> get filter;

}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? isExporting = null,Object? data = freezed,Object? stats = freezed,Object? chartData = freezed,Object? categoryData = freezed,Object? recentRequests = freezed,Object? filter = null,Object? error = freezed,Object? exportUrl = freezed,}) {
  return _then(_DashboardState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isExporting: null == isExporting ? _self.isExporting : isExporting // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DashboardData?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DashboardStats?,chartData: freezed == chartData ? _self.chartData : chartData // ignore: cast_nullable_to_non_nullable
as ServiceRequestChart?,categoryData: freezed == categoryData ? _self._categoryData : categoryData // ignore: cast_nullable_to_non_nullable
as List<ServiceCategoryData>?,recentRequests: freezed == recentRequests ? _self._recentRequests : recentRequests // ignore: cast_nullable_to_non_nullable
as List<RecentServiceRequest>?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as DashboardFilter,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,exportUrl: freezed == exportUrl ? _self.exportUrl : exportUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DashboardDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $DashboardStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceRequestChartCopyWith<$Res>? get chartData {
    if (_self.chartData == null) {
    return null;
  }

  return $ServiceRequestChartCopyWith<$Res>(_self.chartData!, (value) {
    return _then(_self.copyWith(chartData: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardFilterCopyWith<$Res> get filter {
  
  return $DashboardFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

// dart format on
