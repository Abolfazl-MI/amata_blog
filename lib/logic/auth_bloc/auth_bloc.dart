import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:blog_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthBloc() : super(const UnknownState(AuthStatus.unknown)) {
    on<LoginWithEmailEvent>(_loginWithEmail);
    on<SignUpWithEmailEvent>(_signUpWithEmail);
    on<ForgetPasswordEvent>(_forgetPassword);
  }

  Future<void> _loginWithEmail(
      LoginWithEmailEvent event, Emitter<AuthState> emit) async {
    RawData result = await _authRepository.loginWithEmail(
        email: event.emailAddress, password: event.password);
    if (result.operationResult == OperationResult.success) {
      emit(AuthenticatedState(result.data));
    }
    if (result.operationResult == OperationResult.fail) {
      emit(ErrorState(result.data.toString()));
    }
  }

  Future<void> _signUpWithEmail(
      SignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    RawData result = await _authRepository.signupWithEmail(
        email: event.emailAddress, password: event.password);
    if (result.operationResult == OperationResult.success) {
      emit(AuthenticatedState(result.data));
    }
    if (result.operationResult == OperationResult.fail) {
      emit(ErrorState(result.data.toString()));
    }
  }

  Future<void> _forgetPassword(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      RawData result =
          await _authRepository.forGetPassword(email: event.emailAddress);
      if (result.operationResult == OperationResult.success) {
        emit(ForgetPasswordState());
      }
      if (result.operationResult == OperationResult.fail) {
        emit(ErrorState(result.data.toString()));
      }
    } catch (e) {}
  }
}
