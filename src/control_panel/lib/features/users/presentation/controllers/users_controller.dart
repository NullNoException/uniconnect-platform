import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/providers.dart';
import '../../domain/models/user_list_item.dart';
import '../../domain/repositories/user_repository.dart';

part 'users_controller.freezed.dart';

@freezed
abstract class UsersState with _$UsersState {
  const factory UsersState({
    required bool isLoading,
    required List<UserListItem> users,
    required int totalCount,
    required int currentPage,
    required int pageSize,
    String? searchQuery,
    List<String>? selectedRoles,
    bool? isActiveFilter,
    String? sortBy,
    required bool sortAscending,
    String? error,
  }) = _UsersState;

  factory UsersState.initial() => const UsersState(
    isLoading: false,
    users: [],
    totalCount: 0,
    currentPage: 1,
    pageSize: 10,
    sortAscending: true,
  );
}

class UsersController extends StateNotifier<UsersState> {
  final UserRepository _userRepository;

  UsersController(this._userRepository) : super(UsersState.initial());

  Future<void> loadUsers({
    int? page,
    int? pageSize,
    String? searchQuery,
    List<String>? roles,
    bool? isActive,
    String? sortBy,
    bool? sortAscending,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: page ?? state.currentPage,
      pageSize: pageSize ?? state.pageSize,
      searchQuery: searchQuery ?? state.searchQuery,
      selectedRoles: roles ?? state.selectedRoles,
      isActiveFilter: isActive ?? state.isActiveFilter,
      sortBy: sortBy ?? state.sortBy,
      sortAscending: sortAscending ?? state.sortAscending,
    );

    try {
      final result = await _userRepository.getUsers(
        page: state.currentPage,
        pageSize: state.pageSize,
        searchQuery: state.searchQuery,
        roles: state.selectedRoles,
        isActive: state.isActiveFilter,
        sortBy: state.sortBy,
        sortAscending: state.sortAscending,
      );

      state = state.copyWith(
        isLoading: false,
        users: result.users,
        totalCount: result.totalCount,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _userRepository.deleteUser(id);
      await loadUsers();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateUserStatus(String id, bool isActive) async {
    try {
      await _userRepository.updateUserStatus(id, isActive);
      await loadUsers();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(
      searchQuery: query.isEmpty ? null : query,
      currentPage: 1, // Reset to first page on new search
    );
  }

  void setRoleFilter(List<String>? roles) {
    state = state.copyWith(
      selectedRoles: roles,
      currentPage: 1, // Reset to first page on filter change
    );
  }

  void setActiveFilter(bool? isActive) {
    state = state.copyWith(
      isActiveFilter: isActive,
      currentPage: 1, // Reset to first page on filter change
    );
  }

  void setSorting(String field, bool ascending) {
    state = state.copyWith(sortBy: field, sortAscending: ascending);
  }

  void nextPage() {
    final int maxPage = (state.totalCount / state.pageSize).ceil();
    if (state.currentPage < maxPage) {
      loadUsers(page: state.currentPage + 1);
    }
  }

  void previousPage() {
    if (state.currentPage > 1) {
      loadUsers(page: state.currentPage - 1);
    }
  }

  void goToPage(int page) {
    final int maxPage = (state.totalCount / state.pageSize).ceil();
    if (page >= 1 && page <= maxPage) {
      loadUsers(page: page);
    }
  }

  void setPageSize(int size) {
    loadUsers(pageSize: size, page: 1);
  }

  void clearFilters() {
    loadUsers(searchQuery: null, roles: null, isActive: null, page: 1);
  }
}

final usersControllerProvider =
    StateNotifierProvider<UsersController, UsersState>((ref) {
      final userRepository = ref.watch(userRepositoryProvider);
      return UsersController(userRepository);
    });

// Uses the userRepositoryProvider from core/utils/providers.dart
