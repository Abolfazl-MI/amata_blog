import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/Blocs/auth_bloc/auth_bloc.dart';
import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepositories _userRepository;
  ProfileCubit({UserRepositories? userRepository})
      : _userRepository = userRepository ?? UserRepositories(),
        super(ProfileLoadingState());
//  gets last changes from server
  Future<void> getUserInformation() async {
    RawData rawData = await _userRepository.getProfileInfo();
    switch (rawData.operationResult) {
      case OperationResult.success:
        emit(ProfileLoadedState(rawData.data));
        break;
      case OperationResult.fail:
        emit(ProfileErrorState(rawData.data));
        break;

      case null:
        throw Exception('null check operator used on null value');
    }
  }

// updates user Email
  Future<void> updateUserEmailAddress({required String emailAddress}) async {
    emit(ProfileLoadingState());
    RawData rawData = await _userRepository.updateUserEmailAddress(
        newEmailAddres: emailAddress);

    switch (rawData.operationResult) {
      case (OperationResult.success):
        emit(ProfileLoadedState(rawData.data));
        break;

      case (OperationResult.fail):
        emit(ProfileErrorState(rawData.data));
        break;

      case (null):
        emit(ProfileErrorState('Some thing bad happened'));
        break;
    }
  }

// updates user Name
  Future<void> updateUserName({required String newUserName}) async {
    emit(ProfileLoadingState());

    RawData rawData =
        await _userRepository.updateUserName(userName: newUserName);
    switch (rawData.operationResult) {
      case OperationResult.success:
        emit(ProfileLoadedState(rawData.data));
        break;
      case OperationResult.fail:
        emit(ProfileErrorState(rawData.data));
        break;
      case null:
        emit(ProfileErrorState('Some thing bad happened'));
        break;
    }
  }

//  updates user bio
  Future<void> updateAddBio({required String bio}) async {
    emit(ProfileLoadingState());

    RawData rawData = await _userRepository.updateOrAddBioForUser(bioText: bio);
    switch (rawData.operationResult) {
      case OperationResult.success:
        emit(ProfileLoadedState(rawData.data));
        break;
      case OperationResult.fail:
        emit(ProfileErrorState(rawData.data));
        break;
      case null:
        emit(ProfileErrorState('Some Thing went wrong'));
        break;
    }
  }

// updates user profile
  Future<void> updateProfilePhoto({required File profileImage}) async {
    emit(ProfileLoadingState());
    RawData rawData =
        await _userRepository.updateUserProfile(profileImage: profileImage);
    switch (rawData.operationResult) {
      case OperationResult.success:
        emit(ProfileLoadedState(rawData.data));
        break;
      case OperationResult.fail:
        emit(ProfileErrorState(rawData.data));
        break;
      case null:
        emit(ProfileErrorState('Some Thing went wrong'));
        break;
    }
  }
}
