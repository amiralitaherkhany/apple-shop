part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthResponse extends AuthState {
  final Either<String, String> response;
  AuthResponse({required this.response});
}
