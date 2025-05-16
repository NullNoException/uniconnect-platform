enum ProgramLevel {
  certificate,
  diploma,
  associate,
  bachelor,
  master,
  doctoral,
  postDoctoral,
}

enum StudyMode { fullTime, partTime, online, blended }

class Program {
  final String id;
  final String name;
  final String universityId;
  final String? universityName;
  final ProgramLevel level;
  final StudyMode studyMode;
  final int durationMonths;
  final String language;
  final double? tuitionFee;
  final String? currency;
  final String? description;
  final DateTime? applicationDeadline;
  final DateTime? startDate;
  final List<String>? requirements;
  final List<Map<String, dynamic>>? curriculum;
  final List<String>? careerOpportunities;
  final double? applicationFee;

  Program({
    required this.id,
    required this.name,
    required this.universityId,
    this.universityName,
    required this.level,
    required this.studyMode,
    required this.durationMonths,
    required this.language,
    this.tuitionFee,
    this.currency,
    this.description,
    this.applicationDeadline,
    this.startDate,
    this.requirements,
    this.curriculum,
    this.careerOpportunities,
    this.applicationFee,
  });

  Program copyWith({
    String? id,
    String? name,
    String? universityId,
    String? universityName,
    ProgramLevel? level,
    StudyMode? studyMode,
    int? durationMonths,
    String? language,
    double? tuitionFee,
    String? currency,
    String? description,
    DateTime? applicationDeadline,
    DateTime? startDate,
    List<String>? requirements,
    List<Map<String, dynamic>>? curriculum,
    List<String>? careerOpportunities,
    double? applicationFee,
  }) {
    return Program(
      id: id ?? this.id,
      name: name ?? this.name,
      universityId: universityId ?? this.universityId,
      universityName: universityName ?? this.universityName,
      level: level ?? this.level,
      studyMode: studyMode ?? this.studyMode,
      durationMonths: durationMonths ?? this.durationMonths,
      language: language ?? this.language,
      tuitionFee: tuitionFee ?? this.tuitionFee,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
      startDate: startDate ?? this.startDate,
      requirements: requirements ?? this.requirements,
      curriculum: curriculum ?? this.curriculum,
      careerOpportunities: careerOpportunities ?? this.careerOpportunities,
      applicationFee: applicationFee ?? this.applicationFee,
    );
  }

  String get durationText {
    final years = durationMonths ~/ 12;
    final months = durationMonths % 12;

    if (years == 0) {
      return '$durationMonths months';
    } else if (months == 0) {
      return years == 1 ? '1 year' : '$years years';
    } else {
      return '$years ${years == 1 ? 'year' : 'years'} $months ${months == 1 ? 'month' : 'months'}';
    }
  }

  String get levelText {
    switch (level) {
      case ProgramLevel.certificate:
        return 'Certificate';
      case ProgramLevel.diploma:
        return 'Diploma';
      case ProgramLevel.associate:
        return 'Associate Degree';
      case ProgramLevel.bachelor:
        return 'Bachelor\'s Degree';
      case ProgramLevel.master:
        return 'Master\'s Degree';
      case ProgramLevel.doctoral:
        return 'Doctoral Degree';
      case ProgramLevel.postDoctoral:
        return 'Post-Doctoral';
      default:
        return 'Unknown';
    }
  }

  String get studyModeText {
    switch (studyMode) {
      case StudyMode.fullTime:
        return 'Full-time';
      case StudyMode.partTime:
        return 'Part-time';
      case StudyMode.online:
        return 'Online';
      case StudyMode.blended:
        return 'Blended Learning';
      default:
        return 'Unknown';
    }
  }

  String? get formattedTuitionFee {
    if (tuitionFee == null) return null;
    return '$currency${tuitionFee?.toStringAsFixed(2)}';
  }
}
