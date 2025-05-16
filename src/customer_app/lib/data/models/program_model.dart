import 'package:customer_app/domain/entities/program.dart';

class ProgramModel extends Program {
  ProgramModel({
    required super.id,
    required super.name,
    required super.universityId,
    super.universityName,
    required super.level,
    required super.studyMode,
    required super.durationMonths,
    required super.language,
    super.tuitionFee,
    super.currency,
    super.description,
    super.applicationDeadline,
    super.startDate,
    super.requirements,
    super.curriculum,
    super.careerOpportunities,
    super.applicationFee,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'],
      name: json['name'],
      universityId: json['university_id'],
      universityName: json['university_name'],
      level: _parseProgramLevel(json['level']),
      studyMode: _parseStudyMode(json['study_mode']),
      durationMonths: json['duration_months'],
      language: json['language'],
      tuitionFee:
          (json['tuition_fee'] is num)
              ? (json['tuition_fee'] as num).toDouble()
              : null,
      currency: json['currency'],
      description: json['description'],
      applicationDeadline:
          json['application_deadline'] != null
              ? DateTime.parse(json['application_deadline'])
              : null,
      startDate:
          json['start_date'] != null
              ? DateTime.parse(json['start_date'])
              : null,
      requirements:
          json['requirements'] != null
              ? List<String>.from(json['requirements'])
              : null,
      curriculum:
          json['curriculum'] != null
              ? List<Map<String, dynamic>>.from(
                (json['curriculum'] as List<dynamic>).map(
                  (item) =>
                      Map<String, dynamic>.from(item as Map<dynamic, dynamic>),
                ),
              )
              : null,
      careerOpportunities:
          json['career_opportunities'] != null
              ? List<String>.from(json['career_opportunities'])
              : null,
      applicationFee:
          (json['application_fee'] is num)
              ? (json['application_fee'] as num).toDouble()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'university_id': universityId,
      'university_name': universityName,
      'level': _programLevelToString(level),
      'study_mode': _studyModeToString(studyMode),
      'duration_months': durationMonths,
      'language': language,
      'tuition_fee': tuitionFee,
      'currency': currency,
      'description': description,
      'application_deadline': applicationDeadline?.toIso8601String(),
      'start_date': startDate?.toIso8601String(),
      'requirements': requirements,
      'curriculum': curriculum,
      'career_opportunities': careerOpportunities,
      'application_fee': applicationFee,
    };
  }

  factory ProgramModel.fromEntity(Program program) {
    return ProgramModel(
      id: program.id,
      name: program.name,
      universityId: program.universityId,
      universityName: program.universityName,
      level: program.level,
      studyMode: program.studyMode,
      durationMonths: program.durationMonths,
      language: program.language,
      tuitionFee: program.tuitionFee,
      currency: program.currency,
      description: program.description,
      applicationDeadline: program.applicationDeadline,
      startDate: program.startDate,
      requirements: program.requirements,
      curriculum: program.curriculum,
      careerOpportunities: program.careerOpportunities,
      applicationFee: program.applicationFee,
    );
  }

  static ProgramLevel _parseProgramLevel(String? level) {
    switch (level?.toLowerCase()) {
      case 'certificate':
        return ProgramLevel.certificate;
      case 'diploma':
        return ProgramLevel.diploma;
      case 'associate':
        return ProgramLevel.associate;
      case 'bachelor':
        return ProgramLevel.bachelor;
      case 'master':
        return ProgramLevel.master;
      case 'doctoral':
        return ProgramLevel.doctoral;
      case 'postdoctoral':
        return ProgramLevel.postDoctoral;
      default:
        return ProgramLevel.bachelor;
    }
  }

  static String _programLevelToString(ProgramLevel level) {
    const levelMap = {
      ProgramLevel.certificate: 'certificate',
      ProgramLevel.diploma: 'diploma',
      ProgramLevel.associate: 'associate',
      ProgramLevel.bachelor: 'bachelor',
      ProgramLevel.master: 'master',
      ProgramLevel.doctoral: 'doctoral',
      ProgramLevel.postDoctoral: 'postdoctoral',
    };
    return levelMap[level] ?? 'bachelor';
  }

  static StudyMode _parseStudyMode(String? mode) {
    final modeMap = {
      'full-time': StudyMode.fullTime,
      'fulltime': StudyMode.fullTime,
      'part-time': StudyMode.partTime,
      'parttime': StudyMode.partTime,
      'online': StudyMode.online,
      'blended': StudyMode.blended,
    };
    return modeMap[mode?.toLowerCase()] ?? StudyMode.fullTime;
  }

  static String _studyModeToString(StudyMode mode) {
    const modeMap = {
      StudyMode.fullTime: 'full-time',
      StudyMode.partTime: 'part-time',
      StudyMode.online: 'online',
      StudyMode.blended: 'blended',
    };
    return modeMap[mode] ?? 'full-time';
  }
}
