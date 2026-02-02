import '../models/login_request_body.dart';
import '../models/login_response_body.dart';
import '../models/sign_up_request_body.dart';
import '../models/sign_up_response_body.dart';

abstract class AuthRepo {
  Future<LoginResponseBody> login(final LoginRequestBody body);

  Future<SignUpResponseBody> signUp(final SignUpRequestBody body);

  Future<void> logout();

  Future<void> saveUserToken({required final String token});
}
