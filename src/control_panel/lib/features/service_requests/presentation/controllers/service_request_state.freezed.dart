// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceRequestState {

 bool get isLoading; bool get isSubmitting; List<ServiceRequestListItem> get serviceRequests; ServiceRequest? get selectedServiceRequest; int get currentPage; int get pageSize; int get totalCount; String? get searchQuery; ServiceRequestStatus? get statusFilter; String? get studentFilter; String? get providerFilter; DateTime? get startDateFilter; DateTime? get endDateFilter; String? get sortBy; bool get sortDescending; bool get hasError; String? get errorMessage;// Document verification state
 bool get isVerifyingDocument; List<RequestDocument> get documentsForReview; int get pendingDocumentCount;// Milestone tracking state
 bool get isUpdatingMilestone; List<RequestMilestone> get milestones;// Dispute resolution state
 bool get isResolvingDispute; List<ServiceRequestListItem> get disputedRequests;// Dashboard statistics
 Map<String, dynamic>? get stats; Map<String, dynamic>? get metrics; int get overdueRequestsCount;
/// Create a copy of ServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestStateCopyWith<ServiceRequestState> get copyWith => _$ServiceRequestStateCopyWithImpl<ServiceRequestState>(this as ServiceRequestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&const DeepCollectionEquality().equals(other.serviceRequests, serviceRequests)&&(identical(other.selectedServiceRequest, selectedServiceRequest) || other.selectedServiceRequest == selectedServiceRequest)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.studentFilter, studentFilter) || other.studentFilter == studentFilter)&&(identical(other.providerFilter, providerFilter) || other.providerFilter == providerFilter)&&(identical(other.startDateFilter, startDateFilter) || other.startDateFilter == startDateFilter)&&(identical(other.endDateFilter, endDateFilter) || other.endDateFilter == endDateFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortDescending, sortDescending) || other.sortDescending == sortDescending)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isVerifyingDocument, isVerifyingDocument) || other.isVerifyingDocument == isVerifyingDocument)&&const DeepCollectionEquality().equals(other.documentsForReview, documentsForReview)&&(identical(other.pendingDocumentCount, pendingDocumentCount) || other.pendingDocumentCount == pendingDocumentCount)&&(identical(other.isUpdatingMilestone, isUpdatingMilestone) || other.isUpdatingMilestone == isUpdatingMilestone)&&const DeepCollectionEquality().equals(other.milestones, milestones)&&(identical(other.isResolvingDispute, isResolvingDispute) || other.isResolvingDispute == isResolvingDispute)&&const DeepCollectionEquality().equals(other.disputedRequests, disputedRequests)&&const DeepCollectionEquality().equals(other.stats, stats)&&const DeepCollectionEquality().equals(other.metrics, metrics)&&(identical(other.overdueRequestsCount, overdueRequestsCount) || other.overdueRequestsCount == overdueRequestsCount));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,isSubmitting,const DeepCollectionEquality().hash(serviceRequests),selectedServiceRequest,currentPage,pageSize,totalCount,searchQuery,statusFilter,studentFilter,providerFilter,startDateFilter,endDateFilter,sortBy,sortDescending,hasError,errorMessage,isVerifyingDocument,const DeepCollectionEquality().hash(documentsForReview),pendingDocumentCount,isUpdatingMilestone,const DeepCollectionEquality().hash(milestones),isResolvingDispute,const DeepCollectionEquality().hash(disputedRequests),const DeepCollectionEquality().hash(stats),const DeepCollectionEquality().hash(metrics),overdueRequestsCount]);

@override
String toString() {
  return 'ServiceRequestState(isLoading: $isLoading, isSubmitting: $isSubmitting, serviceRequests: $serviceRequests, selectedServiceRequest: $selectedServiceRequest, currentPage: $currentPage, pageSize: $pageSize, totalCount: $totalCount, searchQuery: $searchQuery, statusFilter: $statusFilter, studentFilter: $studentFilter, providerFilter: $providerFilter, startDateFilter: $startDateFilter, endDateFilter: $endDateFilter, sortBy: $sortBy, sortDescending: $sortDescending, hasError: $hasError, errorMessage: $errorMessage, isVerifyingDocument: $isVerifyingDocument, documentsForReview: $documentsForReview, pendingDocumentCount: $pendingDocumentCount, isUpdatingMilestone: $isUpdatingMilestone, milestones: $milestones, isResolvingDispute: $isResolvingDispute, disputedRequests: $disputedRequests, stats: $stats, metrics: $metrics, overdueRequestsCount: $overdueRequestsCount)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestStateCopyWith<$Res>  {
  factory $ServiceRequestStateCopyWith(ServiceRequestState value, $Res Function(ServiceRequestState) _then) = _$ServiceRequestStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSubmitting, List<ServiceRequestListItem> serviceRequests, ServiceRequest? selectedServiceRequest, int currentPage, int pageSize, int totalCount, String? searchQuery, ServiceRequestStatus? statusFilter, String? studentFilter, String? providerFilter, DateTime? startDateFilter, DateTime? endDateFilter, String? sortBy, bool sortDescending, bool hasError, String? errorMessage, bool isVerifyingDocument, List<RequestDocument> documentsForReview, int pendingDocumentCount, bool isUpdatingMilestone, List<RequestMilestone> milestones, bool isResolvingDispute, List<ServiceRequestListItem> disputedRequests, Map<String, dynamic>? stats, Map<String, dynamic>? metrics, int overdueRequestsCount
});


$ServiceRequestCopyWith<$Res>? get selectedServiceRequest;

}
/// @nodoc
class _$ServiceRequestStateCopyWithImpl<$Res>
    implements $ServiceRequestStateCopyWith<$Res> {
  _$ServiceRequestStateCopyWithImpl(this._self, this._then);

  final ServiceRequestState _self;
  final $Res Function(ServiceRequestState) _then;

/// Create a copy of ServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSubmitting = null,Object? serviceRequests = null,Object? selectedServiceRequest = freezed,Object? currentPage = null,Object? pageSize = null,Object? totalCount = null,Object? searchQuery = freezed,Object? statusFilter = freezed,Object? studentFilter = freezed,Object? providerFilter = freezed,Object? startDateFilter = freezed,Object? endDateFilter = freezed,Object? sortBy = freezed,Object? sortDescending = null,Object? hasError = null,Object? errorMessage = freezed,Object? isVerifyingDocument = null,Object? documentsForReview = null,Object? pendingDocumentCount = null,Object? isUpdatingMilestone = null,Object? milestones = null,Object? isResolvingDispute = null,Object? disputedRequests = null,Object? stats = freezed,Object? metrics = freezed,Object? overdueRequestsCount = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,serviceRequests: null == serviceRequests ? _self.serviceRequests : serviceRequests // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestListItem>,selectedServiceRequest: freezed == selectedServiceRequest ? _self.selectedServiceRequest : selectedServiceRequest // ignore: cast_nullable_to_non_nullable
as ServiceRequest?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus?,studentFilter: freezed == studentFilter ? _self.studentFilter : studentFilter // ignore: cast_nullable_to_non_nullable
as String?,providerFilter: freezed == providerFilter ? _self.providerFilter : providerFilter // ignore: cast_nullable_to_non_nullable
as String?,startDateFilter: freezed == startDateFilter ? _self.startDateFilter : startDateFilter // ignore: cast_nullable_to_non_nullable
as DateTime?,endDateFilter: freezed == endDateFilter ? _self.endDateFilter : endDateFilter // ignore: cast_nullable_to_non_nullable
as DateTime?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,sortDescending: null == sortDescending ? _self.sortDescending : sortDescending // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isVerifyingDocument: null == isVerifyingDocument ? _self.isVerifyingDocument : isVerifyingDocument // ignore: cast_nullable_to_non_nullable
as bool,documentsForReview: null == documentsForReview ? _self.documentsForReview : documentsForReview // ignore: cast_nullable_to_non_nullable
as List<RequestDocument>,pendingDocumentCount: null == pendingDocumentCount ? _self.pendingDocumentCount : pendingDocumentCount // ignore: cast_nullable_to_non_nullable
as int,isUpdatingMilestone: null == isUpdatingMilestone ? _self.isUpdatingMilestone : isUpdatingMilestone // ignore: cast_nullable_to_non_nullable
as bool,milestones: null == milestones ? _self.milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<RequestMilestone>,isResolvingDispute: null == isResolvingDispute ? _self.isResolvingDispute : isResolvingDispute // ignore: cast_nullable_to_non_nullable
as bool,disputedRequests: null == disputedRequests ? _self.disputedRequests : disputedRequests // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestListItem>,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,metrics: freezed == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,overdueRequestsCount: null == overdueRequestsCount ? _self.overdueRequestsCount : overdueRequestsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceRequestCopyWith<$Res>? get selectedServiceRequest {
    if (_self.selectedServiceRequest == null) {
    return null;
  }

  return $ServiceRequestCopyWith<$Res>(_self.selectedServiceRequest!, (value) {
    return _then(_self.copyWith(selectedServiceRequest: value));
  });
}
}


/// @nodoc


class _ServiceRequestState implements ServiceRequestState {
  const _ServiceRequestState({this.isLoading = false, this.isSubmitting = false, final  List<ServiceRequestListItem> serviceRequests = const [], this.selectedServiceRequest, this.currentPage = 1, this.pageSize = 10, this.totalCount = 0, this.searchQuery, this.statusFilter, this.studentFilter, this.providerFilter, this.startDateFilter, this.endDateFilter, this.sortBy, this.sortDescending = true, this.hasError = false, this.errorMessage, this.isVerifyingDocument = false, final  List<RequestDocument> documentsForReview = const [], this.pendingDocumentCount = 0, this.isUpdatingMilestone = false, final  List<RequestMilestone> milestones = const [], this.isResolvingDispute = false, final  List<ServiceRequestListItem> disputedRequests = const [], final  Map<String, dynamic>? stats, final  Map<String, dynamic>? metrics, this.overdueRequestsCount = 0}): _serviceRequests = serviceRequests,_documentsForReview = documentsForReview,_milestones = milestones,_disputedRequests = disputedRequests,_stats = stats,_metrics = metrics;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSubmitting;
 final  List<ServiceRequestListItem> _serviceRequests;
@override@JsonKey() List<ServiceRequestListItem> get serviceRequests {
  if (_serviceRequests is EqualUnmodifiableListView) return _serviceRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceRequests);
}

@override final  ServiceRequest? selectedServiceRequest;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int totalCount;
@override final  String? searchQuery;
@override final  ServiceRequestStatus? statusFilter;
@override final  String? studentFilter;
@override final  String? providerFilter;
@override final  DateTime? startDateFilter;
@override final  DateTime? endDateFilter;
@override final  String? sortBy;
@override@JsonKey() final  bool sortDescending;
@override@JsonKey() final  bool hasError;
@override final  String? errorMessage;
// Document verification state
@override@JsonKey() final  bool isVerifyingDocument;
 final  List<RequestDocument> _documentsForReview;
@override@JsonKey() List<RequestDocument> get documentsForReview {
  if (_documentsForReview is EqualUnmodifiableListView) return _documentsForReview;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documentsForReview);
}

@override@JsonKey() final  int pendingDocumentCount;
// Milestone tracking state
@override@JsonKey() final  bool isUpdatingMilestone;
 final  List<RequestMilestone> _milestones;
@override@JsonKey() List<RequestMilestone> get milestones {
  if (_milestones is EqualUnmodifiableListView) return _milestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_milestones);
}

// Dispute resolution state
@override@JsonKey() final  bool isResolvingDispute;
 final  List<ServiceRequestListItem> _disputedRequests;
@override@JsonKey() List<ServiceRequestListItem> get disputedRequests {
  if (_disputedRequests is EqualUnmodifiableListView) return _disputedRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_disputedRequests);
}

// Dashboard statistics
 final  Map<String, dynamic>? _stats;
// Dashboard statistics
@override Map<String, dynamic>? get stats {
  final value = _stats;
  if (value == null) return null;
  if (_stats is EqualUnmodifiableMapView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _metrics;
@override Map<String, dynamic>? get metrics {
  final value = _metrics;
  if (value == null) return null;
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  int overdueRequestsCount;

/// Create a copy of ServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestStateCopyWith<_ServiceRequestState> get copyWith => __$ServiceRequestStateCopyWithImpl<_ServiceRequestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&const DeepCollectionEquality().equals(other._serviceRequests, _serviceRequests)&&(identical(other.selectedServiceRequest, selectedServiceRequest) || other.selectedServiceRequest == selectedServiceRequest)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.studentFilter, studentFilter) || other.studentFilter == studentFilter)&&(identical(other.providerFilter, providerFilter) || other.providerFilter == providerFilter)&&(identical(other.startDateFilter, startDateFilter) || other.startDateFilter == startDateFilter)&&(identical(other.endDateFilter, endDateFilter) || other.endDateFilter == endDateFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortDescending, sortDescending) || other.sortDescending == sortDescending)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isVerifyingDocument, isVerifyingDocument) || other.isVerifyingDocument == isVerifyingDocument)&&const DeepCollectionEquality().equals(other._documentsForReview, _documentsForReview)&&(identical(other.pendingDocumentCount, pendingDocumentCount) || other.pendingDocumentCount == pendingDocumentCount)&&(identical(other.isUpdatingMilestone, isUpdatingMilestone) || other.isUpdatingMilestone == isUpdatingMilestone)&&const DeepCollectionEquality().equals(other._milestones, _milestones)&&(identical(other.isResolvingDispute, isResolvingDispute) || other.isResolvingDispute == isResolvingDispute)&&const DeepCollectionEquality().equals(other._disputedRequests, _disputedRequests)&&const DeepCollectionEquality().equals(other._stats, _stats)&&const DeepCollectionEquality().equals(other._metrics, _metrics)&&(identical(other.overdueRequestsCount, overdueRequestsCount) || other.overdueRequestsCount == overdueRequestsCount));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,isSubmitting,const DeepCollectionEquality().hash(_serviceRequests),selectedServiceRequest,currentPage,pageSize,totalCount,searchQuery,statusFilter,studentFilter,providerFilter,startDateFilter,endDateFilter,sortBy,sortDescending,hasError,errorMessage,isVerifyingDocument,const DeepCollectionEquality().hash(_documentsForReview),pendingDocumentCount,isUpdatingMilestone,const DeepCollectionEquality().hash(_milestones),isResolvingDispute,const DeepCollectionEquality().hash(_disputedRequests),const DeepCollectionEquality().hash(_stats),const DeepCollectionEquality().hash(_metrics),overdueRequestsCount]);

@override
String toString() {
  return 'ServiceRequestState(isLoading: $isLoading, isSubmitting: $isSubmitting, serviceRequests: $serviceRequests, selectedServiceRequest: $selectedServiceRequest, currentPage: $currentPage, pageSize: $pageSize, totalCount: $totalCount, searchQuery: $searchQuery, statusFilter: $statusFilter, studentFilter: $studentFilter, providerFilter: $providerFilter, startDateFilter: $startDateFilter, endDateFilter: $endDateFilter, sortBy: $sortBy, sortDescending: $sortDescending, hasError: $hasError, errorMessage: $errorMessage, isVerifyingDocument: $isVerifyingDocument, documentsForReview: $documentsForReview, pendingDocumentCount: $pendingDocumentCount, isUpdatingMilestone: $isUpdatingMilestone, milestones: $milestones, isResolvingDispute: $isResolvingDispute, disputedRequests: $disputedRequests, stats: $stats, metrics: $metrics, overdueRequestsCount: $overdueRequestsCount)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestStateCopyWith<$Res> implements $ServiceRequestStateCopyWith<$Res> {
  factory _$ServiceRequestStateCopyWith(_ServiceRequestState value, $Res Function(_ServiceRequestState) _then) = __$ServiceRequestStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSubmitting, List<ServiceRequestListItem> serviceRequests, ServiceRequest? selectedServiceRequest, int currentPage, int pageSize, int totalCount, String? searchQuery, ServiceRequestStatus? statusFilter, String? studentFilter, String? providerFilter, DateTime? startDateFilter, DateTime? endDateFilter, String? sortBy, bool sortDescending, bool hasError, String? errorMessage, bool isVerifyingDocument, List<RequestDocument> documentsForReview, int pendingDocumentCount, bool isUpdatingMilestone, List<RequestMilestone> milestones, bool isResolvingDispute, List<ServiceRequestListItem> disputedRequests, Map<String, dynamic>? stats, Map<String, dynamic>? metrics, int overdueRequestsCount
});


@override $ServiceRequestCopyWith<$Res>? get selectedServiceRequest;

}
/// @nodoc
class __$ServiceRequestStateCopyWithImpl<$Res>
    implements _$ServiceRequestStateCopyWith<$Res> {
  __$ServiceRequestStateCopyWithImpl(this._self, this._then);

  final _ServiceRequestState _self;
  final $Res Function(_ServiceRequestState) _then;

/// Create a copy of ServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSubmitting = null,Object? serviceRequests = null,Object? selectedServiceRequest = freezed,Object? currentPage = null,Object? pageSize = null,Object? totalCount = null,Object? searchQuery = freezed,Object? statusFilter = freezed,Object? studentFilter = freezed,Object? providerFilter = freezed,Object? startDateFilter = freezed,Object? endDateFilter = freezed,Object? sortBy = freezed,Object? sortDescending = null,Object? hasError = null,Object? errorMessage = freezed,Object? isVerifyingDocument = null,Object? documentsForReview = null,Object? pendingDocumentCount = null,Object? isUpdatingMilestone = null,Object? milestones = null,Object? isResolvingDispute = null,Object? disputedRequests = null,Object? stats = freezed,Object? metrics = freezed,Object? overdueRequestsCount = null,}) {
  return _then(_ServiceRequestState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,serviceRequests: null == serviceRequests ? _self._serviceRequests : serviceRequests // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestListItem>,selectedServiceRequest: freezed == selectedServiceRequest ? _self.selectedServiceRequest : selectedServiceRequest // ignore: cast_nullable_to_non_nullable
as ServiceRequest?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus?,studentFilter: freezed == studentFilter ? _self.studentFilter : studentFilter // ignore: cast_nullable_to_non_nullable
as String?,providerFilter: freezed == providerFilter ? _self.providerFilter : providerFilter // ignore: cast_nullable_to_non_nullable
as String?,startDateFilter: freezed == startDateFilter ? _self.startDateFilter : startDateFilter // ignore: cast_nullable_to_non_nullable
as DateTime?,endDateFilter: freezed == endDateFilter ? _self.endDateFilter : endDateFilter // ignore: cast_nullable_to_non_nullable
as DateTime?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,sortDescending: null == sortDescending ? _self.sortDescending : sortDescending // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isVerifyingDocument: null == isVerifyingDocument ? _self.isVerifyingDocument : isVerifyingDocument // ignore: cast_nullable_to_non_nullable
as bool,documentsForReview: null == documentsForReview ? _self._documentsForReview : documentsForReview // ignore: cast_nullable_to_non_nullable
as List<RequestDocument>,pendingDocumentCount: null == pendingDocumentCount ? _self.pendingDocumentCount : pendingDocumentCount // ignore: cast_nullable_to_non_nullable
as int,isUpdatingMilestone: null == isUpdatingMilestone ? _self.isUpdatingMilestone : isUpdatingMilestone // ignore: cast_nullable_to_non_nullable
as bool,milestones: null == milestones ? _self._milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<RequestMilestone>,isResolvingDispute: null == isResolvingDispute ? _self.isResolvingDispute : isResolvingDispute // ignore: cast_nullable_to_non_nullable
as bool,disputedRequests: null == disputedRequests ? _self._disputedRequests : disputedRequests // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestListItem>,stats: freezed == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,metrics: freezed == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,overdueRequestsCount: null == overdueRequestsCount ? _self.overdueRequestsCount : overdueRequestsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceRequestCopyWith<$Res>? get selectedServiceRequest {
    if (_self.selectedServiceRequest == null) {
    return null;
  }

  return $ServiceRequestCopyWith<$Res>(_self.selectedServiceRequest!, (value) {
    return _then(_self.copyWith(selectedServiceRequest: value));
  });
}
}

/// @nodoc
mixin _$ServiceRequestFormState {

 bool get isLoading; bool get isValid; ServiceRequestStatus? get status; DateTime? get requiredByDate; DateTime? get completedDate; String? get cancellationReason; String? get notes; String? get errorMessage; String? get successMessage;
/// Create a copy of ServiceRequestFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestFormStateCopyWith<ServiceRequestFormState> get copyWith => _$ServiceRequestFormStateCopyWithImpl<ServiceRequestFormState>(this as ServiceRequestFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestFormState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.status, status) || other.status == status)&&(identical(other.requiredByDate, requiredByDate) || other.requiredByDate == requiredByDate)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isValid,status,requiredByDate,completedDate,cancellationReason,notes,errorMessage,successMessage);

@override
String toString() {
  return 'ServiceRequestFormState(isLoading: $isLoading, isValid: $isValid, status: $status, requiredByDate: $requiredByDate, completedDate: $completedDate, cancellationReason: $cancellationReason, notes: $notes, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestFormStateCopyWith<$Res>  {
  factory $ServiceRequestFormStateCopyWith(ServiceRequestFormState value, $Res Function(ServiceRequestFormState) _then) = _$ServiceRequestFormStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isValid, ServiceRequestStatus? status, DateTime? requiredByDate, DateTime? completedDate, String? cancellationReason, String? notes, String? errorMessage, String? successMessage
});




}
/// @nodoc
class _$ServiceRequestFormStateCopyWithImpl<$Res>
    implements $ServiceRequestFormStateCopyWith<$Res> {
  _$ServiceRequestFormStateCopyWithImpl(this._self, this._then);

  final ServiceRequestFormState _self;
  final $Res Function(ServiceRequestFormState) _then;

/// Create a copy of ServiceRequestFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isValid = null,Object? status = freezed,Object? requiredByDate = freezed,Object? completedDate = freezed,Object? cancellationReason = freezed,Object? notes = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus?,requiredByDate: freezed == requiredByDate ? _self.requiredByDate : requiredByDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _ServiceRequestFormState implements ServiceRequestFormState {
  const _ServiceRequestFormState({this.isLoading = false, this.isValid = false, this.status, this.requiredByDate, this.completedDate, this.cancellationReason, this.notes, this.errorMessage, this.successMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isValid;
@override final  ServiceRequestStatus? status;
@override final  DateTime? requiredByDate;
@override final  DateTime? completedDate;
@override final  String? cancellationReason;
@override final  String? notes;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of ServiceRequestFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestFormStateCopyWith<_ServiceRequestFormState> get copyWith => __$ServiceRequestFormStateCopyWithImpl<_ServiceRequestFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestFormState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.status, status) || other.status == status)&&(identical(other.requiredByDate, requiredByDate) || other.requiredByDate == requiredByDate)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isValid,status,requiredByDate,completedDate,cancellationReason,notes,errorMessage,successMessage);

@override
String toString() {
  return 'ServiceRequestFormState(isLoading: $isLoading, isValid: $isValid, status: $status, requiredByDate: $requiredByDate, completedDate: $completedDate, cancellationReason: $cancellationReason, notes: $notes, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestFormStateCopyWith<$Res> implements $ServiceRequestFormStateCopyWith<$Res> {
  factory _$ServiceRequestFormStateCopyWith(_ServiceRequestFormState value, $Res Function(_ServiceRequestFormState) _then) = __$ServiceRequestFormStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isValid, ServiceRequestStatus? status, DateTime? requiredByDate, DateTime? completedDate, String? cancellationReason, String? notes, String? errorMessage, String? successMessage
});




}
/// @nodoc
class __$ServiceRequestFormStateCopyWithImpl<$Res>
    implements _$ServiceRequestFormStateCopyWith<$Res> {
  __$ServiceRequestFormStateCopyWithImpl(this._self, this._then);

  final _ServiceRequestFormState _self;
  final $Res Function(_ServiceRequestFormState) _then;

/// Create a copy of ServiceRequestFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isValid = null,Object? status = freezed,Object? requiredByDate = freezed,Object? completedDate = freezed,Object? cancellationReason = freezed,Object? notes = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_ServiceRequestFormState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceRequestStatus?,requiredByDate: freezed == requiredByDate ? _self.requiredByDate : requiredByDate // ignore: cast_nullable_to_non_nullable
as DateTime?,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$DocumentVerificationState {

 bool get isLoading; DocumentStatus? get status; String? get verificationNotes; String? get errorMessage; String? get successMessage;
/// Create a copy of DocumentVerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentVerificationStateCopyWith<DocumentVerificationState> get copyWith => _$DocumentVerificationStateCopyWithImpl<DocumentVerificationState>(this as DocumentVerificationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentVerificationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.status, status) || other.status == status)&&(identical(other.verificationNotes, verificationNotes) || other.verificationNotes == verificationNotes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,status,verificationNotes,errorMessage,successMessage);

@override
String toString() {
  return 'DocumentVerificationState(isLoading: $isLoading, status: $status, verificationNotes: $verificationNotes, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $DocumentVerificationStateCopyWith<$Res>  {
  factory $DocumentVerificationStateCopyWith(DocumentVerificationState value, $Res Function(DocumentVerificationState) _then) = _$DocumentVerificationStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, DocumentStatus? status, String? verificationNotes, String? errorMessage, String? successMessage
});




}
/// @nodoc
class _$DocumentVerificationStateCopyWithImpl<$Res>
    implements $DocumentVerificationStateCopyWith<$Res> {
  _$DocumentVerificationStateCopyWithImpl(this._self, this._then);

  final DocumentVerificationState _self;
  final $Res Function(DocumentVerificationState) _then;

/// Create a copy of DocumentVerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? status = freezed,Object? verificationNotes = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus?,verificationNotes: freezed == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _DocumentVerificationState implements DocumentVerificationState {
  const _DocumentVerificationState({this.isLoading = false, this.status, this.verificationNotes, this.errorMessage, this.successMessage});
  

@override@JsonKey() final  bool isLoading;
@override final  DocumentStatus? status;
@override final  String? verificationNotes;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of DocumentVerificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentVerificationStateCopyWith<_DocumentVerificationState> get copyWith => __$DocumentVerificationStateCopyWithImpl<_DocumentVerificationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentVerificationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.status, status) || other.status == status)&&(identical(other.verificationNotes, verificationNotes) || other.verificationNotes == verificationNotes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,status,verificationNotes,errorMessage,successMessage);

@override
String toString() {
  return 'DocumentVerificationState(isLoading: $isLoading, status: $status, verificationNotes: $verificationNotes, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$DocumentVerificationStateCopyWith<$Res> implements $DocumentVerificationStateCopyWith<$Res> {
  factory _$DocumentVerificationStateCopyWith(_DocumentVerificationState value, $Res Function(_DocumentVerificationState) _then) = __$DocumentVerificationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, DocumentStatus? status, String? verificationNotes, String? errorMessage, String? successMessage
});




}
/// @nodoc
class __$DocumentVerificationStateCopyWithImpl<$Res>
    implements _$DocumentVerificationStateCopyWith<$Res> {
  __$DocumentVerificationStateCopyWithImpl(this._self, this._then);

  final _DocumentVerificationState _self;
  final $Res Function(_DocumentVerificationState) _then;

/// Create a copy of DocumentVerificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? status = freezed,Object? verificationNotes = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_DocumentVerificationState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus?,verificationNotes: freezed == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$MilestoneUpdateState {

 bool get isLoading; MilestoneStatus? get status; DateTime? get completionDate; String? get notes; String? get errorMessage; String? get successMessage;
/// Create a copy of MilestoneUpdateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilestoneUpdateStateCopyWith<MilestoneUpdateState> get copyWith => _$MilestoneUpdateStateCopyWithImpl<MilestoneUpdateState>(this as MilestoneUpdateState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MilestoneUpdateState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.status, status) || other.status == status)&&(identical(other.completionDate, completionDate) || other.completionDate == completionDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,status,completionDate,notes,errorMessage,successMessage);

@override
String toString() {
  return 'MilestoneUpdateState(isLoading: $isLoading, status: $status, completionDate: $completionDate, notes: $notes, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $MilestoneUpdateStateCopyWith<$Res>  {
  factory $MilestoneUpdateStateCopyWith(MilestoneUpdateState value, $Res Function(MilestoneUpdateState) _then) = _$MilestoneUpdateStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, MilestoneStatus? status, DateTime? completionDate, String? notes, String? errorMessage, String? successMessage
});




}
/// @nodoc
class _$MilestoneUpdateStateCopyWithImpl<$Res>
    implements $MilestoneUpdateStateCopyWith<$Res> {
  _$MilestoneUpdateStateCopyWithImpl(this._self, this._then);

  final MilestoneUpdateState _self;
  final $Res Function(MilestoneUpdateState) _then;

/// Create a copy of MilestoneUpdateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? status = freezed,Object? completionDate = freezed,Object? notes = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MilestoneStatus?,completionDate: freezed == completionDate ? _self.completionDate : completionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _MilestoneUpdateState implements MilestoneUpdateState {
  const _MilestoneUpdateState({this.isLoading = false, this.status, this.completionDate, this.notes, this.errorMessage, this.successMessage});
  

@override@JsonKey() final  bool isLoading;
@override final  MilestoneStatus? status;
@override final  DateTime? completionDate;
@override final  String? notes;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of MilestoneUpdateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilestoneUpdateStateCopyWith<_MilestoneUpdateState> get copyWith => __$MilestoneUpdateStateCopyWithImpl<_MilestoneUpdateState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MilestoneUpdateState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.status, status) || other.status == status)&&(identical(other.completionDate, completionDate) || other.completionDate == completionDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,status,completionDate,notes,errorMessage,successMessage);

@override
String toString() {
  return 'MilestoneUpdateState(isLoading: $isLoading, status: $status, completionDate: $completionDate, notes: $notes, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$MilestoneUpdateStateCopyWith<$Res> implements $MilestoneUpdateStateCopyWith<$Res> {
  factory _$MilestoneUpdateStateCopyWith(_MilestoneUpdateState value, $Res Function(_MilestoneUpdateState) _then) = __$MilestoneUpdateStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, MilestoneStatus? status, DateTime? completionDate, String? notes, String? errorMessage, String? successMessage
});




}
/// @nodoc
class __$MilestoneUpdateStateCopyWithImpl<$Res>
    implements _$MilestoneUpdateStateCopyWith<$Res> {
  __$MilestoneUpdateStateCopyWithImpl(this._self, this._then);

  final _MilestoneUpdateState _self;
  final $Res Function(_MilestoneUpdateState) _then;

/// Create a copy of MilestoneUpdateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? status = freezed,Object? completionDate = freezed,Object? notes = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_MilestoneUpdateState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MilestoneStatus?,completionDate: freezed == completionDate ? _self.completionDate : completionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$DisputeResolutionState {

 bool get isLoading; String? get resolution; String? get resolutionType; String? get errorMessage; String? get successMessage;
/// Create a copy of DisputeResolutionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeResolutionStateCopyWith<DisputeResolutionState> get copyWith => _$DisputeResolutionStateCopyWithImpl<DisputeResolutionState>(this as DisputeResolutionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeResolutionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.resolutionType, resolutionType) || other.resolutionType == resolutionType)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,resolution,resolutionType,errorMessage,successMessage);

@override
String toString() {
  return 'DisputeResolutionState(isLoading: $isLoading, resolution: $resolution, resolutionType: $resolutionType, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $DisputeResolutionStateCopyWith<$Res>  {
  factory $DisputeResolutionStateCopyWith(DisputeResolutionState value, $Res Function(DisputeResolutionState) _then) = _$DisputeResolutionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? resolution, String? resolutionType, String? errorMessage, String? successMessage
});




}
/// @nodoc
class _$DisputeResolutionStateCopyWithImpl<$Res>
    implements $DisputeResolutionStateCopyWith<$Res> {
  _$DisputeResolutionStateCopyWithImpl(this._self, this._then);

  final DisputeResolutionState _self;
  final $Res Function(DisputeResolutionState) _then;

/// Create a copy of DisputeResolutionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? resolution = freezed,Object? resolutionType = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,resolutionType: freezed == resolutionType ? _self.resolutionType : resolutionType // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _DisputeResolutionState implements DisputeResolutionState {
  const _DisputeResolutionState({this.isLoading = false, this.resolution, this.resolutionType, this.errorMessage, this.successMessage});
  

@override@JsonKey() final  bool isLoading;
@override final  String? resolution;
@override final  String? resolutionType;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of DisputeResolutionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeResolutionStateCopyWith<_DisputeResolutionState> get copyWith => __$DisputeResolutionStateCopyWithImpl<_DisputeResolutionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeResolutionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.resolutionType, resolutionType) || other.resolutionType == resolutionType)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,resolution,resolutionType,errorMessage,successMessage);

@override
String toString() {
  return 'DisputeResolutionState(isLoading: $isLoading, resolution: $resolution, resolutionType: $resolutionType, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$DisputeResolutionStateCopyWith<$Res> implements $DisputeResolutionStateCopyWith<$Res> {
  factory _$DisputeResolutionStateCopyWith(_DisputeResolutionState value, $Res Function(_DisputeResolutionState) _then) = __$DisputeResolutionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? resolution, String? resolutionType, String? errorMessage, String? successMessage
});




}
/// @nodoc
class __$DisputeResolutionStateCopyWithImpl<$Res>
    implements _$DisputeResolutionStateCopyWith<$Res> {
  __$DisputeResolutionStateCopyWithImpl(this._self, this._then);

  final _DisputeResolutionState _self;
  final $Res Function(_DisputeResolutionState) _then;

/// Create a copy of DisputeResolutionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? resolution = freezed,Object? resolutionType = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_DisputeResolutionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,resolutionType: freezed == resolutionType ? _self.resolutionType : resolutionType // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
