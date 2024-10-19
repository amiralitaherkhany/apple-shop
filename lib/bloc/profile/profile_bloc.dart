import 'package:apple_shop/util/auth_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoad>(
      (event, emit) {
        AuthManager.isLogedIn()
            ? emit(ProfileResponse(userId: AuthManager.getUserName()))
            : emit(ProfileResponse(userId: 'شما لاگین نیستید'));
      },
    );
    on<ProfileLogOut>(
      (event, emit) {
        AuthManager.logOut();
        emit(ProfileLogedOut());
      },
    );
  }
}
