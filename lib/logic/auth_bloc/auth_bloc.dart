import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBlocBloc extends Bloc<AuthEvent, AuthState> {
  AuthBlocBloc() : super(const UnknownState(AuthStatus.unknown)) {
    on<LoginWithEmailEvent>(_loginWithEmail);
    on<SignUpWithEmailEvent>(_signUpWithEmail);
    on<ForgetPasswordEvent>(_forgetPassword);
    on<LogOutEvent>(_logout);
  }

  FutureOr<void> _loginWithEmail(
      LoginWithEmailEvent event, Emitter<AuthState> emit) {}
  FutureOr<void> _signUpWithEmail(
      SignUpWithEmailEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> _forgetPassword(
      ForgetPasswordEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> _logout(LogOutEvent event, Emitter<AuthState> emit) {}
}
