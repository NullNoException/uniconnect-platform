import 'package:dio/dio.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/api_client.dart';
import '../models/application_model.dart';
import 'application_remote_data_source.dart';

class ApplicationRemoteDataSourceImpl implements ApplicationRemoteDataSource {
  final ApiClient client;

  ApplicationRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ApplicationModel>> getApplications() async {
    try {
      final response = await client.get('/applications');
      return (response['applications'] as List)
          .map<ApplicationModel>((json) => ApplicationModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get applications',
      );
    }
  }

  @override
  Future<ApplicationModel> getApplication(String id) async {
    try {
      final response = await client.get('/applications/$id');
      return ApplicationModel.fromJson(response['application']);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get application',
      );
    }
  }

  @override
  Future<ApplicationModel> createApplication({
    required String programId,
  }) async {
    try {
      final response = await client.post(
        '/applications',
        data: {'programId': programId},
      );
      return ApplicationModel.fromJson(response['application']);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to create application',
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

      final response = await client.patch(
        '/applications/$id/status',
        data: {'status': validStatus},
      );
      return ApplicationModel.fromJson(response['application']);
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data?['message'] ??
            'Failed to update application status',
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

      final response = await client.post(
        '/applications/$applicationId/documents/$documentId',
        data: formData,
      );

      return response['document'];
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to upload document',
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
      final response = await client.patch(
        '/applications/$applicationId/tasks/$taskId/complete',
      );
      return response['task'];
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to complete task',
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
