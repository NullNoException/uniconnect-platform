import '../../domain/datasources/university_data_source.dart';
import '../../domain/models/university.dart';
import '../../domain/models/university_list_item.dart';
import '../../domain/models/university_request.dart';
import '../../domain/repositories/university_repository.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final UniversityDataSource _dataSource;

  UniversityRepositoryImpl(this._dataSource);

  @override
  Future<List<UniversityListItem>> getUniversities({
    required int page,
    required int pageSize,
    String? searchQuery,
    String? sortBy,
    bool? sortDescending,
  }) {
    return _dataSource.getUniversities(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }

  @override
  Future<University> getUniversityById(String id) {
    return _dataSource.getUniversityById(id);
  }

  @override
  Future<University> createUniversity(UniversityRequest request) {
    return _dataSource.createUniversity(request);
  }

  @override
  Future<University> updateUniversity(String id, UniversityRequest request) {
    return _dataSource.updateUniversity(id, request);
  }

  @override
  Future<void> deleteUniversity(String id) {
    return _dataSource.deleteUniversity(id);
  }
}
