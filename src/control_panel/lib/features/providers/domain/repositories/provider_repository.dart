import '../models/provider.dart';

abstract class ProviderRepository {
  /// Get providers with filtering and pagination
  Future<List<ProviderListItem>> getProviders({
    required int page,
    required int pageSize,
    String? searchQuery,
    ProviderVerificationStatus? status,
    String? sortBy,
    bool? sortDescending,
  });

  /// Get a specific provider by ID
  Future<Provider> getProviderById(String id);

  /// Create a new provider
  Future<Provider> createProvider(ProviderRequest request);

  /// Update an existing provider
  Future<Provider> updateProvider(String id, ProviderRequest request);

  /// Delete a provider
  Future<void> deleteProvider(String id);

  /// Verify a provider (approve or reject)
  Future<Provider> verifyProvider(VerifyProviderRequest request);

  /// Get provider performance metrics
  Future<ProviderPerformanceMetrics> getProviderPerformance(String providerId);

  /// Get providers requiring verification
  Future<List<ProviderListItem>> getProvidersForVerification({
    required int page,
    required int pageSize,
  });

  /// Suspend or reactivate a provider
  Future<Provider> updateProviderStatus(String id, bool isActive);

  /// Get provider verification queue count
  Future<int> getVerificationQueueCount();
}
