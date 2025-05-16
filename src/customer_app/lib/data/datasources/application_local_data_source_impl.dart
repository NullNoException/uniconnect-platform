import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../core/errors/exceptions.dart';
import '../../domain/entities/application.dart';
import '../models/application_model.dart';
import 'application_local_data_source.dart';

const CACHED_APPLICATIONS = 'CACHED_APPLICATIONS';

class ApplicationLocalDataSourceImpl implements ApplicationLocalDataSource {
  final SharedPreferences sharedPreferences;

  ApplicationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ApplicationModel>> getApplications() async {
    final jsonString = sharedPreferences.getString(CACHED_APPLICATIONS);
    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => ApplicationModel.fromJson(json)).toList();
      } catch (e) {
        throw CacheException(message: 'Failed to parse cached applications');
      }
    } else {
      return [];
    }
  }

  @override
  Future<ApplicationModel?> getApplication(String id) async {
    final applications = await getApplications();
    try {
      return applications.firstWhere((app) => app.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheApplications(List<ApplicationModel> applications) async {
    final jsonList = applications.map((app) => app.toJson()).toList();
    await sharedPreferences.setString(
      CACHED_APPLICATIONS,
      json.encode(jsonList),
    );
  }

  @override
  Future<void> cacheApplication(ApplicationModel application) async {
    final applications = await getApplications();

    // Remove the application if it exists
    final updatedApps =
        applications.where((app) => app.id != application.id).toList();

    // Add the new or updated application
    updatedApps.add(application);

    await cacheApplications(updatedApps);
  }

  @override
  Future<void> updateApplicationStatus({
    required String id,
    required String status,
  }) async {
    final applications = await getApplications();
    final index = applications.indexWhere((app) => app.id == id);

    if (index == -1) {
      throw CacheException(message: 'Application not found in cache');
    }

    final ApplicationStatus appStatus = _mapApplicationStatusFromString(status);
    final updatedApp = applications[index].copyWith(status: appStatus);

    // Add new timeline item
    final timeline = List<ApplicationTimeline>.from(
      applications[index].timeline,
    );
    timeline.add(
      ApplicationTimelineModel(
        status: appStatus,
        date: DateTime.now(),
        description: 'Application status updated to ${updatedApp.statusText}.',
      ),
    );

    final finalApp =
        updatedApp.copyWith(timeline: timeline) as ApplicationModel;

    applications[index] = finalApp;
    await cacheApplications(applications);
  }

  @override
  Future<void> updateDocumentStatus({
    required String applicationId,
    required String documentId,
    required String status,
    required String? fileUrl,
  }) async {
    final applications = await getApplications();
    final appIndex = applications.indexWhere((app) => app.id == applicationId);

    if (appIndex == -1) {
      throw CacheException(message: 'Application not found in cache');
    }

    final app = applications[appIndex];
    final documents = List<ApplicationDocument>.from(app.documents);
    final documentIndex = documents.indexWhere((doc) => doc.id == documentId);

    if (documentIndex == -1) {
      throw CacheException(message: 'Document not found in application');
    }

    final DocumentStatus docStatus = _mapDocumentStatusFromString(status);
    final oldDocument = documents[documentIndex];
    documents[documentIndex] = ApplicationDocumentModel(
      id: oldDocument.id,
      name: oldDocument.name,
      status: docStatus,
      fileUrl: fileUrl ?? oldDocument.fileUrl,
      submissionDate:
          docStatus == DocumentStatus.submitted
              ? DateTime.now()
              : oldDocument.submissionDate,
    );

    final updatedApp = app.copyWith(documents: documents) as ApplicationModel;
    applications[appIndex] = updatedApp;
    await cacheApplications(applications);
  }

  @override
  Future<void> updateTaskStatus({
    required String applicationId,
    required String taskId,
    required bool isCompleted,
  }) async {
    final applications = await getApplications();
    final appIndex = applications.indexWhere((app) => app.id == applicationId);

    if (appIndex == -1) {
      throw CacheException(message: 'Application not found in cache');
    }

    final app = applications[appIndex];
    final tasks = List<ApplicationTask>.from(app.tasks);
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);

    if (taskIndex == -1) {
      throw CacheException(message: 'Task not found in application');
    }

    final oldTask = tasks[taskIndex];
    tasks[taskIndex] = ApplicationTaskModel(
      id: oldTask.id,
      title: oldTask.title,
      description: oldTask.description,
      dueDate: oldTask.dueDate,
      isCompleted: isCompleted,
    );

    final updatedApp = app.copyWith(tasks: tasks) as ApplicationModel;
    applications[appIndex] = updatedApp;
    await cacheApplications(applications);
  } // Helper method to map document status string to enum

  DocumentStatus _mapDocumentStatusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'required':
        return DocumentStatus.required;
      case 'submitted':
        return DocumentStatus.submitted;
      case 'verified':
        return DocumentStatus.verified;
      case 'rejected':
        return DocumentStatus.rejected;
      case _:
        return DocumentStatus.required;
    }
  }

  // Helper method to map application status string to enum
  ApplicationStatus _mapApplicationStatusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
        return ApplicationStatus.draft;
      case 'submitted':
        return ApplicationStatus.submitted;
      case 'under_review':
      case 'under review':
        return ApplicationStatus.underReview;
      case 'document_required':
      case 'document required':
        return ApplicationStatus.documentRequired;
      case 'interview_scheduled':
      case 'interview scheduled':
        return ApplicationStatus.interviewScheduled;
      case 'accepted':
        return ApplicationStatus.accepted;
      case 'rejected':
        return ApplicationStatus.rejected;
      case _:
        return ApplicationStatus.submitted;
    }
  }
}
