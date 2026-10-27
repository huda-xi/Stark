import 'package:dio/dio.dart';

class ApiError implements Exception {
  final int? statusCode;
  final String message;
  final Map<String, List<String>> fieldErrors;
  final bool isNetworkError;

  const ApiError({
    this.statusCode,
    required this.message,
    this.fieldErrors = const {},
    this.isNetworkError = false,
  });

  bool get isUnauthorized => statusCode == 401;

  String? fieldError(String field) {
    final list = fieldErrors[field.toLowerCase()];
    return (list == null || list.isEmpty) ? null : list.first;
  }

  factory ApiError.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return ApiError(
          message: 'No internet connection',
          isNetworkError: true,
        );
      case DioExceptionType.badResponse:
        return ApiError._fromResponse(e.response);
      default:
        return ApiError(message: 'Something went wrong, please try again');
    }
  }

  factory ApiError._fromResponse(Response<dynamic>? response) {
    var message = 'Something went wrong, please try again';
    final fieldErrors = <String, List<String>>{};
    final data = response?.data;

    if (data is Map) {
      final text =
          data['message'] ?? data['detail'] ?? data['title'] ?? data['error'];

      if (text is String && text.trim().isNotEmpty) {
        message = text;
      }

      final errors = data['errors'];

      if (errors is Map) {
        errors.forEach((key, value) {
          final messages = value is List
              ? value.map((e) => e.toString()).toList()
              : value is String
              ? [value]
              : <String>[];

          if (messages.isNotEmpty) {
            fieldErrors[key.toString().toLowerCase()] = messages;
          }
        });

        if (message == 'Something went wrong, please try again' &&
            fieldErrors.isNotEmpty) {
          message = fieldErrors.values.first.first;
        }
      }
    } else if (data is String && data.trim().isNotEmpty) {
      message = data;
    }
    if (fieldErrors.isNotEmpty && message == 'One or more errors occurred!') {
      message = fieldErrors.values.first.first;
    }

    return ApiError(
      statusCode: response?.statusCode,
      message: message,
      fieldErrors: fieldErrors,
    );
  }
}
