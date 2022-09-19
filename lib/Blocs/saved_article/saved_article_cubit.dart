import 'package:bloc/bloc.dart';
import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'saved_article_state.dart';

class SavedArticleCubit extends Cubit<SavedArticleState> {
  final UserRepository _userRepository;
  SavedArticleCubit({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository(),
        super(SavedArticleLoadingState());

  Future getUserSavedArticles() async {
    RawData rawData = await UserRepository().getUserSavedArticle();
    if (rawData.operationResult == OperationResult.success) {
      emit(SavedArticleLoadedState(rawData.data));
    }
    if (rawData.operationResult == OperationResult.fail) {
      emit(SavedArticleErrorState(rawData.data));
    }
  }

  //  removes article from reading list
  Future removeArticle(Article article) async {
    emit(SavedArticleLoadingState());
    RawData rawData =
        await _userRepository.deleteArticleReadingList(article: article);

    if (rawData.operationResult == OperationResult.success) {
      await getUserSavedArticles();
    }
    if (rawData.operationResult == OperationResult.fail) {
      emit(SavedArticleErrorState(rawData.data));
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
}
