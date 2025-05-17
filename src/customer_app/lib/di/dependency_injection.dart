import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:customer_app/core/network/network_info.dart';
import 'package:customer_app/core/network/api_client.dart';
import 'package:customer_app/domain/repositories/application_repository.dart';
import 'package:customer_app/data/repositories/application_repository_impl.dart';
import 'package:customer_app/data/datasources/application_remote_data_source.dart';
import 'package:customer_app/data/datasources/application_local_data_source.dart';
import 'package:customer_app/data/datasources/mock_application_data_source.dart';

// Network Info Provider
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  // Create NetworkInfo instance directly
  return NetworkInfo();
});

// API Client Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = Dio();
  // Configure dio as needed
  dio.options.baseUrl = 'https://api.uniconnect.com';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 10);

  return ApiClient(dio);
});

// Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('This provider must be overridden before use');
});

// Remote Data Source Provider
final applicationRemoteDataSourceProvider =
    Provider<ApplicationRemoteDataSource>((ref) {
      // Use mock implementation for now
      // Later we can switch to the real implementation
      return MockApplicationRemoteDataSource();

      // For the real implementation:
      // final apiClient = ref.watch(apiClientProvider);
      // return ApplicationRemoteDataSourceImpl(client: apiClient);
    });

// Local Data Source Provider
final applicationLocalDataSourceProvider = Provider<ApplicationLocalDataSource>(
  (ref) {
    // Use mock implementation for now
    // Later we can switch to the real implementation
    return MockApplicationLocalDataSource();

    // For the real implementation:
    // final sharedPrefs = ref.watch(sharedPreferencesProvider);
    // return ApplicationLocalDataSourceImpl(sharedPreferences: sharedPrefs);
  },
);

// Repository Provider
final applicationRepositoryProvider = Provider<ApplicationRepository>((ref) {
  final remoteDataSource = ref.watch(applicationRemoteDataSourceProvider);
  final localDataSource = ref.watch(applicationLocalDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);

  return ApplicationRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
  );
});
