import 'package:dio/dio.dart';
import 'package:doc_doc/core/auth/data/models/sign_up_request_body.dart';
import 'package:doc_doc/core/auth/data/models/sign_up_response_body.dart';
import 'package:doc_doc/core/constants/api_constants.dart';

import '../models/login_request_body.dart';
import '../models/login_response_body.dart';

class AuthService {
  final Dio dio;
  final String _baseUrl = ApiConstants.apiBaseUrl;

  AuthService({required this.dio});

  Future<LoginResponseBody> login(
    final LoginRequestBody loginRequestBody,
  ) async {
    final response = await dio.post(
      '$_baseUrl${ApiConstants.loginEndpoint}',
      data: loginRequestBody.toJson(),
    );
    return LoginResponseBody.fromJson(response.data);
  }

  Future<SignUpResponseBody> signUp(
    final SignUpRequestBody signUpRequestBody,
  ) async {
    final response = await dio.post(
      '$_baseUrl${ApiConstants.signUpEndpoint}',
      data: signUpRequestBody.toJson(),
    );
    return SignUpResponseBody.fromJson(response.data);
  }
}
