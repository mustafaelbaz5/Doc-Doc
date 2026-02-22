import '../../../networking/api_service.dart';

import '../../../networking/api_end_points.dart';
import '../models/login_request_body.dart';
import '../models/login_response_body.dart';
import '../models/sign_up_request_body.dart';
import '../models/sign_up_response_body.dart';

class AuthRemoteApi {
  final ApiService apiService;

  AuthRemoteApi({required this.apiService});

  Future<LoginResponseBody> login(
    final LoginRequestBody loginRequestBody,
  ) async {
    final Map<String, dynamic> data = await apiService
        .post<Map<String, dynamic>>(
          endPoint: ApiEndPoints.loginEndpoint,
          data: loginRequestBody.toJson(),
        );

    return LoginResponseBody.fromJson(data);
  }

  Future<SignUpResponseBody> signUp(
    final SignUpRequestBody signUpRequestBody,
  ) async {
    final Map<String, dynamic> data = await apiService
        .post<Map<String, dynamic>>(
          endPoint: ApiEndPoints.signUpEndpoint,
          data: signUpRequestBody.toJson(),
        );

    return SignUpResponseBody.fromJson(data);
  }

  Future<void> logout() async {
    await apiService.post<void>(endPoint: ApiEndPoints.logoutEndpoint);
  }
}
