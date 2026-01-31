import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../handlers/dio_error_handler.dart';
import '../models/app_error.dart';

class ErrorHandler {
  /// Handle any error and throw an AppError
  /// Returns Never because it always throws
  static Never handle(final dynamic error) {
    // If it's already an AppError, throw it
    if (error is AppError) throw error;

    // Handle Dio exceptions
    if (error is DioException) throw DioErrorHandler.handle(error);

    // Handle generic Exceptions
    if (error is Exception) throw AppError.unknown(error.toString());

    // Handle any other error type
    throw AppError.unknown(error?.toString() ?? 'errors.unknown'.tr());
  }
}
