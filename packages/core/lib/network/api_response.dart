class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final ApiErrorDetails? error;
  final DateTime? timestamp;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
    this.timestamp,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic raw)? fromData,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      data: json['data'] != null && fromData != null
          ? fromData(json['data'])
          : null,
      message: json['message'] as String?,
      error: json['error'] != null
          ? ApiErrorDetails.fromJson(json['error'] as Map<String, dynamic>)
          : null,
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String)
          : null,
    );
  }
}

class ApiErrorDetails {
  final String? code;
  final String message;

  const ApiErrorDetails({
    this.code,
    required this.message,
  });

  factory ApiErrorDetails.fromJson(Map<String, dynamic> json) {
    return ApiErrorDetails(
      code: json['code'] as String?,
      message: json['message'] as String? ?? 'An unexpected error occurred',
    );
  }
}
