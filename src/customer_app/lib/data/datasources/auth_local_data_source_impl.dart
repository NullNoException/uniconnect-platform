import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'auth_local_data_source.dart';

const CACHED_USER_KEY = 'CACHED_USER';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getLastUser() async {
    final jsonString = sharedPreferences.getString(CACHED_USER_KEY);
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
    await sharedPreferences.setString(CACHED_USER_KEY, jsonString);
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove(CACHED_USER_KEY);
  }
}
