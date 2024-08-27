// ignore_for_file: public_member_api_docs, sort_constructors_first
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
