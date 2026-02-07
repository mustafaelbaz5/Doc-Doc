part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {}

final class AuthUnauthenticated extends AuthState {}

final class AuthSessionExpired extends AuthState {}

final class LoginSuccess extends AuthState {
  final LoginResponseBody response;
  LoginSuccess({required this.response});
}

final class SignUpSuccess extends AuthState {
  final SignUpResponseBody response;
  SignUpSuccess({required this.response});
}

final class AuthFailure extends AuthState {
  final AppError error;
  AuthFailure({required this.error});
}
