class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final Map<String, dynamic>? errors;

  ApiResponse({required this.success, this.message, this.data, this.errors});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse<T>(
      success: json['success'] ?? true,
      message: json['message'],
      data: json['data'],
      errors: json['errors'],
    );
  }

  factory ApiResponse.success(T data, {String? message}) {
    return ApiResponse<T>(success: true, data: data, message: message);
  }

  factory ApiResponse.error(String message, {Map<String, dynamic>? errors}) {
    return ApiResponse<T>(success: false, message: message, errors: errors);
  }
}
