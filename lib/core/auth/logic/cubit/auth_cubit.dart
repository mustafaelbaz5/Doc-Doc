import 'package:doc_doc/core/auth/data/models/login_request_body.dart';
import 'package:doc_doc/core/auth/data/models/login_response_body.dart';
import 'package:doc_doc/core/auth/data/models/sign_up_request_body.dart';
import 'package:doc_doc/core/auth/data/models/sign_up_response_body.dart';
import 'package:doc_doc/core/auth/data/repo/auth_repo.dart';
import 'package:doc_doc/core/error/models/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  final AuthRepo authRepo;

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
      emit(AuthInitial());
    } catch (error) {
      emit(AuthInitial());
    }
  }
}
