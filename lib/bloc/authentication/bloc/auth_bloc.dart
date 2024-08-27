import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequest>(
      (event, emit) async {
        emit(AuthLoading());
        var response = await _repository.login(event.username, event.password);
        emit(AuthResponse(response: response));
      },
    );
  }
}
