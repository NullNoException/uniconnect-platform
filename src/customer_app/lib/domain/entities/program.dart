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
    const levelMap = {
      ProgramLevel.certificate: 'Certificate',
      ProgramLevel.diploma: 'Diploma',
      ProgramLevel.associate: 'Associate Degree',
      ProgramLevel.bachelor: 'Bachelor\'s Degree',
      ProgramLevel.master: 'Master\'s Degree',
      ProgramLevel.doctoral: 'Doctoral Degree',
      ProgramLevel.postDoctoral: 'Post-Doctoral',
    };
    return levelMap[level] ?? 'Unknown';
  }

  String get studyModeText {
    const modeMap = {
      StudyMode.fullTime: 'Full-time',
      StudyMode.partTime: 'Part-time',
      StudyMode.online: 'Online',
      StudyMode.blended: 'Blended Learning',
    };
    return modeMap[studyMode] ?? 'Unknown';
  }

  String? get formattedTuitionFee {
    if (tuitionFee == null) return null;
    return '$currency${tuitionFee?.toStringAsFixed(2)}';
  }
}
