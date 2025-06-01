import '../models/provider.dart';
import '../repositories/provider_repository.dart';

/// UC-3.1.1: Verify Provider
class VerifyProviderUseCase {
  final ProviderRepository _repository;

  VerifyProviderUseCase(this._repository);

  Future<Provider> call(VerifyProviderRequest request) async {
    return await _repository.verifyProvider(request);
  }
}

/// UC-3.1.2: Monitor Provider Performance
class GetProviderPerformanceUseCase {
  final ProviderRepository _repository;

  GetProviderPerformanceUseCase(this._repository);

  Future<ProviderPerformanceMetrics> call(String providerId) async {
    return await _repository.getProviderPerformance(providerId);
  }
}

/// Get providers for verification queue
class GetProvidersForVerificationUseCase {
  final ProviderRepository _repository;

  GetProvidersForVerificationUseCase(this._repository);

  Future<List<ProviderListItem>> call({
    required int page,
    required int pageSize,
  }) async {
    return await _repository.getProvidersForVerification(
      page: page,
      pageSize: pageSize,
    );
  }
}

/// Get verification queue count
class GetVerificationQueueCountUseCase {
  final ProviderRepository _repository;

  GetVerificationQueueCountUseCase(this._repository);

  Future<int> call() async {
    return await _repository.getVerificationQueueCount();
  }
}

/// Update provider status (suspend/reactivate)
class UpdateProviderStatusUseCase {
  final ProviderRepository _repository;

  UpdateProviderStatusUseCase(this._repository);

  Future<Provider> call(String id, bool isActive) async {
    return await _repository.updateProviderStatus(id, isActive);
  }
}

/// Get providers with filtering
class GetProvidersUseCase {
  final ProviderRepository _repository;

  GetProvidersUseCase(this._repository);

  Future<List<ProviderListItem>> call({
    required int page,
    required int pageSize,
    String? searchQuery,
    ProviderVerificationStatus? status,
    String? sortBy,
    bool? sortDescending,
  }) async {
    return await _repository.getProviders(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      status: status,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }
}

/// Get provider details
class GetProviderByIdUseCase {
  final ProviderRepository _repository;

  GetProviderByIdUseCase(this._repository);

  Future<Provider> call(String id) async {
    return await _repository.getProviderById(id);
  }
}
