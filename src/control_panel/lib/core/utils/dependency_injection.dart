import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_client.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/users/data/datasources/user_remote_data_source.dart';
import '../../features/users/data/repositories/user_repository_impl.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/universities/data/datasources/university_remote_data_source.dart';
import '../../features/universities/data/repositories/university_repository_impl.dart';
import '../../features/universities/domain/datasources/university_data_source.dart';
import '../../features/universities/domain/repositories/university_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Register external dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<Logger>(Logger());

  // Register network client
  const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5000',
  );
  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(baseUrl: baseUrl, prefs: locator<SharedPreferences>()),
  );

  // Register data sources
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(locator<ApiClient>()),
  );

  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(locator<ApiClient>()),
  );

  locator.registerLazySingleton<UniversityDataSource>(
    () => UniversityRemoteDataSource(locator<ApiClient>()),
  );

  // Register repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator<AuthRemoteDataSource>(),
      locator<SharedPreferences>(),
    ),
  );

  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(locator<UserRemoteDataSource>()),
  );

  locator.registerLazySingleton<UniversityRepository>(
    () => UniversityRepositoryImpl(locator<UniversityDataSource>()),
  );

  // Register use cases (will be added later)
}
