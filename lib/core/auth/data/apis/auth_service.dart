import 'package:dio/dio.dart';
import 'package:doc_doc/core/auth/data/models/login_request_body.dart';
import 'package:doc_doc/core/auth/data/models/login_response_body.dart';
import 'package:doc_doc/core/auth/data/models/sign_up_request_body.dart';
import 'package:doc_doc/core/auth/data/models/sign_up_response_body.dart';
import 'package:doc_doc/core/constants/api_constants.dart';
import 'package:doc_doc/core/error/types/error_handler.dart';

class AuthService {
  final Dio dio;
  final String _baseUrl = ApiConstants.apiBaseUrl;

  AuthService({required this.dio});

  /// Login API call
  Future<LoginResponseBody> login(
    final LoginRequestBody loginRequestBody,
  ) async {
    try {
      final response = await dio.post(
        '$_baseUrl${ApiConstants.loginEndpoint}',
        data: loginRequestBody.toJson(),
      );

      return LoginResponseBody.fromJson(response.data);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// SignUp API
  Future<SignUpResponseBody> signUp(
    final SignUpRequestBody signUpRequestBody,
  ) async {
    try {
      final response = await dio.post(
        '$_baseUrl${ApiConstants.signUpEndpoint}',
        data: signUpRequestBody.toJson(),
      );

      return SignUpResponseBody.fromJson(response.data);
    } on DioException catch (e) {
      // Handle validation error separately
      if (e.response?.statusCode == 422 && e.response?.data != null) {
        return SignUpResponseBody.fromJson(e.response!.data);
      }

      ErrorHandler.handle(e);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}
