import 'package:dartz/dartz.dart';
import 'package:customer_app/domain/entities/university.dart';
import 'package:customer_app/core/errors/failures.dart';

abstract class UniversityRepository {
  /// Get a list of universities with optional filters
  Future<Either<Failure, List<University>>> getUniversities({
    String? query,
    String? country,
    int? limit,
    int? offset,
  });

  /// Get details of a specific university by ID
  Future<Either<Failure, University>> getUniversity(String id);

  /// Get featured universities
  Future<Either<Failure, List<University>>> getFeaturedUniversities();

  /// Get bookmarked universities for the current user
  Future<Either<Failure, List<University>>> getBookmarkedUniversities();

  /// Toggle bookmark status for a university
  Future<Either<Failure, bool>> toggleBookmark(String universityId);
}
