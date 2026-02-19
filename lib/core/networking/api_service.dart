import 'package:dio/dio.dart';
import '../error/types/error_handler.dart';
import 'api_end_points.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  String get _baseUrl => ApiEndPoints.apiBaseUrl;

  Future<T> get<T>({
    required final String endPoint,
    final Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get<T>(
        _baseUrl + endPoint,
        queryParameters: queryParameters,
      );
      return response.data as T;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<T> post<T>({
    required final String endPoint,
    final dynamic data,
    final Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post<T>(
        _baseUrl + endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data as T;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<T> put<T>({required final String endPoint, final dynamic data}) async {
    try {
      final response = await dio.put<T>(_baseUrl + endPoint, data: data);
      return response.data as T;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<T> delete<T>({
    required final String endPoint,
    final dynamic data,
  }) async {
    try {
      final response = await dio.delete<T>(_baseUrl + endPoint, data: data);
      return response.data as T;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}
