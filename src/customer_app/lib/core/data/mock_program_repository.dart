import 'package:dartz/dartz.dart';
import 'package:customer_app/domain/entities/program.dart';
import 'package:customer_app/domain/repositories/program_repository.dart';
import 'package:customer_app/core/errors/failures.dart';

class MockProgramRepository implements ProgramRepository {
  final List<Program> _programs = [
    Program(
      id: '1',
      name: 'Computer Science',
      universityId: 'uni1',
      universityName: 'Tech University',
      level: ProgramLevel.bachelor,
      studyMode: StudyMode.fullTime,
      durationMonths: 48,
      language: 'English',
      tuitionFee: 10000,
      currency: 'USD',
      description: 'A bachelor program in Computer Science.',
      applicationDeadline: DateTime.now().add(const Duration(days: 60)),
      startDate: DateTime.now().add(const Duration(days: 120)),
      requirements: ['High School Diploma'],
      curriculum: [],
      careerOpportunities: ['Software Engineer'],
      applicationFee: 50.0,
    ),
    Program(
      id: '2',
      name: 'Business Administration',
      universityId: 'uni2',
      universityName: 'Business School',
      level: ProgramLevel.master,
      studyMode: StudyMode.partTime,
      durationMonths: 24,
      language: 'English',
      tuitionFee: 15000,
      currency: 'USD',
      description: 'A master program in Business Administration.',
      applicationDeadline: DateTime.now().add(const Duration(days: 90)),
      startDate: DateTime.now().add(const Duration(days: 180)),
      requirements: ['Bachelor Degree'],
      curriculum: [],
      careerOpportunities: ['Manager'],
      applicationFee: 100.0,
    ),
  ];

  final Set<String> _bookmarked = {};

  @override
  Future<Either<Failure, List<Program>>> getPrograms({
    String? query,
    String? universityId,
    ProgramLevel? level,
    String? country,
    int? limit,
    int? offset,
  }) async {
    var results = _programs;
    if (query != null && query.isNotEmpty) {
      results = results
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (universityId != null && universityId.isNotEmpty) {
      results = results.where((p) => p.universityId == universityId).toList();
    }
    if (level != null) {
      results = results.where((p) => p.level == level).toList();
    }
    // country is not used in mock
    if (offset != null && offset > 0) {
      results = results.skip(offset).toList();
    }
    if (limit != null && limit > 0) {
      results = results.take(limit).toList();
    }
    return Right(results);
  }

  @override
  Future<Either<Failure, Program>> getProgram(String id) async {
    final program = _programs.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Not found'),
    );
    return Right(program);
  }

  @override
  Future<Either<Failure, List<Program>>> getProgramsByUniversity(
    String universityId,
  ) async {
    final results = _programs
        .where((p) => p.universityId == universityId)
        .toList();
    return Right(results);
  }

  @override
  Future<Either<Failure, List<Program>>> getFeaturedPrograms() async {
    // Just return all for mock
    return Right(_programs);
  }

  @override
  Future<Either<Failure, List<Program>>> getBookmarkedPrograms() async {
    final results = _programs.where((p) => _bookmarked.contains(p.id)).toList();
    return Right(results);
  }

  @override
  Future<Either<Failure, bool>> toggleBookmark(String programId) async {
    if (_bookmarked.contains(programId)) {
      _bookmarked.remove(programId);
      return Right(false);
    } else {
      _bookmarked.add(programId);
      return Right(true);
    }
  }
}
