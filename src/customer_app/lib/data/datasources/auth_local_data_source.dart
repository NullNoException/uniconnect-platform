import 'package:customer_app/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  /// Gets the cached user data
  ///
  /// Returns the last user that was cached
  /// Throws [CacheException] if no cached data is present
  Future<UserModel?> getLastUser();

  /// Caches the current user
  ///
  /// Throws [CacheException] if caching fails
  Future<void> cacheUser(UserModel user);

  /// Clears the cached user data
  ///
  /// Throws [CacheException] if clearing fails
  Future<void> clearUser();
}
