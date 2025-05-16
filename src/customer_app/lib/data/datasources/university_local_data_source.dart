import '../models/university_model.dart';

abstract class UniversityLocalDataSource {
  /// Get cached universities from last API call
  Future<List<UniversityModel>> getLastUniversities();

  /// Cache universities from API
  Future<void> cacheUniversities(List<UniversityModel> universities);

  /// Get university details by ID from cache
  Future<UniversityModel> getUniversity(String id);

  /// Cache university details
  Future<void> cacheUniversity(UniversityModel university);

  /// Get cached featured universities
  Future<List<UniversityModel>> getFeaturedUniversities();

  /// Cache featured universities
  Future<void> cacheFeaturedUniversities(List<UniversityModel> universities);

  /// Get bookmarked universities from local storage
  Future<List<UniversityModel>> getBookmarkedUniversities();

  /// Cache bookmarked universities
  Future<void> cacheBookmarkedUniversities(List<UniversityModel> universities);

  /// Add a university to bookmarks
  Future<void> addBookmarkedUniversity(UniversityModel university);

  /// Remove a university from bookmarks
  Future<void> removeBookmarkedUniversity(String universityId);
}
