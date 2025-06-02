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
import '../../features/services/data/datasources/service_api_data_source.dart';
import '../../features/services/data/repositories/service_repository_impl.dart';
import '../../features/services/domain/datasources/service_data_source.dart';
import '../../features/services/domain/repositories/service_repository.dart';
import '../../features/service_requests/data/datasources/service_request_api_data_source.dart';
import '../../features/service_requests/data/repositories/service_request_repository_impl.dart';
import '../../features/service_requests/domain/repositories/service_request_repository.dart';
import '../../features/service_requests/domain/usecases/service_request_usecases.dart';
// Import with alias to avoid naming conflict
import '../../features/service_requests/domain/datasources/service_request_data_source.dart'
    as domain;

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Register external dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<Logger>(Logger());

  // Register network client
  const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080',
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

  locator.registerLazySingleton<ServiceDataSource>(
    () => ServiceApiDataSource(locator<ApiClient>()),
  );

  locator.registerLazySingleton<ServiceRequestDataSource>(
    () => ServiceRequestApiDataSource(locator<ApiClient>()),
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

  locator.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(locator<ServiceDataSource>()),
  );

  locator.registerLazySingleton<ServiceRequestRepository>(
    () => ServiceRequestRepositoryImpl(
      locator<domain.ServiceRequestDataSource>(),
    ),
  );

  // Register use cases (will be added later)

  // Register service request use cases
  locator.registerLazySingleton(
    () => GetServiceRequestsUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => GetServiceRequestByIdUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => UpdateServiceRequestUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () =>
        GetServiceRequestsForReviewUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => GetServiceRequestsForDocumentReviewUseCase(
      locator<ServiceRequestRepository>(),
    ),
  );

  locator.registerLazySingleton(
    () => VerifyDocumentUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => UpdateMilestoneUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => GetServiceRequestStatsUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => GetServiceRequestMetricsUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => ExportServiceRequestsUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => GetServiceRequestTimelineUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => SendServiceRequestNotificationUseCase(
      locator<ServiceRequestRepository>(),
    ),
  );

  locator.registerLazySingleton(
    () => GetPendingDocumentVerificationCountUseCase(
      locator<ServiceRequestRepository>(),
    ),
  );

  locator.registerLazySingleton(
    () => GetOverdueServiceRequestsCountUseCase(
      locator<ServiceRequestRepository>(),
    ),
  );

  locator.registerLazySingleton(
    () => GetServiceRequestsByProviderUseCase(
      locator<ServiceRequestRepository>(),
    ),
  );

  locator.registerLazySingleton(
    () =>
        GetServiceRequestsByStudentUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () =>
        AssignAdminToServiceRequestUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => GetServiceRequestsAssignedToAdminUseCase(
      locator<ServiceRequestRepository>(),
    ),
  );

  locator.registerLazySingleton(
    () => EscalateServiceRequestUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () =>
        GetDisputedServiceRequestsUseCase(locator<ServiceRequestRepository>()),
  );

  locator.registerLazySingleton(
    () => ResolveDisputeUseCase(locator<ServiceRequestRepository>()),
  );
}
