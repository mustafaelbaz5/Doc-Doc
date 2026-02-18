import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../error/models/app_error.dart';
import '../../data/models/login_request_body.dart';
import '../../data/models/sign_up_request_body.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> checkAuthStatus() async {
    emit(AuthChecking());
    final token = await authRepo.getToken();

    if (token == null || token.isEmpty || token == '') {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated());
    }
  }

  Future<void> login(final LoginRequestBody body) async {
    emit(AuthChecking());
    try {
      final response = await authRepo.login(body);
      await authRepo.saveUserToken(token: response.data?.token ?? '');
      emit(AuthAuthenticated());
    } catch (error) {
      emit(AuthFailure(error: error is AppError ? error : AppError.unknown()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signUp(final SignUpRequestBody body) async {
    emit(AuthChecking());
    try {
      final response = await authRepo.signUp(body);
      await authRepo.saveUserToken(token: response.userData?.token ?? '');
      emit(AuthAuthenticated());
    } catch (error) {
      emit(AuthFailure(error: error is AppError ? error : AppError.unknown()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    emit(AuthChecking());
    try {
      await authRepo.logout();
    } catch (_) {
      // ignore — repo already cleared token in finally
    } finally {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> handleUnauthorized() async {
    await authRepo.clearToken();
    emit(AuthSessionExpired());
  }
}
