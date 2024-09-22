part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRequest extends AuthEvent {
  final String username;
  final String password;
  AuthLoginRequest({
    required this.username,
    required this.password,
  });
}

final class AuthRegisterRequest extends AuthEvent {
  final String username;
  final String password;
  final String passwordConfirm;
  AuthRegisterRequest({
    required this.username,
    required this.password,
    required this.passwordConfirm,
  });
}
