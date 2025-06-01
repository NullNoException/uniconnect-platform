import '../../domain/datasources/provider_data_source.dart';
import '../../domain/models/provider.dart';
import '../../domain/repositories/provider_repository.dart';

class ProviderRepositoryImpl implements ProviderRepository {
  final ProviderDataSource _dataSource;

  ProviderRepositoryImpl(this._dataSource);

  @override
  Future<List<ProviderListItem>> getProviders({
    required int page,
    required int pageSize,
    String? searchQuery,
    ProviderVerificationStatus? status,
    String? sortBy,
    bool? sortDescending,
  }) async {
    return await _dataSource.getProviders(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      status: status,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }

  @override
  Future<Provider> getProviderById(String providerId) async {
    return await _dataSource.getProviderById(providerId);
  }

  @override
  Future<Provider> createProvider(ProviderRequest request) async {
    return await _dataSource.createProvider(request);
  }

  @override
  Future<Provider> updateProvider(
    String providerId,
    ProviderRequest request,
  ) async {
    return await _dataSource.updateProvider(providerId, request);
  }

  @override
  Future<void> deleteProvider(String providerId) async {
    return await _dataSource.deleteProvider(providerId);
  }

  @override
  Future<Provider> verifyProvider(VerifyProviderRequest request) async {
    return await _dataSource.verifyProvider(request);
  }

  @override
  Future<ProviderPerformanceMetrics> getProviderPerformance(
    String providerId,
  ) async {
    return await _dataSource.getProviderPerformance(providerId);
  }

  @override
  Future<Provider> updateProviderStatus(
    String providerId,
    bool isActive,
  ) async {
    return await _dataSource.updateProviderStatus(providerId, isActive);
  }

  @override
  Future<List<ProviderListItem>> getProvidersForVerification({
    required int page,
    required int pageSize,
  }) async {
    return await _dataSource.getProvidersForVerification(
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<int> getVerificationQueueCount() async {
    return await _dataSource.getVerificationQueueCount();
  }
}
