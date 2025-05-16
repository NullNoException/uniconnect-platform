import 'package:dartz/dartz.dart';
import '../entities/program.dart';
import '../repositories/program_repository.dart';
import '../../core/errors/failures.dart';

class GetProgramsUseCase {
  final ProgramRepository repository;

  GetProgramsUseCase(this.repository);

  Future<Either<Failure, List<Program>>> call({
    String? query,
    String? universityId,
    ProgramLevel? level,
    String? country,
    int? limit,
    int? offset,
  }) {
    return repository.getPrograms(
      query: query,
      universityId: universityId,
      level: level,
      country: country,
      limit: limit,
      offset: offset,
    );
  }
}

class GetProgramUseCase {
  final ProgramRepository repository;

  GetProgramUseCase(this.repository);

  Future<Either<Failure, Program>> call(String id) {
    return repository.getProgram(id);
  }
}

class GetProgramsByUniversityUseCase {
  final ProgramRepository repository;

  GetProgramsByUniversityUseCase(this.repository);

  Future<Either<Failure, List<Program>>> call(String universityId) {
    return repository.getProgramsByUniversity(universityId);
  }
}

class GetFeaturedProgramsUseCase {
  final ProgramRepository repository;

  GetFeaturedProgramsUseCase(this.repository);

  Future<Either<Failure, List<Program>>> call() {
    return repository.getFeaturedPrograms();
  }
}

class GetBookmarkedProgramsUseCase {
  final ProgramRepository repository;

  GetBookmarkedProgramsUseCase(this.repository);

  Future<Either<Failure, List<Program>>> call() {
    return repository.getBookmarkedPrograms();
  }
}

class ToggleProgramBookmarkUseCase {
  final ProgramRepository repository;

  ToggleProgramBookmarkUseCase(this.repository);

  Future<Either<Failure, bool>> call(String programId) {
    return repository.toggleBookmark(programId);
  }
}
