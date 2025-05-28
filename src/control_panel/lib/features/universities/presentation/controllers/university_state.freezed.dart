// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'university_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UniversityState {

 bool get isLoading; bool get isSubmitting; List<UniversityListItem> get universities; University? get selectedUniversity; int get currentPage; int get totalPages; bool get hasError; String? get errorMessage;
/// Create a copy of UniversityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UniversityStateCopyWith<UniversityState> get copyWith => _$UniversityStateCopyWithImpl<UniversityState>(this as UniversityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UniversityState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&const DeepCollectionEquality().equals(other.universities, universities)&&(identical(other.selectedUniversity, selectedUniversity) || other.selectedUniversity == selectedUniversity)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSubmitting,const DeepCollectionEquality().hash(universities),selectedUniversity,currentPage,totalPages,hasError,errorMessage);

@override
String toString() {
  return 'UniversityState(isLoading: $isLoading, isSubmitting: $isSubmitting, universities: $universities, selectedUniversity: $selectedUniversity, currentPage: $currentPage, totalPages: $totalPages, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UniversityStateCopyWith<$Res>  {
  factory $UniversityStateCopyWith(UniversityState value, $Res Function(UniversityState) _then) = _$UniversityStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSubmitting, List<UniversityListItem> universities, University? selectedUniversity, int currentPage, int totalPages, bool hasError, String? errorMessage
});




}
/// @nodoc
class _$UniversityStateCopyWithImpl<$Res>
    implements $UniversityStateCopyWith<$Res> {
  _$UniversityStateCopyWithImpl(this._self, this._then);

  final UniversityState _self;
  final $Res Function(UniversityState) _then;

/// Create a copy of UniversityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSubmitting = null,Object? universities = null,Object? selectedUniversity = freezed,Object? currentPage = null,Object? totalPages = null,Object? hasError = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,universities: null == universities ? _self.universities : universities // ignore: cast_nullable_to_non_nullable
as List<UniversityListItem>,selectedUniversity: freezed == selectedUniversity ? _self.selectedUniversity : selectedUniversity // ignore: cast_nullable_to_non_nullable
as University?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _UniversityState implements UniversityState {
  const _UniversityState({this.isLoading = false, this.isSubmitting = false, final  List<UniversityListItem> universities = const [], this.selectedUniversity, this.currentPage = 1, this.totalPages = 0, this.hasError = false, this.errorMessage}): _universities = universities;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSubmitting;
 final  List<UniversityListItem> _universities;
@override@JsonKey() List<UniversityListItem> get universities {
  if (_universities is EqualUnmodifiableListView) return _universities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_universities);
}

@override final  University? selectedUniversity;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  bool hasError;
@override final  String? errorMessage;

/// Create a copy of UniversityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UniversityStateCopyWith<_UniversityState> get copyWith => __$UniversityStateCopyWithImpl<_UniversityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UniversityState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&const DeepCollectionEquality().equals(other._universities, _universities)&&(identical(other.selectedUniversity, selectedUniversity) || other.selectedUniversity == selectedUniversity)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSubmitting,const DeepCollectionEquality().hash(_universities),selectedUniversity,currentPage,totalPages,hasError,errorMessage);

@override
String toString() {
  return 'UniversityState(isLoading: $isLoading, isSubmitting: $isSubmitting, universities: $universities, selectedUniversity: $selectedUniversity, currentPage: $currentPage, totalPages: $totalPages, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$UniversityStateCopyWith<$Res> implements $UniversityStateCopyWith<$Res> {
  factory _$UniversityStateCopyWith(_UniversityState value, $Res Function(_UniversityState) _then) = __$UniversityStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSubmitting, List<UniversityListItem> universities, University? selectedUniversity, int currentPage, int totalPages, bool hasError, String? errorMessage
});




}
/// @nodoc
class __$UniversityStateCopyWithImpl<$Res>
    implements _$UniversityStateCopyWith<$Res> {
  __$UniversityStateCopyWithImpl(this._self, this._then);

  final _UniversityState _self;
  final $Res Function(_UniversityState) _then;

/// Create a copy of UniversityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSubmitting = null,Object? universities = null,Object? selectedUniversity = freezed,Object? currentPage = null,Object? totalPages = null,Object? hasError = null,Object? errorMessage = freezed,}) {
  return _then(_UniversityState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,universities: null == universities ? _self._universities : universities // ignore: cast_nullable_to_non_nullable
as List<UniversityListItem>,selectedUniversity: freezed == selectedUniversity ? _self.selectedUniversity : selectedUniversity // ignore: cast_nullable_to_non_nullable
as University?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
