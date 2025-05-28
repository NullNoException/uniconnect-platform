import '../models/university.dart';
import '../models/university_list_item.dart';
import '../models/university_request.dart';

abstract class UniversityDataSource {
  Future<List<UniversityListItem>> getUniversities({
    required int page,
    required int pageSize,
    String? searchQuery,
    String? sortBy,
    bool? sortDescending,
  });

  Future<University> getUniversityById(String id);

  Future<University> createUniversity(UniversityRequest request);

  Future<University> updateUniversity(String id, UniversityRequest request);

  Future<void> deleteUniversity(String id);
}
