// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardStats {

 int get totalUsers; int get activeProviders; int get pendingRequests; double get revenue; DashboardTrends get trends; DateTime get lastUpdated;
/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStatsCopyWith<DashboardStats> get copyWith => _$DashboardStatsCopyWithImpl<DashboardStats>(this as DashboardStats, _$identity);

  /// Serializes this DashboardStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardStats&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.activeProviders, activeProviders) || other.activeProviders == activeProviders)&&(identical(other.pendingRequests, pendingRequests) || other.pendingRequests == pendingRequests)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.trends, trends) || other.trends == trends)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalUsers,activeProviders,pendingRequests,revenue,trends,lastUpdated);

@override
String toString() {
  return 'DashboardStats(totalUsers: $totalUsers, activeProviders: $activeProviders, pendingRequests: $pendingRequests, revenue: $revenue, trends: $trends, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $DashboardStatsCopyWith<$Res>  {
  factory $DashboardStatsCopyWith(DashboardStats value, $Res Function(DashboardStats) _then) = _$DashboardStatsCopyWithImpl;
@useResult
$Res call({
 int totalUsers, int activeProviders, int pendingRequests, double revenue, DashboardTrends trends, DateTime lastUpdated
});


$DashboardTrendsCopyWith<$Res> get trends;

}
/// @nodoc
class _$DashboardStatsCopyWithImpl<$Res>
    implements $DashboardStatsCopyWith<$Res> {
  _$DashboardStatsCopyWithImpl(this._self, this._then);

  final DashboardStats _self;
  final $Res Function(DashboardStats) _then;

/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalUsers = null,Object? activeProviders = null,Object? pendingRequests = null,Object? revenue = null,Object? trends = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,activeProviders: null == activeProviders ? _self.activeProviders : activeProviders // ignore: cast_nullable_to_non_nullable
as int,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,trends: null == trends ? _self.trends : trends // ignore: cast_nullable_to_non_nullable
as DashboardTrends,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardTrendsCopyWith<$Res> get trends {
  
  return $DashboardTrendsCopyWith<$Res>(_self.trends, (value) {
    return _then(_self.copyWith(trends: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _DashboardStats implements DashboardStats {
  const _DashboardStats({required this.totalUsers, required this.activeProviders, required this.pendingRequests, required this.revenue, required this.trends, required this.lastUpdated});
  factory _DashboardStats.fromJson(Map<String, dynamic> json) => _$DashboardStatsFromJson(json);

@override final  int totalUsers;
@override final  int activeProviders;
@override final  int pendingRequests;
@override final  double revenue;
@override final  DashboardTrends trends;
@override final  DateTime lastUpdated;

/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStatsCopyWith<_DashboardStats> get copyWith => __$DashboardStatsCopyWithImpl<_DashboardStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardStats&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.activeProviders, activeProviders) || other.activeProviders == activeProviders)&&(identical(other.pendingRequests, pendingRequests) || other.pendingRequests == pendingRequests)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.trends, trends) || other.trends == trends)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalUsers,activeProviders,pendingRequests,revenue,trends,lastUpdated);

@override
String toString() {
  return 'DashboardStats(totalUsers: $totalUsers, activeProviders: $activeProviders, pendingRequests: $pendingRequests, revenue: $revenue, trends: $trends, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$DashboardStatsCopyWith<$Res> implements $DashboardStatsCopyWith<$Res> {
  factory _$DashboardStatsCopyWith(_DashboardStats value, $Res Function(_DashboardStats) _then) = __$DashboardStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalUsers, int activeProviders, int pendingRequests, double revenue, DashboardTrends trends, DateTime lastUpdated
});


@override $DashboardTrendsCopyWith<$Res> get trends;

}
/// @nodoc
class __$DashboardStatsCopyWithImpl<$Res>
    implements _$DashboardStatsCopyWith<$Res> {
  __$DashboardStatsCopyWithImpl(this._self, this._then);

  final _DashboardStats _self;
  final $Res Function(_DashboardStats) _then;

/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalUsers = null,Object? activeProviders = null,Object? pendingRequests = null,Object? revenue = null,Object? trends = null,Object? lastUpdated = null,}) {
  return _then(_DashboardStats(
totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,activeProviders: null == activeProviders ? _self.activeProviders : activeProviders // ignore: cast_nullable_to_non_nullable
as int,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,trends: null == trends ? _self.trends : trends // ignore: cast_nullable_to_non_nullable
as DashboardTrends,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardTrendsCopyWith<$Res> get trends {
  
  return $DashboardTrendsCopyWith<$Res>(_self.trends, (value) {
    return _then(_self.copyWith(trends: value));
  });
}
}


/// @nodoc
mixin _$DashboardTrends {

 double get usersTrend; double get providersTrend; double get requestsTrend; double get revenueTrend;
/// Create a copy of DashboardTrends
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardTrendsCopyWith<DashboardTrends> get copyWith => _$DashboardTrendsCopyWithImpl<DashboardTrends>(this as DashboardTrends, _$identity);

  /// Serializes this DashboardTrends to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardTrends&&(identical(other.usersTrend, usersTrend) || other.usersTrend == usersTrend)&&(identical(other.providersTrend, providersTrend) || other.providersTrend == providersTrend)&&(identical(other.requestsTrend, requestsTrend) || other.requestsTrend == requestsTrend)&&(identical(other.revenueTrend, revenueTrend) || other.revenueTrend == revenueTrend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,usersTrend,providersTrend,requestsTrend,revenueTrend);

@override
String toString() {
  return 'DashboardTrends(usersTrend: $usersTrend, providersTrend: $providersTrend, requestsTrend: $requestsTrend, revenueTrend: $revenueTrend)';
}


}

/// @nodoc
abstract mixin class $DashboardTrendsCopyWith<$Res>  {
  factory $DashboardTrendsCopyWith(DashboardTrends value, $Res Function(DashboardTrends) _then) = _$DashboardTrendsCopyWithImpl;
@useResult
$Res call({
 double usersTrend, double providersTrend, double requestsTrend, double revenueTrend
});




}
/// @nodoc
class _$DashboardTrendsCopyWithImpl<$Res>
    implements $DashboardTrendsCopyWith<$Res> {
  _$DashboardTrendsCopyWithImpl(this._self, this._then);

  final DashboardTrends _self;
  final $Res Function(DashboardTrends) _then;

/// Create a copy of DashboardTrends
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? usersTrend = null,Object? providersTrend = null,Object? requestsTrend = null,Object? revenueTrend = null,}) {
  return _then(_self.copyWith(
usersTrend: null == usersTrend ? _self.usersTrend : usersTrend // ignore: cast_nullable_to_non_nullable
as double,providersTrend: null == providersTrend ? _self.providersTrend : providersTrend // ignore: cast_nullable_to_non_nullable
as double,requestsTrend: null == requestsTrend ? _self.requestsTrend : requestsTrend // ignore: cast_nullable_to_non_nullable
as double,revenueTrend: null == revenueTrend ? _self.revenueTrend : revenueTrend // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DashboardTrends implements DashboardTrends {
  const _DashboardTrends({required this.usersTrend, required this.providersTrend, required this.requestsTrend, required this.revenueTrend});
  factory _DashboardTrends.fromJson(Map<String, dynamic> json) => _$DashboardTrendsFromJson(json);

@override final  double usersTrend;
@override final  double providersTrend;
@override final  double requestsTrend;
@override final  double revenueTrend;

/// Create a copy of DashboardTrends
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardTrendsCopyWith<_DashboardTrends> get copyWith => __$DashboardTrendsCopyWithImpl<_DashboardTrends>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardTrendsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardTrends&&(identical(other.usersTrend, usersTrend) || other.usersTrend == usersTrend)&&(identical(other.providersTrend, providersTrend) || other.providersTrend == providersTrend)&&(identical(other.requestsTrend, requestsTrend) || other.requestsTrend == requestsTrend)&&(identical(other.revenueTrend, revenueTrend) || other.revenueTrend == revenueTrend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,usersTrend,providersTrend,requestsTrend,revenueTrend);

@override
String toString() {
  return 'DashboardTrends(usersTrend: $usersTrend, providersTrend: $providersTrend, requestsTrend: $requestsTrend, revenueTrend: $revenueTrend)';
}


}

/// @nodoc
abstract mixin class _$DashboardTrendsCopyWith<$Res> implements $DashboardTrendsCopyWith<$Res> {
  factory _$DashboardTrendsCopyWith(_DashboardTrends value, $Res Function(_DashboardTrends) _then) = __$DashboardTrendsCopyWithImpl;
@override @useResult
$Res call({
 double usersTrend, double providersTrend, double requestsTrend, double revenueTrend
});




}
/// @nodoc
class __$DashboardTrendsCopyWithImpl<$Res>
    implements _$DashboardTrendsCopyWith<$Res> {
  __$DashboardTrendsCopyWithImpl(this._self, this._then);

  final _DashboardTrends _self;
  final $Res Function(_DashboardTrends) _then;

/// Create a copy of DashboardTrends
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? usersTrend = null,Object? providersTrend = null,Object? requestsTrend = null,Object? revenueTrend = null,}) {
  return _then(_DashboardTrends(
usersTrend: null == usersTrend ? _self.usersTrend : usersTrend // ignore: cast_nullable_to_non_nullable
as double,providersTrend: null == providersTrend ? _self.providersTrend : providersTrend // ignore: cast_nullable_to_non_nullable
as double,requestsTrend: null == requestsTrend ? _self.requestsTrend : requestsTrend // ignore: cast_nullable_to_non_nullable
as double,revenueTrend: null == revenueTrend ? _self.revenueTrend : revenueTrend // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ChartData {

 String get label; double get value; DateTime? get date;
/// Create a copy of ChartData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartDataCopyWith<ChartData> get copyWith => _$ChartDataCopyWithImpl<ChartData>(this as ChartData, _$identity);

  /// Serializes this ChartData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartData&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,value,date);

@override
String toString() {
  return 'ChartData(label: $label, value: $value, date: $date)';
}


}

/// @nodoc
abstract mixin class $ChartDataCopyWith<$Res>  {
  factory $ChartDataCopyWith(ChartData value, $Res Function(ChartData) _then) = _$ChartDataCopyWithImpl;
@useResult
$Res call({
 String label, double value, DateTime? date
});




}
/// @nodoc
class _$ChartDataCopyWithImpl<$Res>
    implements $ChartDataCopyWith<$Res> {
  _$ChartDataCopyWithImpl(this._self, this._then);

  final ChartData _self;
  final $Res Function(ChartData) _then;

/// Create a copy of ChartData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? value = null,Object? date = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChartData implements ChartData {
  const _ChartData({required this.label, required this.value, this.date});
  factory _ChartData.fromJson(Map<String, dynamic> json) => _$ChartDataFromJson(json);

@override final  String label;
@override final  double value;
@override final  DateTime? date;

/// Create a copy of ChartData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartDataCopyWith<_ChartData> get copyWith => __$ChartDataCopyWithImpl<_ChartData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChartDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartData&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,value,date);

@override
String toString() {
  return 'ChartData(label: $label, value: $value, date: $date)';
}


}

/// @nodoc
abstract mixin class _$ChartDataCopyWith<$Res> implements $ChartDataCopyWith<$Res> {
  factory _$ChartDataCopyWith(_ChartData value, $Res Function(_ChartData) _then) = __$ChartDataCopyWithImpl;
@override @useResult
$Res call({
 String label, double value, DateTime? date
});




}
/// @nodoc
class __$ChartDataCopyWithImpl<$Res>
    implements _$ChartDataCopyWith<$Res> {
  __$ChartDataCopyWithImpl(this._self, this._then);

  final _ChartData _self;
  final $Res Function(_ChartData) _then;

/// Create a copy of ChartData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? value = null,Object? date = freezed,}) {
  return _then(_ChartData(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ServiceRequestChart {

 List<ChartData> get completed; List<ChartData> get pending; List<ChartData> get cancelled;
/// Create a copy of ServiceRequestChart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestChartCopyWith<ServiceRequestChart> get copyWith => _$ServiceRequestChartCopyWithImpl<ServiceRequestChart>(this as ServiceRequestChart, _$identity);

  /// Serializes this ServiceRequestChart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestChart&&const DeepCollectionEquality().equals(other.completed, completed)&&const DeepCollectionEquality().equals(other.pending, pending)&&const DeepCollectionEquality().equals(other.cancelled, cancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(completed),const DeepCollectionEquality().hash(pending),const DeepCollectionEquality().hash(cancelled));

@override
String toString() {
  return 'ServiceRequestChart(completed: $completed, pending: $pending, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestChartCopyWith<$Res>  {
  factory $ServiceRequestChartCopyWith(ServiceRequestChart value, $Res Function(ServiceRequestChart) _then) = _$ServiceRequestChartCopyWithImpl;
@useResult
$Res call({
 List<ChartData> completed, List<ChartData> pending, List<ChartData> cancelled
});




}
/// @nodoc
class _$ServiceRequestChartCopyWithImpl<$Res>
    implements $ServiceRequestChartCopyWith<$Res> {
  _$ServiceRequestChartCopyWithImpl(this._self, this._then);

  final ServiceRequestChart _self;
  final $Res Function(ServiceRequestChart) _then;

/// Create a copy of ServiceRequestChart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completed = null,Object? pending = null,Object? cancelled = null,}) {
  return _then(_self.copyWith(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as List<ChartData>,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as List<ChartData>,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as List<ChartData>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceRequestChart implements ServiceRequestChart {
  const _ServiceRequestChart({required final  List<ChartData> completed, required final  List<ChartData> pending, required final  List<ChartData> cancelled}): _completed = completed,_pending = pending,_cancelled = cancelled;
  factory _ServiceRequestChart.fromJson(Map<String, dynamic> json) => _$ServiceRequestChartFromJson(json);

 final  List<ChartData> _completed;
@override List<ChartData> get completed {
  if (_completed is EqualUnmodifiableListView) return _completed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completed);
}

 final  List<ChartData> _pending;
@override List<ChartData> get pending {
  if (_pending is EqualUnmodifiableListView) return _pending;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pending);
}

 final  List<ChartData> _cancelled;
@override List<ChartData> get cancelled {
  if (_cancelled is EqualUnmodifiableListView) return _cancelled;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cancelled);
}


/// Create a copy of ServiceRequestChart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestChartCopyWith<_ServiceRequestChart> get copyWith => __$ServiceRequestChartCopyWithImpl<_ServiceRequestChart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequestChartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestChart&&const DeepCollectionEquality().equals(other._completed, _completed)&&const DeepCollectionEquality().equals(other._pending, _pending)&&const DeepCollectionEquality().equals(other._cancelled, _cancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_completed),const DeepCollectionEquality().hash(_pending),const DeepCollectionEquality().hash(_cancelled));

@override
String toString() {
  return 'ServiceRequestChart(completed: $completed, pending: $pending, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestChartCopyWith<$Res> implements $ServiceRequestChartCopyWith<$Res> {
  factory _$ServiceRequestChartCopyWith(_ServiceRequestChart value, $Res Function(_ServiceRequestChart) _then) = __$ServiceRequestChartCopyWithImpl;
@override @useResult
$Res call({
 List<ChartData> completed, List<ChartData> pending, List<ChartData> cancelled
});




}
/// @nodoc
class __$ServiceRequestChartCopyWithImpl<$Res>
    implements _$ServiceRequestChartCopyWith<$Res> {
  __$ServiceRequestChartCopyWithImpl(this._self, this._then);

  final _ServiceRequestChart _self;
  final $Res Function(_ServiceRequestChart) _then;

/// Create a copy of ServiceRequestChart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completed = null,Object? pending = null,Object? cancelled = null,}) {
  return _then(_ServiceRequestChart(
completed: null == completed ? _self._completed : completed // ignore: cast_nullable_to_non_nullable
as List<ChartData>,pending: null == pending ? _self._pending : pending // ignore: cast_nullable_to_non_nullable
as List<ChartData>,cancelled: null == cancelled ? _self._cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as List<ChartData>,
  ));
}


}


/// @nodoc
mixin _$ServiceCategoryData {

 String get category; double get percentage; int get count; String get color;
/// Create a copy of ServiceCategoryData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCategoryDataCopyWith<ServiceCategoryData> get copyWith => _$ServiceCategoryDataCopyWithImpl<ServiceCategoryData>(this as ServiceCategoryData, _$identity);

  /// Serializes this ServiceCategoryData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCategoryData&&(identical(other.category, category) || other.category == category)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.count, count) || other.count == count)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,percentage,count,color);

@override
String toString() {
  return 'ServiceCategoryData(category: $category, percentage: $percentage, count: $count, color: $color)';
}


}

/// @nodoc
abstract mixin class $ServiceCategoryDataCopyWith<$Res>  {
  factory $ServiceCategoryDataCopyWith(ServiceCategoryData value, $Res Function(ServiceCategoryData) _then) = _$ServiceCategoryDataCopyWithImpl;
@useResult
$Res call({
 String category, double percentage, int count, String color
});




}
/// @nodoc
class _$ServiceCategoryDataCopyWithImpl<$Res>
    implements $ServiceCategoryDataCopyWith<$Res> {
  _$ServiceCategoryDataCopyWithImpl(this._self, this._then);

  final ServiceCategoryData _self;
  final $Res Function(ServiceCategoryData) _then;

/// Create a copy of ServiceCategoryData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? percentage = null,Object? count = null,Object? color = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceCategoryData implements ServiceCategoryData {
  const _ServiceCategoryData({required this.category, required this.percentage, required this.count, required this.color});
  factory _ServiceCategoryData.fromJson(Map<String, dynamic> json) => _$ServiceCategoryDataFromJson(json);

@override final  String category;
@override final  double percentage;
@override final  int count;
@override final  String color;

/// Create a copy of ServiceCategoryData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCategoryDataCopyWith<_ServiceCategoryData> get copyWith => __$ServiceCategoryDataCopyWithImpl<_ServiceCategoryData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceCategoryDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceCategoryData&&(identical(other.category, category) || other.category == category)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.count, count) || other.count == count)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,percentage,count,color);

@override
String toString() {
  return 'ServiceCategoryData(category: $category, percentage: $percentage, count: $count, color: $color)';
}


}

/// @nodoc
abstract mixin class _$ServiceCategoryDataCopyWith<$Res> implements $ServiceCategoryDataCopyWith<$Res> {
  factory _$ServiceCategoryDataCopyWith(_ServiceCategoryData value, $Res Function(_ServiceCategoryData) _then) = __$ServiceCategoryDataCopyWithImpl;
@override @useResult
$Res call({
 String category, double percentage, int count, String color
});




}
/// @nodoc
class __$ServiceCategoryDataCopyWithImpl<$Res>
    implements _$ServiceCategoryDataCopyWith<$Res> {
  __$ServiceCategoryDataCopyWithImpl(this._self, this._then);

  final _ServiceCategoryData _self;
  final $Res Function(_ServiceCategoryData) _then;

/// Create a copy of ServiceCategoryData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? percentage = null,Object? count = null,Object? color = null,}) {
  return _then(_ServiceCategoryData(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RecentServiceRequest {

 String get id; String get studentName; String get serviceName; String get providerName; String get status; DateTime get createdAt; double get amount;
/// Create a copy of RecentServiceRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentServiceRequestCopyWith<RecentServiceRequest> get copyWith => _$RecentServiceRequestCopyWithImpl<RecentServiceRequest>(this as RecentServiceRequest, _$identity);

  /// Serializes this RecentServiceRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentServiceRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,studentName,serviceName,providerName,status,createdAt,amount);

@override
String toString() {
  return 'RecentServiceRequest(id: $id, studentName: $studentName, serviceName: $serviceName, providerName: $providerName, status: $status, createdAt: $createdAt, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $RecentServiceRequestCopyWith<$Res>  {
  factory $RecentServiceRequestCopyWith(RecentServiceRequest value, $Res Function(RecentServiceRequest) _then) = _$RecentServiceRequestCopyWithImpl;
@useResult
$Res call({
 String id, String studentName, String serviceName, String providerName, String status, DateTime createdAt, double amount
});




}
/// @nodoc
class _$RecentServiceRequestCopyWithImpl<$Res>
    implements $RecentServiceRequestCopyWith<$Res> {
  _$RecentServiceRequestCopyWithImpl(this._self, this._then);

  final RecentServiceRequest _self;
  final $Res Function(RecentServiceRequest) _then;

/// Create a copy of RecentServiceRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentName = null,Object? serviceName = null,Object? providerName = null,Object? status = null,Object? createdAt = null,Object? amount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RecentServiceRequest implements RecentServiceRequest {
  const _RecentServiceRequest({required this.id, required this.studentName, required this.serviceName, required this.providerName, required this.status, required this.createdAt, required this.amount});
  factory _RecentServiceRequest.fromJson(Map<String, dynamic> json) => _$RecentServiceRequestFromJson(json);

@override final  String id;
@override final  String studentName;
@override final  String serviceName;
@override final  String providerName;
@override final  String status;
@override final  DateTime createdAt;
@override final  double amount;

/// Create a copy of RecentServiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentServiceRequestCopyWith<_RecentServiceRequest> get copyWith => __$RecentServiceRequestCopyWithImpl<_RecentServiceRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentServiceRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentServiceRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,studentName,serviceName,providerName,status,createdAt,amount);

@override
String toString() {
  return 'RecentServiceRequest(id: $id, studentName: $studentName, serviceName: $serviceName, providerName: $providerName, status: $status, createdAt: $createdAt, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$RecentServiceRequestCopyWith<$Res> implements $RecentServiceRequestCopyWith<$Res> {
  factory _$RecentServiceRequestCopyWith(_RecentServiceRequest value, $Res Function(_RecentServiceRequest) _then) = __$RecentServiceRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String studentName, String serviceName, String providerName, String status, DateTime createdAt, double amount
});




}
/// @nodoc
class __$RecentServiceRequestCopyWithImpl<$Res>
    implements _$RecentServiceRequestCopyWith<$Res> {
  __$RecentServiceRequestCopyWithImpl(this._self, this._then);

  final _RecentServiceRequest _self;
  final $Res Function(_RecentServiceRequest) _then;

/// Create a copy of RecentServiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentName = null,Object? serviceName = null,Object? providerName = null,Object? status = null,Object? createdAt = null,Object? amount = null,}) {
  return _then(_RecentServiceRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$DashboardData {

 DashboardStats get stats; ServiceRequestChart get requestChart; List<ServiceCategoryData> get categoryData; List<RecentServiceRequest> get recentRequests;
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<DashboardData> get copyWith => _$DashboardDataCopyWithImpl<DashboardData>(this as DashboardData, _$identity);

  /// Serializes this DashboardData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardData&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.requestChart, requestChart) || other.requestChart == requestChart)&&const DeepCollectionEquality().equals(other.categoryData, categoryData)&&const DeepCollectionEquality().equals(other.recentRequests, recentRequests));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stats,requestChart,const DeepCollectionEquality().hash(categoryData),const DeepCollectionEquality().hash(recentRequests));

@override
String toString() {
  return 'DashboardData(stats: $stats, requestChart: $requestChart, categoryData: $categoryData, recentRequests: $recentRequests)';
}


}

/// @nodoc
abstract mixin class $DashboardDataCopyWith<$Res>  {
  factory $DashboardDataCopyWith(DashboardData value, $Res Function(DashboardData) _then) = _$DashboardDataCopyWithImpl;
@useResult
$Res call({
 DashboardStats stats, ServiceRequestChart requestChart, List<ServiceCategoryData> categoryData, List<RecentServiceRequest> recentRequests
});


$DashboardStatsCopyWith<$Res> get stats;$ServiceRequestChartCopyWith<$Res> get requestChart;

}
/// @nodoc
class _$DashboardDataCopyWithImpl<$Res>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._self, this._then);

  final DashboardData _self;
  final $Res Function(DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stats = null,Object? requestChart = null,Object? categoryData = null,Object? recentRequests = null,}) {
  return _then(_self.copyWith(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DashboardStats,requestChart: null == requestChart ? _self.requestChart : requestChart // ignore: cast_nullable_to_non_nullable
as ServiceRequestChart,categoryData: null == categoryData ? _self.categoryData : categoryData // ignore: cast_nullable_to_non_nullable
as List<ServiceCategoryData>,recentRequests: null == recentRequests ? _self.recentRequests : recentRequests // ignore: cast_nullable_to_non_nullable
as List<RecentServiceRequest>,
  ));
}
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardStatsCopyWith<$Res> get stats {
  
  return $DashboardStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceRequestChartCopyWith<$Res> get requestChart {
  
  return $ServiceRequestChartCopyWith<$Res>(_self.requestChart, (value) {
    return _then(_self.copyWith(requestChart: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _DashboardData implements DashboardData {
  const _DashboardData({required this.stats, required this.requestChart, required final  List<ServiceCategoryData> categoryData, required final  List<RecentServiceRequest> recentRequests}): _categoryData = categoryData,_recentRequests = recentRequests;
  factory _DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);

@override final  DashboardStats stats;
@override final  ServiceRequestChart requestChart;
 final  List<ServiceCategoryData> _categoryData;
@override List<ServiceCategoryData> get categoryData {
  if (_categoryData is EqualUnmodifiableListView) return _categoryData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryData);
}

 final  List<RecentServiceRequest> _recentRequests;
@override List<RecentServiceRequest> get recentRequests {
  if (_recentRequests is EqualUnmodifiableListView) return _recentRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentRequests);
}


/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDataCopyWith<_DashboardData> get copyWith => __$DashboardDataCopyWithImpl<_DashboardData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardData&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.requestChart, requestChart) || other.requestChart == requestChart)&&const DeepCollectionEquality().equals(other._categoryData, _categoryData)&&const DeepCollectionEquality().equals(other._recentRequests, _recentRequests));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stats,requestChart,const DeepCollectionEquality().hash(_categoryData),const DeepCollectionEquality().hash(_recentRequests));

@override
String toString() {
  return 'DashboardData(stats: $stats, requestChart: $requestChart, categoryData: $categoryData, recentRequests: $recentRequests)';
}


}

/// @nodoc
abstract mixin class _$DashboardDataCopyWith<$Res> implements $DashboardDataCopyWith<$Res> {
  factory _$DashboardDataCopyWith(_DashboardData value, $Res Function(_DashboardData) _then) = __$DashboardDataCopyWithImpl;
@override @useResult
$Res call({
 DashboardStats stats, ServiceRequestChart requestChart, List<ServiceCategoryData> categoryData, List<RecentServiceRequest> recentRequests
});


@override $DashboardStatsCopyWith<$Res> get stats;@override $ServiceRequestChartCopyWith<$Res> get requestChart;

}
/// @nodoc
class __$DashboardDataCopyWithImpl<$Res>
    implements _$DashboardDataCopyWith<$Res> {
  __$DashboardDataCopyWithImpl(this._self, this._then);

  final _DashboardData _self;
  final $Res Function(_DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stats = null,Object? requestChart = null,Object? categoryData = null,Object? recentRequests = null,}) {
  return _then(_DashboardData(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DashboardStats,requestChart: null == requestChart ? _self.requestChart : requestChart // ignore: cast_nullable_to_non_nullable
as ServiceRequestChart,categoryData: null == categoryData ? _self._categoryData : categoryData // ignore: cast_nullable_to_non_nullable
as List<ServiceCategoryData>,recentRequests: null == recentRequests ? _self._recentRequests : recentRequests // ignore: cast_nullable_to_non_nullable
as List<RecentServiceRequest>,
  ));
}

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardStatsCopyWith<$Res> get stats {
  
  return $DashboardStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceRequestChartCopyWith<$Res> get requestChart {
  
  return $ServiceRequestChartCopyWith<$Res>(_self.requestChart, (value) {
    return _then(_self.copyWith(requestChart: value));
  });
}
}

// dart format on
