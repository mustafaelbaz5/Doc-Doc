import 'package:doc_doc/core/auth/data/models/login_request_body.dart';
import 'package:doc_doc/core/auth/data/models/login_response_body.dart';
import 'package:doc_doc/core/auth/data/models/sign_up_request_body.dart';
import 'package:doc_doc/core/auth/data/models/sign_up_response_body.dart';

abstract class AuthRepo {
  Future<LoginResponseBody> login(final LoginRequestBody body);

  Future<SignUpResponseBody> signUp(final SignUpRequestBody body);
}
