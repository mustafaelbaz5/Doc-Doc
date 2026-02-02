import '../models/login_request_body.dart';
import '../models/login_response_body.dart';
import '../models/sign_up_request_body.dart';
import '../models/sign_up_response_body.dart';
import '../remote/auth_remote_api.dart';
import 'auth_repo.dart';
import '../../../constants/storage_constants.dart';
import '../../../error/types/error_handler.dart';
import '../../../networking/dio_factory.dart';
import '../../../service/secure_storage.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRemoteApi authRemoteApi;
  SecureStorage secureStorage;

  AuthRepoImpl({required this.authRemoteApi, required this.secureStorage});
  @override
  Future<LoginResponseBody> login(final LoginRequestBody body) async {
    try {
      return await authRemoteApi.login(body);
    } catch (e) {
      // Convert to AppError
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
      DioFactory.clearToken();
      await secureStorage.delete(key: StorageConstants.userTokenKey);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> saveUserToken({required final String token}) async {
    await secureStorage.write(key: StorageConstants.userTokenKey, value: token);
    DioFactory.setTokenAfterAuth(token);
  }
}
