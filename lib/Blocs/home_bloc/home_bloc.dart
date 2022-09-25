import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:blog_app/data/repositories/home_repository.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  final UserRepositories _userRepository;
  HomeBloc({HomeRepository? homeRepository, UserRepositories? userRepository})
      : _homeRepository = homeRepository ?? HomeRepository(),
        _userRepository = userRepository ?? UserRepositories(),
        super(HomeLoadingState()) {
    on<LoadAllArticleEvent>(_loadAllArticle);
    on<LoadSavedArticlesEvent>(_loadSavedArticles);
    on<SaveArticleEvent>(_saveArticle);
    // on<RemoveSavedArticleEvent>(_removeArticle);
    on<GetProfileInfoEvent>(_getProfileInfo);
  }
  List<Article> _allArticles = [];

  FutureOr<void> _loadAllArticle(
      LoadAllArticleEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    print('called');
    RawData rawData = await _homeRepository.fetchAllPost();
    RawData rawProfileData = await _userRepository.getProfileInfo();
    if (rawData.operationResult == OperationResult.success &&
        rawProfileData.operationResult == OperationResult.success) {
      _allArticles = rawData.data;
      emit(HomeLoadedState(rawData.data, amataUser: rawProfileData.data));
    }
    if (rawData.operationResult == OperationResult.fail) {
      emit(HomeErrorState(rawData.data));
    }
  }

  FutureOr<void> _loadSavedArticles(
      LoadSavedArticlesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    RawData rawData =
        await _homeRepository.fetchSavedArticle(event.currentUserUid.uid);
    if (rawData.operationResult == OperationResult.success) {
      emit(HomeLoadedState(rawData.data));
    }
    if (rawData.operationResult == OperationResult.fail) {
      emit(HomeErrorState(rawData.data));
    }
  }

  FutureOr<void> _saveArticle(
      SaveArticleEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    RawData rawData = await _userRepository.saveArticleToReadingList(
        article: event.selectedArticle);
    if (rawData.operationResult == OperationResult.success) {
      emit(HomeArticleSavedState());
      emit(HomeLoadedState(_allArticles));
    }
    if (rawData.operationResult == OperationResult.fail) {
      emit(ArticleSaveErrorState(rawData.data));
      emit(HomeLoadedState(_allArticles));

      // add(LoadAllArticleEvent());
    }
  }

  // FutureOr<void> _removeArticle(
  //     RemoveSavedArticleEvent event, Emitter<HomeState> emit) async {
  //   emit(HomeLoadingState());
  //   RawData rawData = await _userRepository.deleteArticleReadingList(
  //       user: event.currentUser, article: event.selectedArticle);
  //   if (rawData.operationResult == OperationResult.success) {
  //     emit(HomeLoadedState(_allArticles));
  //   }
  //   if (rawData.operationResult == OperationResult.fail) {
  //     emit(HomeErrorState(rawData.data));
  //   }
  // }

  FutureOr<void> _getProfileInfo(
      GetProfileInfoEvent event, Emitter<HomeState> emit) async {
    RawData rawData = await _userRepository.getProfileInfo();
    if (rawData.operationResult == OperationResult.success) {}
    if (rawData.operationResult == OperationResult.fail) {
      emit(HomeErrorState(rawData.data));
    }
  }
}
