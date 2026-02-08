import '../../../constants/storage_constants.dart';
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
  Future<LoginResponseBody> login(final LoginRequestBody body) {
    // Let errors bubble up (already AppError)
    return authRemoteApi.login(body);
  }

  @override
  Future<SignUpResponseBody> signUp(final SignUpRequestBody body) {
    return authRemoteApi.signUp(body);
  }

  @override
  Future<void> logout() async {
    try {
      await authRemoteApi.logout();
    } finally {
      // ALWAYS clear local state
      await clearToken();
    }
  }

  @override
  Future<void> saveUserToken({required final String token}) async {
    await secureStorage.write(key: StorageConstants.userTokenKey, value: token);
    DioFactory.setTokenAfterAuth(token);
  }

  @override
  Future<String?> getToken() {
    return secureStorage.read(key: StorageConstants.userTokenKey);
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: StorageConstants.userTokenKey);
    DioFactory.clearToken();
  }
}
