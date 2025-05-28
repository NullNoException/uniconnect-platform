import '../models/user_list_item.dart';

// Repository interface for user management
abstract class UserRepository {
  /// Get a paginated list of users
  Future<({List<UserListItem> users, int totalCount})> getUsers({
    required int page,
    required int pageSize,
    String? searchQuery,
    List<String>? roles,
    bool? isActive,
    String? sortBy,
    bool? sortAscending,
  });

  /// Get a single user by ID
  Future<UserListItem> getUserById(String id);

  /// Create a new user
  Future<String> createUser(Map<String, dynamic> userData);

  /// Update an existing user
  Future<bool> updateUser(String id, Map<String, dynamic> userData);

  /// Delete a user
  Future<bool> deleteUser(String id);

  /// Update user status (activate/deactivate)
  Future<bool> updateUserStatus(String id, bool isActive);
}
