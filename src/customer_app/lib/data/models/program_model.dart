import '../../domain/entities/program.dart';

class ProgramModel extends Program {
  ProgramModel({
    required String id,
    required String name,
    required String universityId,
    String? universityName,
    required ProgramLevel level,
    required StudyMode studyMode,
    required int durationMonths,
    required String language,
    double? tuitionFee,
    String? currency,
    String? description,
    DateTime? applicationDeadline,
    DateTime? startDate,
    List<String>? requirements,
    List<Map<String, dynamic>>? curriculum,
    List<String>? careerOpportunities,
    double? applicationFee,
  }) : super(
         id: id,
         name: name,
         universityId: universityId,
         universityName: universityName,
         level: level,
         studyMode: studyMode,
         durationMonths: durationMonths,
         language: language,
         tuitionFee: tuitionFee,
         currency: currency,
         description: description,
         applicationDeadline: applicationDeadline,
         startDate: startDate,
         requirements: requirements,
         curriculum: curriculum,
         careerOpportunities: careerOpportunities,
         applicationFee: applicationFee,
       );

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
          json['tuition_fee'] != null ? json['tuition_fee'].toDouble() : null,
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
                json['curriculum'].map(
                  (item) => Map<String, dynamic>.from(item),
                ),
              )
              : null,
      careerOpportunities:
          json['career_opportunities'] != null
              ? List<String>.from(json['career_opportunities'])
              : null,
      applicationFee:
          json['application_fee'] != null
              ? json['application_fee'].toDouble()
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
    switch (level) {
      case ProgramLevel.certificate:
        return 'certificate';
      case ProgramLevel.diploma:
        return 'diploma';
      case ProgramLevel.associate:
        return 'associate';
      case ProgramLevel.bachelor:
        return 'bachelor';
      case ProgramLevel.master:
        return 'master';
      case ProgramLevel.doctoral:
        return 'doctoral';
      case ProgramLevel.postDoctoral:
        return 'postdoctoral';
      default:
        return 'bachelor';
    }
  }

  static StudyMode _parseStudyMode(String? mode) {
    switch (mode?.toLowerCase()) {
      case 'full-time':
      case 'fulltime':
        return StudyMode.fullTime;
      case 'part-time':
      case 'parttime':
        return StudyMode.partTime;
      case 'online':
        return StudyMode.online;
      case 'blended':
        return StudyMode.blended;
      default:
        return StudyMode.fullTime;
    }
  }

  static String _studyModeToString(StudyMode mode) {
    switch (mode) {
      case StudyMode.fullTime:
        return 'full-time';
      case StudyMode.partTime:
        return 'part-time';
      case StudyMode.online:
        return 'online';
      case StudyMode.blended:
        return 'blended';
      default:
        return 'full-time';
    }
  }
}
