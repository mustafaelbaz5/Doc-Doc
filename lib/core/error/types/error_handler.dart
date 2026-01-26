import 'package:dio/dio.dart';

import '../handlers/dio_error_handler.dart';
import '../models/app_error.dart';

class ErrorHandler {
  /// Handle any error and convert it to AppError
  static AppError handle(final dynamic error) {
    // Handle AppError (already processed)
    if (error is AppError) {
      return error;
    }

    // Check for Dio errors
    if (error is DioException) {
      return DioErrorHandler.handle(error);
    }

    // Handle generic Exception
    if (error is Exception) {
      return AppError.unknown(error.toString());
    }

    // Handle any other error type
    return AppError.unknown(error?.toString() ?? 'errors.unknown');
  }
}
