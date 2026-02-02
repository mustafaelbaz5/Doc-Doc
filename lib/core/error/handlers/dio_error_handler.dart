import 'package:dio/dio.dart';

import '../models/app_error.dart';
import '../models/error_details.dart';
import '../types/error_type.dart';

class DioErrorHandler {
  static AppError handle(final dynamic error) {
    if (error is DioException) {
      return _handleDioException(error);
    }
    return AppError.unknown(error.toString());
  }

  /// Handle Dio Exceptions
  static AppError _handleDioException(final DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return _handleTimeout(error);

      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
        return _handleConnectionError(error);

      case DioExceptionType.cancel:
        return _handleCancel(error);

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.unknown:
        return _handleUnknownError(error);
    }
  }

  //  Specific Error Handlers
  static AppError _handleTimeout(final DioException error) {
    return AppError(
      messageKey: 'errors.timeout',
      type: ErrorType.timeout,
      code: ErrorCode.timeout,
      technicalMessage: error.message,
      originalError: error,
    );
  }

  static AppError _handleConnectionError(final DioException error) {
    return AppError(
      messageKey: 'errors.connection_error',
      type: ErrorType.noInternet,
      code: ErrorCode.noInternet,
      technicalMessage: error.message,
      originalError: error,
    );
  }

  static AppError _handleCancel(final DioException error) {
    return AppError(
      messageKey: 'errors.cancelled',
      type: ErrorType.cancel,
      code: ErrorCode.cancel,
      technicalMessage: error.message,
      originalError: error,
    );
  }

  static AppError _handleBadResponse(final DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    // Extract error information from response
    final serverMessage = _extractErrorMessage(data);
    final details = _extractErrorDetails(data);
    final technicalMessage = error.message ?? error.toString();

    switch (statusCode) {
      case 400:
        return AppError(
          messageKey: 'errors.bad_request',
          serverMessage: serverMessage,
          type: ErrorType.badRequest,
          code: ErrorCode.badRequest,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );

      case 401:
        return AppError(
          messageKey: 'errors.invalid_credentials',
          serverMessage: serverMessage,
          type: ErrorType.unauthorized,
          code: ErrorCode.unauthorized,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );

      case 403:
        return AppError(
          messageKey: 'errors.forbidden',
          serverMessage: serverMessage,
          type: ErrorType.forbidden,
          code: ErrorCode.forbidden,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );

      case 404:
        return AppError(
          messageKey: 'errors.not_found',
          serverMessage: serverMessage,
          type: ErrorType.notFound,
          code: ErrorCode.notFound,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );

      case 409:
        return AppError(
          messageKey: 'errors.conflict',
          serverMessage: serverMessage,
          type: ErrorType.conflict,
          code: ErrorCode.conflict,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );

      case 422:
        return AppError(
          messageKey: 'errors.validation',
          serverMessage: serverMessage,
          type: ErrorType.validation,
          code: ErrorCode.unprocessableEntity,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );

      case 429:
        return AppError(
          messageKey: 'errors.too_many_requests',
          serverMessage: serverMessage,
          type: ErrorType.tooManyRequests,
          code: ErrorCode.tooManyRequests,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return AppError(
          messageKey: 'errors.server_error',
          serverMessage: serverMessage,
          type: ErrorType.internalServer,
          code: statusCode ?? ErrorCode.internalServer,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );

      default:
        return AppError(
          messageKey: 'errors.unknown',
          serverMessage: serverMessage,
          type: ErrorType.unknown,
          code: statusCode ?? ErrorCode.unknown,
          technicalMessage: technicalMessage,
          details: details,
          originalError: error,
        );
    }
  }

  static AppError _handleUnknownError(final DioException error) {
    final errorString = error.error?.toString().toLowerCase() ?? '';

    // Check if it's a network error
    if (errorString.contains('socket') ||
        errorString.contains('network') ||
        errorString.contains('host') ||
        errorString.contains('connection')) {
      return AppError.noInternet();
    }

    return AppError(
      messageKey: 'errors.unknown',
      type: ErrorType.unknown,
      code: ErrorCode.unknown,
      technicalMessage: error.message ?? error.error?.toString(),
      originalError: error,
    );
  }

// Message Extraction Utilities
  /// Extracts user-friendly error message from API response
  /// Tries multiple common fields in order of priority
  static String? _extractErrorMessage(final dynamic data) {
    if (data == null) return null;

    try {
      if (data is Map<String, dynamic>) {
        // Try common message fields in order of priority
        final messageCandidates = [
          'message',
          'error_description',
          'error',
          'msg',
          'detail',
          'details',
          'description',
        ];

        for (final field in messageCandidates) {
          if (data[field] != null) {
            final value = data[field];

            // Handle string messages
            if (value is String && value.isNotEmpty) {
              return value;
            }

            // Handle nested object with message
            if (value is Map<String, dynamic> && value['message'] != null) {
              return value['message'].toString();
            }
          }
        }

        // Check for validation errors array
        if (data['errors'] is List && (data['errors'] as List).isNotEmpty) {
          final firstError = (data['errors'] as List).first;
          if (firstError is String) return firstError;
          if (firstError is Map && firstError['message'] != null) {
            return firstError['message'].toString();
          }
        }
      }

      // If data is a string, return it
      if (data is String && data.isNotEmpty) {
        return data;
      }
    } catch (e) {
      // If extraction fails, return null to use fallback
    }

    return null;
  }

  /// Extracts structured error details from API response
  static ErrorDetails? _extractErrorDetails(final dynamic data) {
    if (data == null || data is! Map<String, dynamic>) return null;

    try {
      final Map<String, dynamic> metadata = {};

      // Extract validation errors
      if (data['errors'] != null) {
        metadata['errors'] = data['errors'];
      }

      // Extract field errors
      if (data['field_errors'] != null) {
        metadata['field_errors'] = data['field_errors'];
      }

      // Extract any additional data
      if (data['data'] != null) {
        metadata['data'] = data['data'];
      }

      // Extract trace_id for debugging
      if (data['trace_id'] != null) {
        metadata['trace_id'] = data['trace_id'];
      }

      if (metadata.isEmpty) return null;

      return ErrorDetails(metadata: metadata);
    } catch (e) {
      return null;
    }
  }
}
