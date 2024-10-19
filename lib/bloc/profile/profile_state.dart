part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLogedOut extends ProfileState {}

final class ProfileResponse extends ProfileState {
  final String userId;
  ProfileResponse({required this.userId});
}
