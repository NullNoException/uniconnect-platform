import 'package:dartz/dartz.dart';
import 'package:customer_app/core/errors/exceptions.dart';
import 'package:customer_app/core/errors/failures.dart';
import 'package:customer_app/core/network/network_info.dart';
import 'package:customer_app/domain/entities/application.dart';
import 'package:customer_app/domain/repositories/application_repository.dart';
import 'package:customer_app/data/datasources/application_remote_data_source.dart';
import 'package:customer_app/data/datasources/application_local_data_source.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDataSource remoteDataSource;
  final ApplicationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ApplicationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Application>>> getApplications() async {
    if (await networkInfo.isConnected()) {
      try {
        final remoteApplications = await remoteDataSource.getApplications();
        await localDataSource.cacheApplications(remoteApplications);
        return Right(remoteApplications);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      // Return cached data if offline
      try {
        final localApplications = await localDataSource.getApplications();
        return Right(localApplications);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Application>> getApplication(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final remoteApplication = await remoteDataSource.getApplication(id);
        await localDataSource.cacheApplication(remoteApplication);
        return Right(remoteApplication);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      // Return cached data if offline
      try {
        final localApplication = await localDataSource.getApplication(id);
        if (localApplication != null) {
          return Right(localApplication);
        } else {
          return Left(CacheFailure('Application not found in cache'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Application>> createApplication({
    required String programId,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        final application = await remoteDataSource.createApplication(
          programId: programId,
        );
        await localDataSource.cacheApplication(application);
        return Right(application);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Application>> updateApplicationStatus({
    required String id,
    required ApplicationStatus status,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        final application = await remoteDataSource.updateApplicationStatus(
          id: id,
          status: _mapApplicationStatusToString(status),
        );
        await localDataSource.cacheApplication(application);
        return Right(application);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ApplicationDocument>> uploadDocument({
    required String applicationId,
    required String documentId,
    required String filePath,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        final documentData = await remoteDataSource.uploadDocument(
          applicationId: applicationId,
          documentId: documentId,
          filePath: filePath,
        );

        // Update local cache with the new document status
        await localDataSource.updateDocumentStatus(
          applicationId: applicationId,
          documentId: documentId,
          status: documentData['status'],
          fileUrl: documentData['fileUrl'],
        );

        return Right(
          ApplicationDocument(
            id: documentId,
            name: documentData['name'],
            status: _mapDocumentStatusFromString(documentData['status']),
            fileUrl: documentData['fileUrl'],
            submissionDate:
                documentData['submissionDate'] != null
                    ? DateTime.parse(documentData['submissionDate'])
                    : DateTime.now(),
          ),
        );
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ApplicationTask>> completeTask({
    required String applicationId,
    required String taskId,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        final taskData = await remoteDataSource.completeTask(
          applicationId: applicationId,
          taskId: taskId,
        );

        // Update local cache with the new task status
        await localDataSource.updateTaskStatus(
          applicationId: applicationId,
          taskId: taskId,
          isCompleted: true,
        );

        return Right(
          ApplicationTask(
            id: taskId,
            title: taskData['title'],
            description: taskData['description'],
            dueDate: DateTime.parse(taskData['dueDate']),
            isCompleted: true,
          ),
        );
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  // Helper methods to map enum values to strings and back
  String _mapApplicationStatusToString(ApplicationStatus status) {
    final statusMap = {
      ApplicationStatus.draft: 'draft',
      ApplicationStatus.submitted: 'submitted',
      ApplicationStatus.underReview: 'under_review',
      ApplicationStatus.documentRequired: 'document_required',
      ApplicationStatus.interviewScheduled: 'interview_scheduled',
      ApplicationStatus.accepted: 'accepted',
      ApplicationStatus.rejected: 'rejected',
    };
    return statusMap[status] ?? 'draft';
  }

  DocumentStatus _mapDocumentStatusFromString(String status) {
    final statusMap = {
      'required': DocumentStatus.required,
      'submitted': DocumentStatus.submitted,
      'verified': DocumentStatus.verified,
      'rejected': DocumentStatus.rejected,
    };
    return statusMap[status.toLowerCase()] ?? DocumentStatus.required;
  }
}
