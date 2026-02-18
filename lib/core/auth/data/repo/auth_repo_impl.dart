import 'package:doc_doc/core/constants/app_keys.dart';

import '../../../networking/dio_factory.dart';
import '../../../service/secure_storage.dart';
import '../models/login_request_body.dart';
import '../models/login_response_body.dart';
import '../models/sign_up_request_body.dart';
import '../models/sign_up_response_body.dart';
import '../remote/auth_remote_api.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteApi authRemoteApi;
  final SecureStorage secureStorage;

  AuthRepoImpl({required this.authRemoteApi, required this.secureStorage});

  @override
  Future<LoginResponseBody> login(final LoginRequestBody body) async {
    return await authRemoteApi.login(body);
  }

  @override
  Future<SignUpResponseBody> signUp(final SignUpRequestBody body) async {
    return await authRemoteApi.signUp(body);
  }

  @override
  Future<void> logout() async {
    try {
      await authRemoteApi.logout();
    } finally {
      await clearToken();
    }
  }

  @override
  Future<void> saveUserToken({required final String token}) async {
    await secureStorage.write(key: AppKeys.userTokenKey, value: token);
    DioFactory.setTokenAfterAuth(token);
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<String?> getToken() {
    return secureStorage.read(key: AppKeys.userTokenKey);
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: AppKeys.userTokenKey);
    DioFactory.clearToken();
  }
}
