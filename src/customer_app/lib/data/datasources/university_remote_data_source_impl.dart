import '../../core/network/api_client.dart';
import '../models/university_model.dart';
import 'university_remote_data_source.dart';

class UniversityRemoteDataSourceImpl implements UniversityRemoteDataSource {
  final ApiClient apiClient;

  UniversityRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<UniversityModel>> getUniversities({
    String? query,
    String? country,
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (query != null && query.isNotEmpty) {
        queryParams['query'] = query;
      }
      if (country != null && country.isNotEmpty) {
        queryParams['country'] = country;
      }
      if (limit != null) {
        queryParams['limit'] = limit.toString();
      }
      if (offset != null) {
        queryParams['offset'] = offset.toString();
      }

      final response = await apiClient.get(
        '/universities',
        queryParameters: queryParams,
      );

      return (response['data'] as List)
          .map((json) => UniversityModel.fromJson(json))
          .toList();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<UniversityModel> getUniversity(String id) async {
    try {
      final response = await apiClient.get('/universities/$id');
      return UniversityModel.fromJson(response['data']);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<UniversityModel>> getFeaturedUniversities() async {
    try {
      final response = await apiClient.get('/universities/featured');
      return (response['data'] as List)
          .map((json) => UniversityModel.fromJson(json))
          .toList();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<UniversityModel>> getBookmarkedUniversities() async {
    try {
      final response = await apiClient.get('/bookmarks/universities');
      return (response['data'] as List)
          .map((json) => UniversityModel.fromJson(json))
          .toList();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> toggleBookmark(String universityId) async {
    try {
      final response = await apiClient.post(
        '/bookmarks/universities',
        data: {'university_id': universityId},
      );
      return response['bookmarked'] as bool;
    } on Exception {
      rethrow;
    }
  }
}
