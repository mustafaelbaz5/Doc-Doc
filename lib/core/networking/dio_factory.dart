import 'package:dio/dio.dart';
import '../constants/app_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../auth/logic/cubit/auth_cubit.dart';
import '../di/dependency_injection.dart';
import '../service/secure_storage.dart';

class DioFactory {
  DioFactory._();
  static Dio? _dio;

  static Future<Dio> getDio() async {
    if (_dio != null) return _dio!;

    final Duration timeout = const Duration(seconds: 30);
    final SecureStorage secureStorage = getIt<SecureStorage>();

    _dio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        receiveTimeout: timeout,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    // Add token header
    final token = await secureStorage.read(key: AppKeys.userTokenKey);
    if (token != null && token.isNotEmpty) {
      _dio!.options.headers["Authorization"] = "Bearer $token";
    }

    // Add interceptors
    _dio!.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (final options, final handler) async {
          final freshToken = await secureStorage.read(
            key: AppKeys.userTokenKey,
          );
          if (freshToken != null && freshToken.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $freshToken";
          }
          handler.next(options);
        },
        onError: (final error, final handler) async {
          if (error.response?.statusCode == 401) {
            // Notify AuthCubit safely
            try {
              if (getIt.isRegistered<AuthCubit>()) {
                final authCubit = getIt<AuthCubit>();
                if (!authCubit.isClosed) {
                  authCubit.handleUnauthorized();
                }
              }
              await secureStorage.delete(key: AppKeys.userTokenKey);
              clearToken();
            } catch (e) {
              debugPrint('Could not notify AuthCubit: $e');
            }
          }
          handler.next(error);
        },
      ),
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    ]);

    return _dio!;
  }

  /// Update token after login
  static void setTokenAfterAuth(final String token) {
    _dio?.options.headers["Authorization"] = "Bearer $token";
  }

  /// Clear token on logout
  static void clearToken() {
    _dio?.options.headers.remove("Authorization");
  }
}
