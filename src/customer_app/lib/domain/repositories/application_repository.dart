import 'package:dartz/dartz.dart';
import '../entities/application.dart';
import '../../core/errors/failures.dart';

abstract class ApplicationRepository {
  /// Get a list of applications for the current user
  Future<Either<Failure, List<Application>>> getApplications();

  /// Get details of a specific application by ID
  Future<Either<Failure, Application>> getApplication(String id);

  /// Create a new application
  Future<Either<Failure, Application>> createApplication({
    required String programId,
  });

  /// Update application status
  Future<Either<Failure, Application>> updateApplicationStatus({
    required String id,
    required ApplicationStatus status,
  });

  /// Upload document for an application
  Future<Either<Failure, ApplicationDocument>> uploadDocument({
    required String applicationId,
    required String documentId,
    required String filePath,
  });

  /// Mark a task as completed
  Future<Either<Failure, ApplicationTask>> completeTask({
    required String applicationId,
    required String taskId,
  });
}
