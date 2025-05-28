import '../../domain/models/user_list_item.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<({List<UserListItem> users, int totalCount})> getUsers({
    required int page,
    required int pageSize,
    String? searchQuery,
    List<String>? roles,
    bool? isActive,
    String? sortBy,
    bool? sortAscending,
  }) {
    return _dataSource.getUsers(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      roles: roles,
      isActive: isActive,
      sortBy: sortBy,
      sortAscending: sortAscending,
    );
  }

  @override
  Future<UserListItem> getUserById(String id) {
    return _dataSource.getUserById(id);
  }

  @override
  Future<String> createUser(Map<String, dynamic> userData) {
    return _dataSource.createUser(userData);
  }

  @override
  Future<bool> updateUser(String id, Map<String, dynamic> userData) {
    return _dataSource.updateUser(id, userData);
  }

  @override
  Future<bool> deleteUser(String id) {
    return _dataSource.deleteUser(id);
  }

  @override
  Future<bool> updateUserStatus(String id, bool isActive) {
    return _dataSource.updateUserStatus(id, isActive);
  }
}
