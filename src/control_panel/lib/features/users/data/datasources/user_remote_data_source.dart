import 'package:dio/dio.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../domain/models/user_list_item.dart';

// Data source for user operations
class UserRemoteDataSource {
  final ApiClient _apiClient;

  UserRemoteDataSource(this._apiClient);

  Future<({List<UserListItem> users, int totalCount})> getUsers({
    required int page,
    required int pageSize,
    String? searchQuery,
    List<String>? roles,
    bool? isActive,
    String? sortBy,
    bool? sortAscending,
  }) async {
    try {
      final queryParams = {
        'page': page,
        'pageSize': pageSize,
        if (searchQuery != null) 'search': searchQuery,
        if (roles != null && roles.isNotEmpty) 'roles': roles.join(','),
        if (isActive != null) 'isActive': isActive.toString(),
        if (sortBy != null) 'sortBy': sortBy,
        if (sortAscending != null) 'sortAscending': sortAscending.toString(),
      };

      final response = await _apiClient.get(
        ApiEndpoints.users,
        queryParameters: queryParams,
      );

      final List<dynamic> usersList = response.data['items'] as List<dynamic>;
      final totalCount = response.data['totalCount'] as int;

      final users =
          usersList
              .map(
                (user) => UserListItem.fromJson(user as Map<String, dynamic>),
              )
              .toList();

      return (users: users, totalCount: totalCount);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserListItem> getUserById(String id) async {
    try {
      final response = await _apiClient.get('${ApiEndpoints.userById}$id');
      return UserListItem.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<String> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.users,
        data: userData,
      );
      return response.data['id'] as String;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> updateUser(String id, Map<String, dynamic> userData) async {
    try {
      await _apiClient.put('${ApiEndpoints.userById}$id', data: userData);
      return true;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      await _apiClient.delete('${ApiEndpoints.userById}$id');
      return true;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> updateUserStatus(String id, bool isActive) async {
    try {
      await _apiClient.patch(
        '${ApiEndpoints.userById}$id/status',
        data: {'isActive': isActive},
      );
      return true;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      if (response != null) {
        final statusCode = response.statusCode;
        final message =
            response.data['message'] as String? ??
            'An error occurred while processing your request';

        if (statusCode == 404) {
          return Exception('User not found');
        } else if (statusCode == 400) {
          return Exception(message);
        } else if (statusCode == 401 || statusCode == 403) {
          return Exception('You do not have permission to perform this action');
        }
      }
      return Exception('Network error occurred');
    }
    return Exception('Unexpected error occurred');
  }
}
