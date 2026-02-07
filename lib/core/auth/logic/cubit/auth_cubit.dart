import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../error/models/app_error.dart';
import '../../data/models/login_request_body.dart';
import '../../data/models/login_response_body.dart';
import '../../data/models/sign_up_request_body.dart';
import '../../data/models/sign_up_response_body.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  final AuthRepo authRepo;

  /// Check if user session is valid on app start
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final token = await authRepo.getToken();

      if (token == null || token.isEmpty || token == '') {
        emit(AuthUnauthenticated());
        return;
      }
      emit(AuthAuthenticated());
    } catch (error) {
      // Token expired or invalid
      await authRepo.clearToken();
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(final LoginRequestBody body) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.login(body);
      await authRepo.saveUserToken(token: response.data?.token ?? '');
      emit(LoginSuccess(response: response));
    } catch (error) {
      debugPrint(error.toString());
      emit(AuthFailure(error: error is AppError ? error : AppError.unknown()));
    }
  }

  Future<void> signUp(final SignUpRequestBody body) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.signUp(body);
      await authRepo.saveUserToken(token: response.userData?.token ?? '');
      emit(SignUpSuccess(response: response));
    } catch (error) {
      debugPrint(error.toString());
      emit(AuthFailure(error: error is AppError ? error : AppError.unknown()));
    }
  }

  Future<void> logout() async {
    try {
      await authRepo.logout();
      await authRepo.clearToken();
      emit(AuthUnauthenticated());
    } catch (error) {
      emit(AuthUnauthenticated());
    }
  }

  /// Handle unauthorized access (token expired)
  void handleUnauthorized() {
    emit(AuthSessionExpired());
  }
}
