import '../../domain/entities/application.dart';

class ApplicationModel extends Application {
  ApplicationModel({
    required String id,
    required String programId,
    required String programName,
    required String universityId,
    required String universityName,
    required ApplicationStatus status,
    required DateTime submissionDate,
    required List<ApplicationDocument> documents,
    required List<ApplicationTimeline> timeline,
    required List<ApplicationTask> tasks,
  }) : super(
         id: id,
         programId: programId,
         programName: programName,
         universityId: universityId,
         universityName: universityName,
         status: status,
         submissionDate: submissionDate,
         documents: documents,
         timeline: timeline,
         tasks: tasks,
       );

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      id: json['id'],
      programId: json['program_id'],
      programName: json['program_name'],
      universityId: json['university_id'],
      universityName: json['university_name'],
      status: _parseApplicationStatus(json['status']),
      submissionDate: DateTime.parse(json['submission_date']),
      documents:
          json['documents'] != null
              ? List<ApplicationDocument>.from(
                json['documents'].map(
                  (doc) => ApplicationDocumentModel.fromJson(doc),
                ),
              )
              : [],
      timeline:
          json['timeline'] != null
              ? List<ApplicationTimeline>.from(
                json['timeline'].map(
                  (event) => ApplicationTimelineModel.fromJson(event),
                ),
              )
              : [],
      tasks:
          json['tasks'] != null
              ? List<ApplicationTask>.from(
                json['tasks'].map(
                  (task) => ApplicationTaskModel.fromJson(task),
                ),
              )
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'program_id': programId,
      'program_name': programName,
      'university_id': universityId,
      'university_name': universityName,
      'status': _applicationStatusToString(status),
      'submission_date': submissionDate.toIso8601String(),
      'documents':
          documents
              .map(
                (doc) =>
                    doc is ApplicationDocumentModel
                        ? doc.toJson()
                        : ApplicationDocumentModel.fromEntity(doc).toJson(),
              )
              .toList(),
      'timeline':
          timeline
              .map(
                (event) =>
                    event is ApplicationTimelineModel
                        ? event.toJson()
                        : ApplicationTimelineModel.fromEntity(event).toJson(),
              )
              .toList(),
      'tasks':
          tasks
              .map(
                (task) =>
                    task is ApplicationTaskModel
                        ? task.toJson()
                        : ApplicationTaskModel.fromEntity(task).toJson(),
              )
              .toList(),
    };
  }

  factory ApplicationModel.fromEntity(Application application) {
    return ApplicationModel(
      id: application.id,
      programId: application.programId,
      programName: application.programName,
      universityId: application.universityId,
      universityName: application.universityName,
      status: application.status,
      submissionDate: application.submissionDate,
      documents: application.documents,
      timeline: application.timeline,
      tasks: application.tasks,
    );
  }

  static ApplicationStatus _parseApplicationStatus(String? status) {
    switch (status?.toLowerCase()) {
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

  static String _applicationStatusToString(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.draft:
        return 'draft';
      case ApplicationStatus.submitted:
        return 'submitted';
      case ApplicationStatus.underReview:
        return 'under_review';
      case ApplicationStatus.documentRequired:
        return 'document_required';
      case ApplicationStatus.interviewScheduled:
        return 'interview_scheduled';
      case ApplicationStatus.accepted:
        return 'accepted';
      case ApplicationStatus.rejected:
        return 'rejected';
      default:
        return 'submitted';
    }
  }
}

class ApplicationDocumentModel extends ApplicationDocument {
  ApplicationDocumentModel({
    required String id,
    required String name,
    required DocumentStatus status,
    String? fileUrl,
    DateTime? submissionDate,
  }) : super(
         id: id,
         name: name,
         status: status,
         fileUrl: fileUrl,
         submissionDate: submissionDate,
       );

  factory ApplicationDocumentModel.fromJson(Map<String, dynamic> json) {
    return ApplicationDocumentModel(
      id: json['id'],
      name: json['name'],
      status: _parseDocumentStatus(json['status']),
      fileUrl: json['file_url'],
      submissionDate:
          json['submission_date'] != null
              ? DateTime.parse(json['submission_date'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': _documentStatusToString(status),
      'file_url': fileUrl,
      'submission_date': submissionDate?.toIso8601String(),
    };
  }

  factory ApplicationDocumentModel.fromEntity(ApplicationDocument document) {
    return ApplicationDocumentModel(
      id: document.id,
      name: document.name,
      status: document.status,
      fileUrl: document.fileUrl,
      submissionDate: document.submissionDate,
    );
  }

  static DocumentStatus _parseDocumentStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'required':
        return DocumentStatus.required;
      case 'submitted':
        return DocumentStatus.submitted;
      case 'verified':
        return DocumentStatus.verified;
      case 'rejected':
        return DocumentStatus.rejected;
      default:
        return DocumentStatus.required;
    }
  }

  static String _documentStatusToString(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.required:
        return 'required';
      case DocumentStatus.submitted:
        return 'submitted';
      case DocumentStatus.verified:
        return 'verified';
      case DocumentStatus.rejected:
        return 'rejected';
      default:
        return 'required';
    }
  }
}

class ApplicationTimelineModel extends ApplicationTimeline {
  ApplicationTimelineModel({
    required ApplicationStatus status,
    required DateTime date,
    required String description,
  }) : super(status: status, date: date, description: description);

  factory ApplicationTimelineModel.fromJson(Map<String, dynamic> json) {
    return ApplicationTimelineModel(
      status: ApplicationModel._parseApplicationStatus(json['status']),
      date: DateTime.parse(json['date']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': ApplicationModel._applicationStatusToString(status),
      'date': date.toIso8601String(),
      'description': description,
    };
  }

  factory ApplicationTimelineModel.fromEntity(ApplicationTimeline timeline) {
    return ApplicationTimelineModel(
      status: timeline.status,
      date: timeline.date,
      description: timeline.description,
    );
  }
}

class ApplicationTaskModel extends ApplicationTask {
  ApplicationTaskModel({
    required String id,
    required String title,
    required String description,
    required DateTime dueDate,
    required bool isCompleted,
  }) : super(
         id: id,
         title: title,
         description: description,
         dueDate: dueDate,
         isCompleted: isCompleted,
       );

  factory ApplicationTaskModel.fromJson(Map<String, dynamic> json) {
    return ApplicationTaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['due_date']),
      isCompleted: json['is_completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'is_completed': isCompleted,
    };
  }

  factory ApplicationTaskModel.fromEntity(ApplicationTask task) {
    return ApplicationTaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      isCompleted: task.isCompleted,
    );
  }
}
