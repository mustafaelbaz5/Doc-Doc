import 'package:doc_doc/core/auth/data/models/login_request_body.dart';
import 'package:doc_doc/core/auth/data/models/login_response_body.dart';
import 'package:doc_doc/core/auth/data/repo/auth_repo.dart';
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
      emit(LoginSuccess(response: response));
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }
}
