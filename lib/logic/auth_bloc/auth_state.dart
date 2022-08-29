part of 'auth_bloc.dart';

enum AuthStatus { unknown, unAuthenticated, authenticated }

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnknownState extends AuthState {
  final AuthStatus authStatus;

  const UnknownState(this.authStatus);
}

class UnAuthenticatedState extends AuthState {
  final AuthStatus authStatus;

  const UnAuthenticatedState(this.authStatus);
}

class AuthenticatedState extends AuthState {
  final User user;
  const AuthenticatedState(this.user);
}

class LoadingState extends AuthState {}

class ErrorState extends AuthState {
  final String err;

  ErrorState(this.err);

}

class ForgetPasswordState extends AuthState{

}