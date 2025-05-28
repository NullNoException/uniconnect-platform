import 'package:dio/dio.dart';
import 'package:customer_app/core/errors/exceptions.dart';
import 'package:customer_app/core/network/api_client.dart';
import 'package:customer_app/data/models/application_model.dart';
import 'package:customer_app/data/datasources/application_remote_data_source.dart';

class ApplicationRemoteDataSourceImpl implements ApplicationRemoteDataSource {
  final ApiClient client;

  ApplicationRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ApplicationModel>> getApplications() async {
    try {
      final Map<String, dynamic> response = await client.get('/applications');
      return (response['applications'] as List<dynamic>)
          .map<ApplicationModel>(
            (json) => ApplicationModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      final dynamic responseData = e.response?.data;
      throw ServerException(
        message:
            responseData is Map
                ? (responseData['message'] as String?) ??
                    'Failed to get applications'
                : 'Failed to get applications',
      );
    }
  }

  @override
  Future<ApplicationModel> getApplication(String id) async {
    try {
      final Map<String, dynamic> response = await client.get(
        '/applications/$id',
      );
      return ApplicationModel.fromJson(
        response['application'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      final dynamic responseData = e.response?.data;
      final String errorMessage =
          responseData is Map
              ? (responseData['message'] as String?) ??
                  'Failed to get application'
              : 'Failed to get application';
      throw ServerException(message: errorMessage);
    }
  }

  @override
  Future<ApplicationModel> createApplication({
    required String programId,
  }) async {
    try {
      final Map<String, dynamic> response = await client.post(
        '/applications',
        data: {'programId': programId},
      );
      return ApplicationModel.fromJson(
        response['application'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      final Map<String, dynamic>? responseData =
          e.response?.data is Map<String, dynamic>
              ? e.response?.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: responseData?['message'] ?? 'Failed to create application',
      );
    }
  }

  @override
  Future<ApplicationModel> updateApplicationStatus({
    required String id,
    required String status,
  }) async {
    try {
      // Validate that the status string is valid
      final validStatus = _validateAndFormatStatusString(status);

      final Map<String, dynamic> response = await client.patch(
        '/applications/$id/status',
        data: {'status': validStatus},
      );
      return ApplicationModel.fromJson(
        response['application'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      final Map<String, dynamic>? responseData =
          e.response?.data is Map<String, dynamic>
              ? e.response?.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message:
            responseData?['message'] ?? 'Failed to update application status',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> uploadDocument({
    required String applicationId,
    required String documentId,
    required String filePath,
  }) async {
    try {
      // Create a FormData instance for file upload
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final Map<String, dynamic> response = await client.post(
        '/applications/$applicationId/documents/$documentId',
        data: formData,
      );

      return response['document'] as Map<String, dynamic>;
    } on DioException catch (e) {
      final Map<String, dynamic>? responseData =
          e.response?.data is Map<String, dynamic>
              ? e.response?.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: responseData?['message'] ?? 'Failed to upload document',
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to upload document: ${e.toString()}',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> completeTask({
    required String applicationId,
    required String taskId,
  }) async {
    try {
      final Map<String, dynamic> response = await client.patch(
        '/applications/$applicationId/tasks/$taskId/complete',
      );
      return response['task'] as Map<String, dynamic>;
    } on DioException catch (e) {
      final Map<String, dynamic>? responseData =
          e.response?.data is Map<String, dynamic>
              ? e.response?.data as Map<String, dynamic>
              : null;
      throw ServerException(
        message: responseData?['message'] ?? 'Failed to complete task',
      );
    }
  }

  // Helper method to validate and format status string
  String _validateAndFormatStatusString(String status) {
    final validStatuses = [
      'draft',
      'submitted',
      'under_review',
      'document_required',
      'interview_scheduled',
      'accepted',
      'rejected',
    ];

    final normalized = status.toLowerCase().trim().replaceAll(' ', '_');
    if (!validStatuses.contains(normalized)) {
      throw ServerException(message: 'Invalid application status: $status');
    }

    return normalized;
  }
}
