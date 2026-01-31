import 'package:dio/dio.dart';
import 'package:doc_doc/core/constants/storage_constants.dart';
import 'package:doc_doc/core/di/dependency_injection.dart';
import 'package:doc_doc/core/service/secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
    final token = await secureStorage.read(key: StorageConstants.userTokenKey);
    if (token != null && token.isNotEmpty) {
      _dio!.options.headers["Authorization"] = "Bearer $token";
    }

    // Add interceptors
    _dio!.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (final options, final handler) async {
          // Always get fresh token from storage
          final freshToken = await secureStorage.read(
            key: StorageConstants.userTokenKey,
          );
          if (freshToken != null && freshToken.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $freshToken";
          } else {
            clearToken();
          }
          handler.next(options);
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
