// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UsersState {

 bool get isLoading; List<UserListItem> get users; int get totalCount; int get currentPage; int get pageSize; String? get searchQuery; List<String>? get selectedRoles; bool? get isActiveFilter; String? get sortBy; bool get sortAscending; String? get error;
/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsersStateCopyWith<UsersState> get copyWith => _$UsersStateCopyWithImpl<UsersState>(this as UsersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other.selectedRoles, selectedRoles)&&(identical(other.isActiveFilter, isActiveFilter) || other.isActiveFilter == isActiveFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortAscending, sortAscending) || other.sortAscending == sortAscending)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(users),totalCount,currentPage,pageSize,searchQuery,const DeepCollectionEquality().hash(selectedRoles),isActiveFilter,sortBy,sortAscending,error);

@override
String toString() {
  return 'UsersState(isLoading: $isLoading, users: $users, totalCount: $totalCount, currentPage: $currentPage, pageSize: $pageSize, searchQuery: $searchQuery, selectedRoles: $selectedRoles, isActiveFilter: $isActiveFilter, sortBy: $sortBy, sortAscending: $sortAscending, error: $error)';
}


}

/// @nodoc
abstract mixin class $UsersStateCopyWith<$Res>  {
  factory $UsersStateCopyWith(UsersState value, $Res Function(UsersState) _then) = _$UsersStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<UserListItem> users, int totalCount, int currentPage, int pageSize, String? searchQuery, List<String>? selectedRoles, bool? isActiveFilter, String? sortBy, bool sortAscending, String? error
});




}
/// @nodoc
class _$UsersStateCopyWithImpl<$Res>
    implements $UsersStateCopyWith<$Res> {
  _$UsersStateCopyWithImpl(this._self, this._then);

  final UsersState _self;
  final $Res Function(UsersState) _then;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? users = null,Object? totalCount = null,Object? currentPage = null,Object? pageSize = null,Object? searchQuery = freezed,Object? selectedRoles = freezed,Object? isActiveFilter = freezed,Object? sortBy = freezed,Object? sortAscending = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<UserListItem>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,selectedRoles: freezed == selectedRoles ? _self.selectedRoles : selectedRoles // ignore: cast_nullable_to_non_nullable
as List<String>?,isActiveFilter: freezed == isActiveFilter ? _self.isActiveFilter : isActiveFilter // ignore: cast_nullable_to_non_nullable
as bool?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,sortAscending: null == sortAscending ? _self.sortAscending : sortAscending // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _UsersState implements UsersState {
  const _UsersState({required this.isLoading, required final  List<UserListItem> users, required this.totalCount, required this.currentPage, required this.pageSize, this.searchQuery, final  List<String>? selectedRoles, this.isActiveFilter, this.sortBy, required this.sortAscending, this.error}): _users = users,_selectedRoles = selectedRoles;
  

@override final  bool isLoading;
 final  List<UserListItem> _users;
@override List<UserListItem> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override final  int totalCount;
@override final  int currentPage;
@override final  int pageSize;
@override final  String? searchQuery;
 final  List<String>? _selectedRoles;
@override List<String>? get selectedRoles {
  final value = _selectedRoles;
  if (value == null) return null;
  if (_selectedRoles is EqualUnmodifiableListView) return _selectedRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? isActiveFilter;
@override final  String? sortBy;
@override final  bool sortAscending;
@override final  String? error;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsersStateCopyWith<_UsersState> get copyWith => __$UsersStateCopyWithImpl<_UsersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other._selectedRoles, _selectedRoles)&&(identical(other.isActiveFilter, isActiveFilter) || other.isActiveFilter == isActiveFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortAscending, sortAscending) || other.sortAscending == sortAscending)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_users),totalCount,currentPage,pageSize,searchQuery,const DeepCollectionEquality().hash(_selectedRoles),isActiveFilter,sortBy,sortAscending,error);

@override
String toString() {
  return 'UsersState(isLoading: $isLoading, users: $users, totalCount: $totalCount, currentPage: $currentPage, pageSize: $pageSize, searchQuery: $searchQuery, selectedRoles: $selectedRoles, isActiveFilter: $isActiveFilter, sortBy: $sortBy, sortAscending: $sortAscending, error: $error)';
}


}

/// @nodoc
abstract mixin class _$UsersStateCopyWith<$Res> implements $UsersStateCopyWith<$Res> {
  factory _$UsersStateCopyWith(_UsersState value, $Res Function(_UsersState) _then) = __$UsersStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<UserListItem> users, int totalCount, int currentPage, int pageSize, String? searchQuery, List<String>? selectedRoles, bool? isActiveFilter, String? sortBy, bool sortAscending, String? error
});




}
/// @nodoc
class __$UsersStateCopyWithImpl<$Res>
    implements _$UsersStateCopyWith<$Res> {
  __$UsersStateCopyWithImpl(this._self, this._then);

  final _UsersState _self;
  final $Res Function(_UsersState) _then;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? users = null,Object? totalCount = null,Object? currentPage = null,Object? pageSize = null,Object? searchQuery = freezed,Object? selectedRoles = freezed,Object? isActiveFilter = freezed,Object? sortBy = freezed,Object? sortAscending = null,Object? error = freezed,}) {
  return _then(_UsersState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<UserListItem>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,selectedRoles: freezed == selectedRoles ? _self._selectedRoles : selectedRoles // ignore: cast_nullable_to_non_nullable
as List<String>?,isActiveFilter: freezed == isActiveFilter ? _self.isActiveFilter : isActiveFilter // ignore: cast_nullable_to_non_nullable
as bool?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,sortAscending: null == sortAscending ? _self.sortAscending : sortAscending // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
