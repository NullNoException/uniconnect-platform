import 'dart:async';
import 'dart:math';
import 'package:path/path.dart' as path;

import 'package:customer_app/core/errors/exceptions.dart';
import 'package:customer_app/domain/entities/application.dart';
import 'package:customer_app/data/models/application_model.dart';
import 'package:customer_app/data/datasources/application_remote_data_source.dart';
import 'package:customer_app/data/datasources/application_local_data_source.dart';

class MockApplicationRemoteDataSource implements ApplicationRemoteDataSource {
  // Mock storage for applications
  final Map<String, ApplicationModel> _applications = {};

  // Generate some mock applications for testing
  MockApplicationRemoteDataSource() {
    _initializeMockData();
  }

  void _initializeMockData() {
    // Sample applications for development and testing
    final now = DateTime.now();

    // Harvard University Application
    final harvardApp = ApplicationModel(
      id: '1',
      programId: '101',
      programName: 'Computer Science (MSc)',
      universityId: '1',
      universityName: 'Harvard University',
      status: ApplicationStatus.underReview,
      submissionDate: now.subtract(const Duration(days: 30)),
      documents: [
        ApplicationDocumentModel(
          id: '1',
          name: 'Academic Transcripts',
          status: DocumentStatus.verified,
          fileUrl: 'https://example.com/transcripts.pdf',
          submissionDate: now.subtract(const Duration(days: 28)),
        ),
        ApplicationDocumentModel(
          id: '2',
          name: 'Statement of Purpose',
          status: DocumentStatus.verified,
          fileUrl: 'https://example.com/sop.pdf',
          submissionDate: now.subtract(const Duration(days: 25)),
        ),
        ApplicationDocumentModel(
          id: '3',
          name: 'Recommendation Letters',
          status: DocumentStatus.submitted,
          fileUrl: 'https://example.com/recommendation.pdf',
          submissionDate: now.subtract(const Duration(days: 20)),
        ),
        ApplicationDocumentModel(
          id: '4',
          name: 'English Proficiency Test',
          status: DocumentStatus.submitted,
          fileUrl: 'https://example.com/toefl.pdf',
          submissionDate: now.subtract(const Duration(days: 15)),
        ),
      ],
      timeline: [
        ApplicationTimelineModel(
          status: ApplicationStatus.draft,
          date: now.subtract(const Duration(days: 35)),
          description: 'Application created',
        ),
        ApplicationTimelineModel(
          status: ApplicationStatus.submitted,
          date: now.subtract(const Duration(days: 30)),
          description: 'Application submitted',
        ),
        ApplicationTimelineModel(
          status: ApplicationStatus.underReview,
          date: now.subtract(const Duration(days: 10)),
          description: 'Application review started',
        ),
      ],
      tasks: [
        ApplicationTaskModel(
          id: '1',
          title: 'Complete Application Form',
          description: 'Fill out all required fields in the application form',
          dueDate: now.subtract(const Duration(days: 31)),
          isCompleted: true,
        ),
        ApplicationTaskModel(
          id: '2',
          title: 'Submit Academic Transcripts',
          description: 'Upload your official academic transcripts',
          dueDate: now.subtract(const Duration(days: 29)),
          isCompleted: true,
        ),
        ApplicationTaskModel(
          id: '3',
          title: 'Prepare for Interview',
          description: 'A video interview will be scheduled soon',
          dueDate: now.add(const Duration(days: 10)),
          isCompleted: false,
        ),
      ],
    );

    // MIT Application
    final mitApp = ApplicationModel(
      id: '2',
      programId: '201',
      programName: 'Electrical Engineering (PhD)',
      universityId: '2',
      universityName: 'Massachusetts Institute of Technology',
      status: ApplicationStatus.documentRequired,
      submissionDate: now.subtract(const Duration(days: 20)),
      documents: [
        ApplicationDocumentModel(
          id: '1',
          name: 'Academic Transcripts',
          status: DocumentStatus.verified,
          fileUrl: 'https://example.com/transcripts.pdf',
          submissionDate: now.subtract(const Duration(days: 18)),
        ),
        ApplicationDocumentModel(
          id: '2',
          name: 'Statement of Purpose',
          status: DocumentStatus.verified,
          fileUrl: 'https://example.com/sop.pdf',
          submissionDate: now.subtract(const Duration(days: 15)),
        ),
        ApplicationDocumentModel(
          id: '3',
          name: 'Research Proposal',
          status: DocumentStatus.required,
          fileUrl: null,
          submissionDate: null,
        ),
        ApplicationDocumentModel(
          id: '4',
          name: 'GRE Score Report',
          status: DocumentStatus.required,
          fileUrl: null,
          submissionDate: null,
        ),
      ],
      timeline: [
        ApplicationTimelineModel(
          status: ApplicationStatus.draft,
          date: now.subtract(const Duration(days: 25)),
          description: 'Application created',
        ),
        ApplicationTimelineModel(
          status: ApplicationStatus.submitted,
          date: now.subtract(const Duration(days: 20)),
          description: 'Application submitted',
        ),
        ApplicationTimelineModel(
          status: ApplicationStatus.documentRequired,
          date: now.subtract(const Duration(days: 5)),
          description: 'Additional documents requested',
        ),
      ],
      tasks: [
        ApplicationTaskModel(
          id: '1',
          title: 'Submit Research Proposal',
          description: 'Prepare and upload your research proposal',
          dueDate: now.add(const Duration(days: 5)),
          isCompleted: false,
        ),
        ApplicationTaskModel(
          id: '2',
          title: 'Submit GRE Score Report',
          description: 'Submit your official GRE score report',
          dueDate: now.add(const Duration(days: 7)),
          isCompleted: false,
        ),
      ],
    );

    // Add applications to mock database
    _applications[harvardApp.id] = harvardApp;
    _applications[mitApp.id] = mitApp;
  }

  @override
  Future<List<ApplicationModel>> getApplications() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _applications.values.toList();
  }

  @override
  Future<ApplicationModel> getApplication(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final application = _applications[id];
    if (application == null) {
      throw ServerException(message: 'Application not found');
    }

    return application;
  }

  @override
  Future<ApplicationModel> createApplication({
    required String programId,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Generate a new application with mock data
    final id = (_applications.length + 1).toString();
    final now = DateTime.now();

    // Use secure random for better security practices
    final secureRandom = Random.secure();

    // Fetch program and university info (in real app would be from API)
    final programName = 'Mock Program ${secureRandom.nextInt(100)}';
    final universityId = secureRandom.nextInt(10).toString();
    final universityName = 'Mock University ${secureRandom.nextInt(100)}';

    final newApplication = ApplicationModel(
      id: id,
      programId: programId,
      programName: programName,
      universityId: universityId,
      universityName: universityName,
      status: ApplicationStatus.draft,
      submissionDate: now,
      documents: [
        ApplicationDocumentModel(
          id: '1',
          name: 'Academic Transcripts',
          status: DocumentStatus.required,
          fileUrl: null,
          submissionDate: null,
        ),
        ApplicationDocumentModel(
          id: '2',
          name: 'Statement of Purpose',
          status: DocumentStatus.required,
          fileUrl: null,
          submissionDate: null,
        ),
        ApplicationDocumentModel(
          id: '3',
          name: 'CV/Resume',
          status: DocumentStatus.required,
          fileUrl: null,
          submissionDate: null,
        ),
      ],
      timeline: [
        ApplicationTimelineModel(
          status: ApplicationStatus.draft,
          date: now,
          description: 'Application created',
        ),
      ],
      tasks: [
        ApplicationTaskModel(
          id: '1',
          title: 'Complete Application Form',
          description: 'Fill out all required fields in the application form',
          dueDate: now.add(const Duration(days: 7)),
          isCompleted: false,
        ),
        ApplicationTaskModel(
          id: '2',
          title: 'Submit Academic Documents',
          description: 'Upload all required academic documents',
          dueDate: now.add(const Duration(days: 14)),
          isCompleted: false,
        ),
      ],
    );

    _applications[id] = newApplication;
    return newApplication;
  }

  @override
  Future<ApplicationModel> updateApplicationStatus({
    required String id,
    required String status,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 700));

    final application = _applications[id];
    if (application == null) {
      throw ServerException(message: 'Application not found');
    }

    final appStatus = _mapApplicationStatusFromString(status);

    // Create a new timeline entry
    final timeline = List<ApplicationTimeline>.from(application.timeline);
    timeline.add(
      ApplicationTimelineModel(
        status: appStatus,
        date: DateTime.now(),
        description:
            'Application status updated to ${_getStatusDescription(appStatus)}',
      ),
    );

    // Update the application
    final updatedApplication =
        application.copyWith(status: appStatus, timeline: timeline)
            as ApplicationModel;

    _applications[id] = updatedApplication;
    return updatedApplication;
  }

  String _getStatusDescription(ApplicationStatus status) {
    const statusDescriptions = {
      ApplicationStatus.draft: 'Draft',
      ApplicationStatus.submitted: 'Submitted',
      ApplicationStatus.underReview: 'Under Review',
      ApplicationStatus.documentRequired: 'Document Required',
      ApplicationStatus.interviewScheduled: 'Interview Scheduled',
      ApplicationStatus.accepted: 'Accepted',
      ApplicationStatus.rejected: 'Rejected',
    };
    return statusDescriptions[status] ?? 'Unknown';
  }

  @override
  Future<Map<String, dynamic>> uploadDocument({
    required String applicationId,
    required String documentId,
    required String filePath,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    final application = _applications[applicationId];
    if (application == null) {
      throw ServerException(message: 'Application not found');
    }

    // Find the document
    final documents = List<ApplicationDocument>.from(application.documents);
    final documentIndex = documents.indexWhere((doc) => doc.id == documentId);

    if (documentIndex == -1) {
      throw ServerException(message: 'Document not found');
    }

    // Get file name from path
    final fileName = path.basename(filePath);

    // Generate a mock URL for the document
    final mockFileUrl = 'https://example.com/uploads/$fileName';

    // Update the document status
    final oldDoc = documents[documentIndex];
    final updatedDoc = ApplicationDocumentModel(
      id: oldDoc.id,
      name: oldDoc.name,
      status: DocumentStatus.submitted,
      fileUrl: mockFileUrl,
      submissionDate: DateTime.now(),
    );

    documents[documentIndex] = updatedDoc;

    // Update the application
    final updatedApplication =
        application.copyWith(documents: documents) as ApplicationModel;
    _applications[applicationId] = updatedApplication;

    // Return the document data
    return {
      'id': updatedDoc.id,
      'name': updatedDoc.name,
      'status': 'submitted',
      'fileUrl': mockFileUrl,
      'submissionDate': updatedDoc.submissionDate!.toIso8601String(),
    };
  }

  @override
  Future<Map<String, dynamic>> completeTask({
    required String applicationId,
    required String taskId,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 700));

    final application = _applications[applicationId];
    if (application == null) {
      throw ServerException(message: 'Application not found');
    }

    // Find the task
    final tasks = List<ApplicationTask>.from(application.tasks);
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);

    if (taskIndex == -1) {
      throw ServerException(message: 'Task not found');
    }

    // Update the task status
    final oldTask = tasks[taskIndex];
    final updatedTask = ApplicationTaskModel(
      id: oldTask.id,
      title: oldTask.title,
      description: oldTask.description,
      dueDate: oldTask.dueDate,
      isCompleted: true,
    );

    tasks[taskIndex] = updatedTask;

    // Update the application
    final updatedApplication =
        application.copyWith(tasks: tasks) as ApplicationModel;
    _applications[applicationId] = updatedApplication;

    // Return the task data
    return {
      'id': updatedTask.id,
      'title': updatedTask.title,
      'description': updatedTask.description,
      'dueDate': updatedTask.dueDate.toIso8601String(),
      'isCompleted': true,
    };
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
      default:
        return ApplicationStatus.submitted;
    }
  }
}

class MockApplicationLocalDataSource implements ApplicationLocalDataSource {
  // Mock storage for cached applications
  final Map<String, ApplicationModel> _cachedApplications = {};

  // Constructor
  MockApplicationLocalDataSource() {
    _initializeMockData();
  }

  // Initialize mock data
  void _initializeMockData() {
    // We'll use the same mock data from the remote source for simplicity
    final mockRemote = MockApplicationRemoteDataSource();
    mockRemote.getApplications().then((applications) {
      for (var app in applications) {
        _cachedApplications[app.id] = app;
      }
    });
  }

  @override
  Future<List<ApplicationModel>> getApplications() async {
    return _cachedApplications.values.toList();
  }

  @override
  Future<ApplicationModel?> getApplication(String id) async {
    return _cachedApplications[id];
  }

  @override
  Future<void> cacheApplications(List<ApplicationModel> applications) async {
    _cachedApplications.clear();
    for (var app in applications) {
      _cachedApplications[app.id] = app;
    }
  }

  @override
  Future<void> cacheApplication(ApplicationModel application) async {
    _cachedApplications[application.id] = application;
  }

  @override
  Future<void> updateApplicationStatus({
    required String id,
    required String status,
  }) async {
    final app = _cachedApplications[id];
    if (app == null) {
      throw CacheException(message: 'Application not found in cache');
    }

    final appStatus = _mapApplicationStatusFromString(status);

    // Create a new timeline entry
    final timeline = List<ApplicationTimeline>.from(app.timeline);
    timeline.add(
      ApplicationTimelineModel(
        status: appStatus,
        date: DateTime.now(),
        description: 'Application status updated to ${app.statusText}',
      ),
    );

    // Update the application
    _cachedApplications[id] =
        app.copyWith(status: appStatus, timeline: timeline) as ApplicationModel;
  }

  @override
  Future<void> updateDocumentStatus({
    required String applicationId,
    required String documentId,
    required String status,
    required String? fileUrl,
  }) async {
    final app = _cachedApplications[applicationId];
    if (app == null) {
      throw CacheException(message: 'Application not found in cache');
    }

    final documents = List<ApplicationDocument>.from(app.documents);
    final documentIndex = documents.indexWhere((doc) => doc.id == documentId);

    if (documentIndex == -1) {
      throw CacheException(message: 'Document not found in application');
    }

    // Convert string status to enum using pattern matching
    final docStatus =
        {
          'required': DocumentStatus.required,
          'submitted': DocumentStatus.submitted,
          'verified': DocumentStatus.verified,
          'rejected': DocumentStatus.rejected,
        }[status.toLowerCase()] ??
        DocumentStatus.required;

    final oldDoc = documents[documentIndex];
    documents[documentIndex] = ApplicationDocumentModel(
      id: oldDoc.id,
      name: oldDoc.name,
      status: docStatus,
      fileUrl: fileUrl ?? oldDoc.fileUrl,
      submissionDate:
          docStatus == DocumentStatus.submitted
              ? DateTime.now()
              : oldDoc.submissionDate,
    );

    _cachedApplications[applicationId] =
        app.copyWith(documents: documents) as ApplicationModel;
  }

  @override
  Future<void> updateTaskStatus({
    required String applicationId,
    required String taskId,
    required bool isCompleted,
  }) async {
    final app = _cachedApplications[applicationId];
    if (app == null) {
      throw CacheException(message: 'Application not found in cache');
    }

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

    _cachedApplications[applicationId] =
        app.copyWith(tasks: tasks) as ApplicationModel;
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
      default:
        return ApplicationStatus.submitted;
    }
  }
}
