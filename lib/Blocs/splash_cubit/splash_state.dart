part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}
class UnknownState extends SplashState{}
class UnRegisteredState extends SplashState {}
class RegisteredState extends SplashState{}