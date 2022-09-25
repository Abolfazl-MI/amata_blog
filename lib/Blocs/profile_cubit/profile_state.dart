part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final AmataUser amataUser;
  ProfileLoadedState(this.amataUser);
}

class ProfileErrorState extends ProfileState {
  final String error;
  ProfileErrorState(this.error);
}
