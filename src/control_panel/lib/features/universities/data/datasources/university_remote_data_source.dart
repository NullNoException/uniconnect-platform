import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/datasources/university_data_source.dart';
import '../../domain/models/university.dart';
import '../../domain/models/university_list_item.dart';
import '../../domain/models/university_request.dart';

class UniversityRemoteDataSource implements UniversityDataSource {
  final ApiClient _apiClient;

  UniversityRemoteDataSource(this._apiClient);

  @override
  Future<List<UniversityListItem>> getUniversities({
    required int page,
    required int pageSize,
    String? searchQuery,
    String? sortBy,
    bool? sortDescending,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        if (searchQuery != null && searchQuery.isNotEmpty)
          'search': searchQuery,
        if (sortBy != null && sortBy.isNotEmpty) 'sortBy': sortBy,
        if (sortDescending != null) 'sortDescending': sortDescending.toString(),
      };

      final response = await _apiClient.get(
        ApiEndpoints.universities,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data['data'];
      return data.map((item) => UniversityListItem.fromJson(item)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<University> getUniversityById(String id) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.universityById}$id',
      );
      return University.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<University> createUniversity(UniversityRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.universities,
        data: request.toJson(),
      );
      return University.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<University> updateUniversity(
    String id,
    UniversityRequest request,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.universityById}$id',
        data: request.toJson(),
      );
      return University.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<void> deleteUniversity(String id) async {
    try {
      await _apiClient.delete('${ApiEndpoints.universityById}$id');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
