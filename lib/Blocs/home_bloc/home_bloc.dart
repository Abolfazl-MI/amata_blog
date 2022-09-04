import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:blog_app/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  HomeBloc({HomeRepository? homeRepository})
      : _homeRepository = homeRepository ?? HomeRepository(),
        super(HomeLoadingState()) {
    on<LoadAllArticleEvent>(_loadAllArticle);
    on<LoadSavedArticlesEvent>(_loadSavedArticles);
    on<SaveArticleEvent>(_saveArticle);
    on<RemoveSavedArticleEvent>(_removeArticle);
    on<GetProfileInfoEvent>(_getProfileInfo);
  }

  FutureOr<void> _loadAllArticle(
      LoadAllArticleEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    RawData rawData = await _homeRepository.fetchAllPost();
    if (rawData.operationResult == OperationResult.success) {
      emit(HomeLoadedState(rawData.data));
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
      SaveArticleEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> _removeArticle(
      RemoveSavedArticleEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> _getProfileInfo(
      GetProfileInfoEvent event, Emitter<HomeState> emit) {}
}
