import 'package:doc_doc/core/auth/data/apis/auth_service.dart';
import 'package:doc_doc/core/auth/data/models/login_request_body.dart';
import 'package:doc_doc/core/auth/data/models/login_response_body.dart';
import 'package:doc_doc/core/auth/data/repo/auth_repo.dart';
import 'package:doc_doc/core/error/types/error_handler.dart';

class AuthRepoImpl implements AuthRepo {
  AuthService authService;

  AuthRepoImpl({required this.authService});
  @override
  Future<LoginResponseBody> login(final LoginRequestBody loginRequestBody) {
    try {
      final response = authService.login(loginRequestBody);
      return response;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}
