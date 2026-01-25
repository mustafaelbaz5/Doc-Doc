import '../types/error_type.dart';
import 'error_details.dart';

class AppError implements Exception {
  final String message;
  final ErrorType type;
  final int? code;
  final String? technicalMessage;
  final ErrorDetails? details;
  final dynamic originalError;

  const AppError({
    required this.message,
    required this.type,
    this.code,
    this.technicalMessage,
    this.details,
    this.originalError,
  });

  // Factory constructors for common errors
  factory AppError.noInternet() {
    return const AppError(
      message: 'errors.no_internet',
      type: ErrorType.noInternet,
      code: ErrorCode.noInternet,
    );
  }

  factory AppError.timeout() {
    return const AppError(
      message: 'errors.timeout',
      type: ErrorType.timeout,
      code: ErrorCode.timeout,
    );
  }

  factory AppError.unauthorized() {
    return const AppError(
      message: 'errors.unauthorized',
      type: ErrorType.unauthorized,
      code: ErrorCode.unauthorized,
    );
  }

  factory AppError.serverError() {
    return const AppError(
      message: 'errors.server_error',
      type: ErrorType.internalServer,
      code: ErrorCode.internalServer,
    );
  }

  factory AppError.unknown([final String? message]) {
    return AppError(
      message: message ?? 'errors.unknown',
      type: ErrorType.unknown,
      code: ErrorCode.unknown,
    );
  }

  // Copy with method for modifications
  AppError copyWith({
    final String? message,
    final ErrorType? type,
    final int? code,
    final String? technicalMessage,
    final ErrorDetails? details,
    final dynamic originalError,
  }) {
    return AppError(
      message: message ?? this.message,
      type: type ?? this.type,
      code: code ?? this.code,
      technicalMessage: technicalMessage ?? this.technicalMessage,
      details: details ?? this.details,
      originalError: originalError ?? this.originalError,
    );
  }

  @override
  String toString() {
    return 'AppError(message: $message, type: $type, code: $code)';
  }
}
