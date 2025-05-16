import '../models/application_model.dart';

abstract class ApplicationRemoteDataSource {
  /// Get a list of applications for the current user
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<List<ApplicationModel>> getApplications();

  /// Get details of a specific application by ID
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<ApplicationModel> getApplication(String id);

  /// Create a new application
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<ApplicationModel> createApplication({required String programId});

  /// Update application status
  ///
  /// Throws a [ServerException] if a server error occurs
  /// The status parameter should be a valid string representation of ApplicationStatus
  Future<ApplicationModel> updateApplicationStatus({
    required String id,
    required String status,
  });

  /// Upload document for an application
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<Map<String, dynamic>> uploadDocument({
    required String applicationId,
    required String documentId,
    required String filePath,
  });

  /// Mark a task as completed
  ///
  /// Throws a [ServerException] if a server error occurs
  Future<Map<String, dynamic>> completeTask({
    required String applicationId,
    required String taskId,
  });
}
