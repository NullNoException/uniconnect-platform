import 'package:dartz/dartz.dart';
import '../../domain/entities/university.dart';
import '../../domain/repositories/university_repository.dart';
import '../errors/failures.dart';

class MockUniversityRepository implements UniversityRepository {
  final List<University> _universities = [
    University(
      id: 'uni1',
      name: 'Tech University',
      country: 'USA',
      city: 'San Francisco',
      logoUrl: null,
      coverImageUrl: null,
      foundedYear: 1960,
      description: 'A leading tech university.',
      ranking: {'world': 100, 'national': 10},
      facilities: ['Library', 'Labs'],
      websiteUrl: 'https://techuniversity.edu',
      contactEmail: 'info@techuniversity.edu',
      contactPhone: '+1 555-1234',
    ),
    University(
      id: 'uni2',
      name: 'Business School',
      country: 'UK',
      city: 'London',
      logoUrl: null,
      coverImageUrl: null,
      foundedYear: 1975,
      description: 'Top business school in the UK.',
      ranking: {'world': 200, 'national': 15},
      facilities: ['Auditorium', 'Cafeteria'],
      websiteUrl: 'https://businessschool.ac.uk',
      contactEmail: 'contact@businessschool.ac.uk',
      contactPhone: '+44 20 1234 5678',
    ),
  ];

  final Set<String> _bookmarked = {};

  @override
  Future<Either<Failure, List<University>>> getUniversities({
    String? query,
    String? country,
    int? limit,
    int? offset,
  }) async {
    var results = _universities;
    if (query != null && query.isNotEmpty) {
      results =
          results
              .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
    if (country != null && country.isNotEmpty) {
      results = results.where((u) => u.country == country).toList();
    }
    if (offset != null && offset > 0) {
      results = results.skip(offset).toList();
    }
    if (limit != null && limit > 0) {
      results = results.take(limit).toList();
    }
    return Right(results);
  }

  @override
  Future<Either<Failure, University>> getUniversity(String id) async {
    final university = _universities.firstWhere(
      (u) => u.id == id,
      orElse: () => throw Exception('Not found'),
    );
    return Right(university);
  }

  @override
  Future<Either<Failure, List<University>>> getFeaturedUniversities() async {
    // Just return all for mock
    return Right(_universities);
  }

  @override
  Future<Either<Failure, List<University>>> getBookmarkedUniversities() async {
    final results =
        _universities.where((u) => _bookmarked.contains(u.id)).toList();
    return Right(results);
  }

  @override
  Future<Either<Failure, bool>> toggleBookmark(String universityId) async {
    if (_bookmarked.contains(universityId)) {
      _bookmarked.remove(universityId);
      return Right(false);
    } else {
      _bookmarked.add(universityId);
      return Right(true);
    }
  }
}
