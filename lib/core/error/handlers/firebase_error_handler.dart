import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_error.dart';
import '../types/error_type.dart';

class FirebaseErrorHandler {
  static AppError handle(final dynamic error) {
    if (error is FirebaseAuthException) {
      return _handleAuthException(error);
    }

    if (error is FirebaseException) {
      return _handleFirebaseException(error);
    }

    return AppError.unknown(error.toString());
  }

  // Handle Firebase Auth Errors
  static AppError _handleAuthException(final FirebaseAuthException error) {
    switch (error.code) {
      // Email/Password errors
      case 'invalid-email':
        return AppError(
          message: 'errors.invalid_email',
          type: ErrorType.invalidEmail,
          code: ErrorCode.badRequest,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'user-disabled':
        return AppError(
          message: 'errors.user_disabled', // Need to add this key
          type: ErrorType.firebaseAuth,
          code: ErrorCode.forbidden,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'user-not-found':
        return AppError(
          message: 'errors.user_not_found',
          type: ErrorType.userNotFound,
          code: ErrorCode.notFound,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'wrong-password':
      case 'invalid-credential':
        return AppError(
          message: 'errors.invalid_credentials',
          type: ErrorType.invalidCredentials,
          code: ErrorCode.unauthorized,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'email-already-in-use':
        return AppError(
          message: 'errors.email_already_exists',
          type: ErrorType.emailAlreadyExists,
          code: ErrorCode.conflict,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'weak-password':
        return AppError(
          message: 'errors.weak_password',
          type: ErrorType.weakPassword,
          code: ErrorCode.badRequest,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'operation-not-allowed':
        return AppError(
          message: 'errors.operation_not_allowed', // Need to add this key
          type: ErrorType.firebaseAuth,
          code: ErrorCode.forbidden,
          technicalMessage: error.message,
          originalError: error,
        );

      // Session errors
      case 'requires-recent-login':
        return AppError(
          message: 'errors.session_expired',
          type: ErrorType.sessionExpired,
          code: ErrorCode.unauthorized,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'user-token-expired':
      case 'invalid-user-token':
        return AppError(
          message: 'errors.session_expired',
          type: ErrorType.sessionExpired,
          code: ErrorCode.unauthorized,
          technicalMessage: error.message,
          originalError: error,
        );

      // Network errors
      case 'network-request-failed':
        return AppError.noInternet();

      case 'too-many-requests':
        return AppError(
          message: 'errors.too_many_requests',
          type: ErrorType.firebaseAuth,
          code: 429,
          technicalMessage: error.message,
          originalError: error,
        );

      // Timeout
      case 'timeout':
        return AppError.timeout();

      default:
        return AppError(
          message: 'errors.unknown',
          type: ErrorType.firebaseAuth,
          code: ErrorCode.unknown,
          technicalMessage: error.message,
          originalError: error,
        );
    }
  }

  // Handle Firestore and Storage Errors
  static AppError _handleFirebaseException(final FirebaseException error) {
    // Check if it's a Firestore error
    if (error.plugin == 'cloud_firestore') {
      return _handleFirestoreError(error);
    }

    // Check if it's a Storage error
    if (error.plugin == 'firebase_storage') {
      return _handleStorageError(error);
    }

    // Generic Firebase error
    switch (error.code) {
      case 'permission-denied':
        return AppError(
          message: 'errors.permission_denied',
          type: ErrorType.forbidden,
          code: ErrorCode.forbidden,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'unavailable':
        return AppError(
          message: 'errors.service_unavailable',
          type: ErrorType.internalServer,
          code: ErrorCode.internalServer,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'cancelled':
        return AppError(
          message: 'errors.cancelled',
          type: ErrorType.cancel,
          code: ErrorCode.cancel,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'deadline-exceeded':
        return AppError.timeout();

      default:
        return AppError(
          message: 'errors.unknown',
          type: ErrorType.unknown,
          code: ErrorCode.unknown,
          technicalMessage: error.message,
          originalError: error,
        );
    }
  }

  static AppError _handleFirestoreError(final FirebaseException error) {
    switch (error.code) {
      case 'not-found':
        return AppError(
          message: 'errors.not_found',
          type: ErrorType.notFound,
          code: ErrorCode.notFound,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'already-exists':
        return AppError(
          message: 'errors.conflict',
          type: ErrorType.conflict,
          code: ErrorCode.conflict,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'failed-precondition':
        return AppError(
          message: 'errors.bad_request',
          type: ErrorType.firebaseFirestore,
          code: ErrorCode.badRequest,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'aborted':
        return AppError(
          message: 'errors.conflict',
          type: ErrorType.firebaseFirestore,
          code: ErrorCode.conflict,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'out-of-range':
        return AppError(
          message: 'errors.validation',
          type: ErrorType.validation,
          code: ErrorCode.badRequest,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'data-loss':
        return AppError(
          message: 'errors.server_error',
          type: ErrorType.firebaseFirestore,
          code: ErrorCode.internalServer,
          technicalMessage: error.message,
          originalError: error,
        );

      default:
        return AppError(
          message: 'errors.unknown',
          type: ErrorType.firebaseFirestore,
          code: ErrorCode.unknown,
          technicalMessage: error.message,
          originalError: error,
        );
    }
  }

  static AppError _handleStorageError(final FirebaseException error) {
    switch (error.code) {
      case 'object-not-found':
      case 'bucket-not-found':
        return AppError(
          message: 'errors.not_found',
          type: ErrorType.notFound,
          code: ErrorCode.notFound,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'unauthorized':
        return AppError(
          message: 'errors.forbidden',
          type: ErrorType.forbidden,
          code: ErrorCode.forbidden,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'quota-exceeded':
        return AppError(
          message: 'errors.server_error',
          type: ErrorType.firebaseStorage,
          code: 507,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'unauthenticated':
        return AppError(
          message: 'errors.unauthorized',
          type: ErrorType.unauthorized,
          code: ErrorCode.unauthorized,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'retry-limit-exceeded':
        return AppError(
          message: 'errors.unknown',
          type: ErrorType.firebaseStorage,
          code: ErrorCode.unknown,
          technicalMessage: error.message,
          originalError: error,
        );

      case 'invalid-checksum':
        return AppError(
          message: 'errors.bad_request',
          type: ErrorType.firebaseStorage,
          code: ErrorCode.badRequest,
          technicalMessage: error.message,
          originalError: error,
        );

      default:
        return AppError(
          message: 'errors.unknown',
          type: ErrorType.firebaseStorage,
          code: ErrorCode.unknown,
          technicalMessage: error.message,
          originalError: error,
        );
    }
  }
}
