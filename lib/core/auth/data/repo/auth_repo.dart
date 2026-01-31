import 'package:doc_doc/core/auth/data/models/login_request_body.dart';
import 'package:doc_doc/core/auth/data/models/login_response_body.dart';

abstract class AuthRepo {
  Future<LoginResponseBody> login(final LoginRequestBody loginRequestBody);
}
