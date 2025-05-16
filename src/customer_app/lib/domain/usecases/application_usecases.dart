import 'package:dartz/dartz.dart';
import '../entities/application.dart';
import '../repositories/application_repository.dart';
import '../../core/errors/failures.dart';

class GetApplicationsUseCase {
  final ApplicationRepository repository;

  GetApplicationsUseCase(this.repository);

  Future<Either<Failure, List<Application>>> call() {
    return repository.getApplications();
  }
}

class GetApplicationUseCase {
  final ApplicationRepository repository;

  GetApplicationUseCase(this.repository);

  Future<Either<Failure, Application>> call(String id) {
    return repository.getApplication(id);
  }
}

class CreateApplicationUseCase {
  final ApplicationRepository repository;

  CreateApplicationUseCase(this.repository);

  Future<Either<Failure, Application>> call({required String programId}) {
    return repository.createApplication(programId: programId);
  }
}

class UpdateApplicationStatusUseCase {
  final ApplicationRepository repository;

  UpdateApplicationStatusUseCase(this.repository);

  Future<Either<Failure, Application>> call({
    required String id,
    required ApplicationStatus status,
  }) {
    return repository.updateApplicationStatus(id: id, status: status);
  }
}

class UploadApplicationDocumentUseCase {
  final ApplicationRepository repository;

  UploadApplicationDocumentUseCase(this.repository);

  Future<Either<Failure, ApplicationDocument>> call({
    required String applicationId,
    required String documentId,
    required String filePath,
  }) {
    return repository.uploadDocument(
      applicationId: applicationId,
      documentId: documentId,
      filePath: filePath,
    );
  }
}

class CompleteApplicationTaskUseCase {
  final ApplicationRepository repository;

  CompleteApplicationTaskUseCase(this.repository);

  Future<Either<Failure, ApplicationTask>> call({
    required String applicationId,
    required String taskId,
  }) {
    return repository.completeTask(
      applicationId: applicationId,
      taskId: taskId,
    );
  }
}
