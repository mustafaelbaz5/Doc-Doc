import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../handlers/dio_error_handler.dart';
import '../handlers/firebase_error_handler.dart';
import '../handlers/supabase_error_handler.dart';
import '../models/app_error.dart';

class ErrorHandler {
  /// Handle any error and convert it to AppError
  static AppError handle(final dynamic error) {
    // Handle AppError (already processed)
    if (error is AppError) {
      return error;
    }

    // Check for Supabase errors
    if (_isSupabaseError(error)) {
      return SupabaseErrorHandler.handle(error);
    }

    // Check for Dio errors
    if (error is DioException) {
      return DioErrorHandler.handle(error);
    }

    // Check for Firebase errors
    if (_isFirebaseError(error)) {
      return FirebaseErrorHandler.handle(error);
    }

    // Handle generic Exception
    if (error is Exception) {
      return AppError.unknown(error.toString());
    }

    // Handle any other error type
    return AppError.unknown(error?.toString() ?? 'errors.unknown');
  }

  /// Check if the error is a Supabase-related error
  static bool _isSupabaseError(final dynamic error) {
    return error is AuthException || // general auth errors
        error is PostgrestException ||
        error is StorageException;
  }

  /// Check if the error is a Firebase-related error
  static bool _isFirebaseError(final dynamic error) {
    return error is FirebaseAuthException || error is FirebaseException;
  }
}
