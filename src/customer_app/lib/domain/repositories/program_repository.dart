import 'package:dartz/dartz.dart';
import '../entities/program.dart';
import '../../core/errors/failures.dart';

abstract class ProgramRepository {
  /// Get a list of programs with optional filters
  Future<Either<Failure, List<Program>>> getPrograms({
    String? query,
    String? universityId,
    ProgramLevel? level,
    String? country,
    int? limit,
    int? offset,
  });

  /// Get details of a specific program by ID
  Future<Either<Failure, Program>> getProgram(String id);

  /// Get programs offered by a specific university
  Future<Either<Failure, List<Program>>> getProgramsByUniversity(
    String universityId,
  );

  /// Get featured programs
  Future<Either<Failure, List<Program>>> getFeaturedPrograms();

  /// Get bookmarked programs for the current user
  Future<Either<Failure, List<Program>>> getBookmarkedPrograms();

  /// Toggle bookmark status for a program
  Future<Either<Failure, bool>> toggleBookmark(String programId);
}
