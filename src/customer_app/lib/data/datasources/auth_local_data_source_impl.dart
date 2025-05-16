import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_app/core/errors/exceptions.dart';
import 'package:customer_app/data/models/user_model.dart';
import 'package:customer_app/data/datasources/auth_local_data_source.dart';

const cachedUserKey = 'CACHED_USER';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getLastUser() async {
    final jsonString = sharedPreferences.getString(cachedUserKey);
    if (jsonString != null) {
      try {
        return UserModel.fromJson(json.decode(jsonString));
      } catch (e) {
        throw CacheException(
          message: 'Failed to parse cached user data',
          cause: e is Exception ? e : null,
        );
      }
    }
    return null;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    final jsonString = json.encode(user.toJson());
    await sharedPreferences.setString(cachedUserKey, jsonString);
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove(cachedUserKey);
  }
}
