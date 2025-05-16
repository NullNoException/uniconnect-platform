import '../models/application_model.dart';

abstract class ApplicationLocalDataSource {
  /// Gets cached applications
  ///
  /// Throws [CacheException] if no cached data is present
  Future<List<ApplicationModel>> getApplications();

  /// Gets cached application by id
  ///
  /// Throws [CacheException] if no cached data is present
  Future<ApplicationModel?> getApplication(String id);

  /// Caches applications
  ///
  /// Throws [CacheException] if caching fails
  Future<void> cacheApplications(List<ApplicationModel> applications);

  /// Caches a single application
  ///
  /// Throws [CacheException] if caching fails
  Future<void> cacheApplication(ApplicationModel application);

  /// Updates the status of a cached application
  ///
  /// Throws [CacheException] if updating fails
  /// The status parameter should be a valid string representation of ApplicationStatus
  Future<void> updateApplicationStatus({
    required String id,
    required String status,
  });

  /// Updates document status for application
  ///
  /// Throws [CacheException] if updating fails
  /// The status parameter should be a valid string representation of DocumentStatus
  Future<void> updateDocumentStatus({
    required String applicationId,
    required String documentId,
    required String status,
    required String? fileUrl,
  });

  /// Updates task completion status
  ///
  /// Throws [CacheException] if updating fails
  Future<void> updateTaskStatus({
    required String applicationId,
    required String taskId,
    required bool isCompleted,
  });
}
