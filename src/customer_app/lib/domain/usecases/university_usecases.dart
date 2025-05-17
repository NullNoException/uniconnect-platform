import 'package:dartz/dartz.dart';
import 'package:customer_app/domain/entities/university.dart';
import 'package:customer_app/domain/repositories/university_repository.dart';
import 'package:customer_app/core/errors/failures.dart';

class GetUniversitiesUseCase {
  final UniversityRepository repository;

  GetUniversitiesUseCase(this.repository);

  Future<Either<Failure, List<University>>> call({
    String? query,
    String? country,
    int? limit,
    int? offset,
  }) {
    return repository.getUniversities(
      query: query,
      country: country,
      limit: limit,
      offset: offset,
    );
  }
}

class GetUniversityUseCase {
  final UniversityRepository repository;

  GetUniversityUseCase(this.repository);

  Future<Either<Failure, University>> call(String id) {
    return repository.getUniversity(id);
  }
}

class GetFeaturedUniversitiesUseCase {
  final UniversityRepository repository;

  GetFeaturedUniversitiesUseCase(this.repository);

  Future<Either<Failure, List<University>>> call() {
    return repository.getFeaturedUniversities();
  }
}

class GetBookmarkedUniversitiesUseCase {
  final UniversityRepository repository;

  GetBookmarkedUniversitiesUseCase(this.repository);

  Future<Either<Failure, List<University>>> call() {
    return repository.getBookmarkedUniversities();
  }
}

class ToggleUniversityBookmarkUseCase {
  final UniversityRepository repository;

  ToggleUniversityBookmarkUseCase(this.repository);

  Future<Either<Failure, bool>> call(String universityId) {
    return repository.toggleBookmark(universityId);
  }
}
