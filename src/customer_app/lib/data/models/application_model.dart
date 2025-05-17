import 'package:customer_app/domain/entities/application.dart';

class ApplicationModel extends Application {
  ApplicationModel({
    required super.id,
    required super.programId,
    required super.programName,
    required super.universityId,
    required super.universityName,
    required super.status,
    required super.submissionDate,
    required super.documents,
    required super.timeline,
    required super.tasks,
  });

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
                (json['documents'] as List<dynamic>).map(
                  (doc) => ApplicationDocumentModel.fromJson(
                    doc as Map<String, dynamic>,
                  ),
                ),
              )
              : [],
      timeline:
          json['timeline'] != null
              ? List<ApplicationTimeline>.from(
                (json['timeline'] as List<dynamic>).map(
                  (event) => ApplicationTimelineModel.fromJson(
                    event as Map<String, dynamic>,
                  ),
                ),
              )
              : [],
      tasks:
          json['tasks'] != null
              ? List<ApplicationTask>.from(
                (json['tasks'] as List<dynamic>).map(
                  (task) => ApplicationTaskModel.fromJson(
                    task as Map<String, dynamic>,
                  ),
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
              .map<Map<String, dynamic>>(
                (doc) =>
                    doc is ApplicationDocumentModel
                        ? doc.toJson()
                        : ApplicationDocumentModel.fromEntity(doc).toJson(),
              )
              .toList(),
      'timeline':
          timeline
              .map<Map<String, dynamic>>(
                (event) =>
                    event is ApplicationTimelineModel
                        ? event.toJson()
                        : ApplicationTimelineModel.fromEntity(event).toJson(),
              )
              .toList(),
      'tasks':
          tasks
              .map<Map<String, dynamic>>(
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
    const statusMap = {
      ApplicationStatus.draft: 'draft',
      ApplicationStatus.submitted: 'submitted',
      ApplicationStatus.underReview: 'under_review',
      ApplicationStatus.documentRequired: 'document_required',
      ApplicationStatus.interviewScheduled: 'interview_scheduled',
      ApplicationStatus.accepted: 'accepted',
      ApplicationStatus.rejected: 'rejected',
    };
    return statusMap[status] ?? 'submitted';
  }
}

class ApplicationDocumentModel extends ApplicationDocument {
  ApplicationDocumentModel({
    required super.id,
    required super.name,
    required super.status,
    super.fileUrl,
    super.submissionDate,
  });

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
    final statusMap = {
      'required': DocumentStatus.required,
      'submitted': DocumentStatus.submitted,
      'verified': DocumentStatus.verified,
      'rejected': DocumentStatus.rejected,
    };
    final key = status?.toLowerCase();
    return statusMap.containsKey(key)
        ? statusMap[key]!
        : DocumentStatus.required;
  }

  static String _documentStatusToString(DocumentStatus status) {
    const statusMap = {
      DocumentStatus.required: 'required',
      DocumentStatus.submitted: 'submitted',
      DocumentStatus.verified: 'verified',
      DocumentStatus.rejected: 'rejected',
    };
    return statusMap[status] ?? 'required';
  }
}

class ApplicationTimelineModel extends ApplicationTimeline {
  ApplicationTimelineModel({
    required super.status,
    required super.date,
    required super.description,
  });

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
    required super.id,
    required super.title,
    required super.description,
    required super.dueDate,
    required super.isCompleted,
  });

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
