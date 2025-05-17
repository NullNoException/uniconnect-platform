import 'package:customer_app/data/models/university_model.dart';

abstract class UniversityRemoteDataSource {
  /// Get a list of universities with optional filters
  Future<List<UniversityModel>> getUniversities({
    String? query,
    String? country,
    int? limit,
    int? offset,
  });

  /// Get details of a specific university by ID
  Future<UniversityModel> getUniversity(String id);

  /// Get featured universities
  Future<List<UniversityModel>> getFeaturedUniversities();

  /// Get bookmarked universities for the current user
  Future<List<UniversityModel>> getBookmarkedUniversities();

  /// Toggle bookmark status for a university, returns whether it is now bookmarked
  Future<bool> toggleBookmark(String universityId);
}
