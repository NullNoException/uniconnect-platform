enum ApplicationStatus {
  draft,
  submitted,
  underReview,
  documentRequired,
  interviewScheduled,
  accepted,
  rejected,
}

enum DocumentStatus { required, submitted, verified, rejected }

class Application {
  final String id;
  final String programId;
  final String programName;
  final String universityId;
  final String universityName;
  final ApplicationStatus status;
  final DateTime submissionDate;
  final List<ApplicationDocument> documents;
  final List<ApplicationTimeline> timeline;
  final List<ApplicationTask> tasks;

  Application({
    required this.id,
    required this.programId,
    required this.programName,
    required this.universityId,
    required this.universityName,
    required this.status,
    required this.submissionDate,
    required this.documents,
    required this.timeline,
    required this.tasks,
  });

  Application copyWith({
    String? id,
    String? programId,
    String? programName,
    String? universityId,
    String? universityName,
    ApplicationStatus? status,
    DateTime? submissionDate,
    List<ApplicationDocument>? documents,
    List<ApplicationTimeline>? timeline,
    List<ApplicationTask>? tasks,
  }) {
    return Application(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      programName: programName ?? this.programName,
      universityId: universityId ?? this.universityId,
      universityName: universityName ?? this.universityName,
      status: status ?? this.status,
      submissionDate: submissionDate ?? this.submissionDate,
      documents: documents ?? this.documents,
      timeline: timeline ?? this.timeline,
      tasks: tasks ?? this.tasks,
    );
  }

  static const Map<ApplicationStatus, String> _statusTextMap = {
    ApplicationStatus.draft: 'Draft',
    ApplicationStatus.submitted: 'Submitted',
    ApplicationStatus.underReview: 'Under Review',
    ApplicationStatus.documentRequired: 'Document Required',
    ApplicationStatus.interviewScheduled: 'Interview Scheduled',
    ApplicationStatus.accepted: 'Accepted',
    ApplicationStatus.rejected: 'Rejected',
  };

  String get statusText {
    return _statusTextMap[status] ?? 'Unknown';
  }

  int get completionPercentage {
    // Calculate application completion percentage based on required documents and tasks
    final int totalDocuments = documents.length;
    final int completedDocuments = documents
        .where((doc) => doc.status != DocumentStatus.required)
        .length;

    final int totalTasks = tasks.length;
    final int completedTasks = tasks.where((task) => task.isCompleted).length;

    if (totalDocuments == 0 && totalTasks == 0) return 100;
    if (totalDocuments == 0) return (completedTasks * 100 ~/ totalTasks);
    if (totalTasks == 0) return (completedDocuments * 100 ~/ totalDocuments);

    return ((completedDocuments + completedTasks) *
        100 ~/
        (totalDocuments + totalTasks));
  }
}

class ApplicationDocument {
  final String id;
  final String name;
  final DocumentStatus status;
  final String? fileUrl;
  final DateTime? submissionDate;

  ApplicationDocument({
    required this.id,
    required this.name,
    required this.status,
    this.fileUrl,
    this.submissionDate,
  });

  ApplicationDocument copyWith({
    String? id,
    String? name,
    DocumentStatus? status,
    String? fileUrl,
    DateTime? submissionDate,
  }) {
    return ApplicationDocument(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      fileUrl: fileUrl ?? this.fileUrl,
      submissionDate: submissionDate ?? this.submissionDate,
    );
  }

  static const Map<DocumentStatus, String> _statusTextMap = {
    DocumentStatus.required: 'Required',
    DocumentStatus.submitted: 'Submitted',
    DocumentStatus.verified: 'Verified',
    DocumentStatus.rejected: 'Rejected',
  };

  String get statusText {
    return _statusTextMap[status] ?? 'Unknown';
  }
}

class ApplicationTimeline {
  final ApplicationStatus status;
  final DateTime date;
  final String description;

  ApplicationTimeline({
    required this.status,
    required this.date,
    required this.description,
  });

  ApplicationTimeline copyWith({
    ApplicationStatus? status,
    DateTime? date,
    String? description,
  }) {
    return ApplicationTimeline(
      status: status ?? this.status,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  static const Map<ApplicationStatus, String> _statusTextMap = {
    ApplicationStatus.draft: 'Draft',
    ApplicationStatus.submitted: 'Submitted',
    ApplicationStatus.underReview: 'Under Review',
    ApplicationStatus.documentRequired: 'Document Required',
    ApplicationStatus.interviewScheduled: 'Interview Scheduled',
    ApplicationStatus.accepted: 'Accepted',
    ApplicationStatus.rejected: 'Rejected',
  };

  String get statusText {
    return _statusTextMap[status] ?? 'Unknown';
  }
}

class ApplicationTask {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  ApplicationTask({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
  });

  ApplicationTask copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return ApplicationTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  bool get isOverdue => !isCompleted && DateTime.now().isAfter(dueDate);

  int get daysLeft {
    if (isCompleted) return 0;

    final difference = dueDate.difference(DateTime.now()).inDays;
    return difference > 0 ? difference : 0;
  }
}
