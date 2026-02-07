import '../../../constants/storage_constants.dart';
import '../../../error/types/error_handler.dart';
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
    try {
      return await authRemoteApi.login(body);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  @override
  Future<SignUpResponseBody> signUp(final SignUpRequestBody body) async {
    try {
      return await authRemoteApi.signUp(body);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authRemoteApi.logout();
      await clearToken();
    } catch (e) {
      // Even if API call fails, clear local token
      await clearToken();
      ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> saveUserToken({required final String token}) async {
    await secureStorage.write(key: StorageConstants.userTokenKey, value: token);
    DioFactory.setTokenAfterAuth(token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: StorageConstants.userTokenKey);
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: StorageConstants.userTokenKey);
    DioFactory.clearToken();
  }
}
