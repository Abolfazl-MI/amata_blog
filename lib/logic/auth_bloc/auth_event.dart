part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailEvent extends AuthEvent {
  final String emailAddress;
  final String password;
  const LoginWithEmailEvent(
      {required this.emailAddress, required this.password});
}

class SignUpWithEmailEvent extends AuthEvent {
  final String emailAddress;
  final String password;
  const SignUpWithEmailEvent(
      {required this.emailAddress, required this.password});
}

class ForgetPasswordEvent extends AuthEvent {
  final String emailAddress;
  const ForgetPasswordEvent({required this.emailAddress});
}

class LogOutEvent extends AuthEvent{
  
}