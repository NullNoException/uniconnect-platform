import 'package:customer_app/core/network/api_client.dart';
import 'package:customer_app/data/models/university_model.dart';
import 'package:customer_app/data/datasources/university_remote_data_source.dart';

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

      final Map<String, dynamic> response = await apiClient.get(
        '/universities',
        queryParameters: queryParams,
      );

      return (response['data'] as List<dynamic>)
          .map((json) => UniversityModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<UniversityModel> getUniversity(String id) async {
    try {
      final Map<String, dynamic> response = await apiClient.get(
        '/universities/$id',
      );
      return UniversityModel.fromJson(response['data'] as Map<String, dynamic>);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<UniversityModel>> getFeaturedUniversities() async {
    try {
      final Map<String, dynamic> response = await apiClient.get(
        '/universities/featured',
      );
      return (response['data'] as List<dynamic>)
          .map((json) => UniversityModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<UniversityModel>> getBookmarkedUniversities() async {
    try {
      final Map<String, dynamic> response = await apiClient.get(
        '/bookmarks/universities',
      );
      return (response['data'] as List<dynamic>)
          .map((json) => UniversityModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> toggleBookmark(String universityId) async {
    try {
      final Map<String, dynamic> response = await apiClient.post(
        '/bookmarks/universities',
        data: {'university_id': universityId},
      );
      return response['bookmarked'] as bool;
    } on Exception {
      rethrow;
    }
  }
}
