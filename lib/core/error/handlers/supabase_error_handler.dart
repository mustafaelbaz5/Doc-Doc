import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_error.dart';
import '../types/error_type.dart';

class SupabaseErrorHandler {
  /// Main handler: convert any Supabase or generic exception into AppError
  static AppError handle(final dynamic error) {
    if (error is AuthException) {
      return _handleAuthException(error);
    } else if (error is PostgrestException) {
      return _handlePostgrestException(error);
    } else if (error is StorageException) {
      return _handleStorageException(error);
    } else if (error is Exception) {
      return _handleGenericException(error);
    }

    // Fallback for unknown errors
    return AppError.unknown('errors.unknown');
  }

  // =========================
  // Auth Error Handling
  // =========================
  static AppError _handleAuthException(final AuthException error) {
    final String message = error.message.toLowerCase();
    final int? statusCode = error.statusCode != null
        ? int.tryParse(error.statusCode!)
        : null;

    if (message.contains('invalid login credentials') ||
        message.contains('invalid email or password')) {
      return AppError(
        message: 'errors.invalid_credentials',
        type: ErrorType.invalidCredentials,
        code: statusCode,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('user not found') ||
        message.contains('user does not exist')) {
      return AppError(
        message: 'errors.user_not_found',
        type: ErrorType.userNotFound,
        code: statusCode,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('user already registered') ||
        message.contains('email already exists') ||
        message.contains('already been registered')) {
      return AppError(
        message: 'errors.email_already_exists',
        type: ErrorType.emailAlreadyExists,
        code: statusCode,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('password') && message.contains('weak')) {
      return AppError(
        message: 'errors.weak_password',
        type: ErrorType.weakPassword,
        code: statusCode,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('invalid email')) {
      return AppError(
        message: 'errors.invalid_email',
        type: ErrorType.invalidEmail,
        code: statusCode,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('session') && message.contains('expired')) {
      return AppError(
        message: 'errors.session_expired',
        type: ErrorType.sessionExpired,
        code: statusCode,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('not authenticated') || message.contains('jwt')) {
      return AppError(
        message: 'errors.unauthorized',
        type: ErrorType.unauthorized,
        code: statusCode,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('rate limit') ||
        message.contains('too many requests')) {
      return AppError(
        message: 'errors.too_many_requests',
        type: ErrorType.supabaseAuth,
        code: ErrorCode.tooManyRequests,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('email not confirmed') || message.contains('verify')) {
      return AppError(
        message: 'errors.email_not_verified',
        type: ErrorType.emailNotVerified,
        code: statusCode,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('network') || message.contains('connection')) {
      return AppError.noInternet();
    }

    // Default fallback
    return AppError(
      message: 'errors.unknown',
      type: ErrorType.supabaseAuth,
      code: statusCode,
      technicalMessage: error.message,
      originalError: error,
    );
  }

  // =========================
  // Database Error Handling
  // =========================
  static AppError _handlePostgrestException(final PostgrestException error) {
    final String message = error.message.toLowerCase();
    final String code = error.code ?? '';

    if (code == 'PGRST116' || message.contains('not found')) {
      return AppError(
        message: 'errors.not_found',
        type: ErrorType.notFound,
        code: ErrorCode.notFound,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('duplicate') || message.contains('already exists')) {
      return AppError(
        message: 'errors.conflict',
        type: ErrorType.conflict,
        code: ErrorCode.conflict,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('permission') || message.contains('policy')) {
      return AppError(
        message: 'errors.permission_denied',
        type: ErrorType.forbidden,
        code: ErrorCode.forbidden,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    return AppError(
      message: 'errors.unknown',
      type: ErrorType.supabaseDatabase,
      code: ErrorCode.unknown,
      technicalMessage: error.message,
      originalError: error,
    );
  }

  // =========================
  // Storage Error Handling
  // =========================
  static AppError _handleStorageException(final StorageException error) {
    final String message = error.message.toLowerCase();
    final int statusCode = int.tryParse(error.statusCode ?? '') ?? 0;

    if (statusCode == 404 || message.contains('not found')) {
      return AppError(
        message: 'errors.not_found',
        type: ErrorType.notFound,
        code: ErrorCode.notFound,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (statusCode == 413 ||
        message.contains('too large') ||
        message.contains('size')) {
      return AppError(
        message: 'errors.file_too_large',
        type: ErrorType.supabaseStorage,
        code: 413,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (message.contains('permission') || message.contains('unauthorized')) {
      return AppError(
        message: 'errors.forbidden',
        type: ErrorType.forbidden,
        code: ErrorCode.forbidden,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    return AppError(
      message: 'errors.unknown',
      type: ErrorType.supabaseStorage,
      code: statusCode,
      technicalMessage: error.message,
      originalError: error,
    );
  }

  // =========================
  // Generic Exception Handling
  // =========================
  static AppError _handleGenericException(final Exception error) {
    final String message = error.toString().toLowerCase();

    if (message.contains('socket') || message.contains('network')) {
      return AppError.noInternet();
    }

    if (message.contains('timeout')) {
      return AppError.timeout();
    }

    return AppError(
      message: 'errors.unknown',
      type: ErrorType.unknown,
      code: ErrorCode.unknown,
      technicalMessage: error.toString(),
    );
  }
}
