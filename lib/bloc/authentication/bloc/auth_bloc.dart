import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository repository;
  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<AuthLoginRequest>(
      (event, emit) async {
        emit(AuthLoading());
        var response = await repository.login(event.username, event.password);
        emit(AuthResponse(response: response));
      },
    );
  }
}
