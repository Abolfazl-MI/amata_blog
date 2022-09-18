import 'package:bloc/bloc.dart';
import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'saved_article_state.dart';

class SavedArticleCubit extends Cubit<SavedArticleState> {
  SavedArticleCubit() : super(SavedArticleLoadingState());

  Future getUserSavedArticles() async {
    RawData rawData = await UserRepository().getUserSavedArticle();
    if (rawData.operationResult == OperationResult.success) {
      emit(SavedArticleLoadedState(rawData.data));
    }
    if (rawData.operationResult == OperationResult.fail) {
      emit(SavedArticleErrorState(rawData.data));
    }
  }
}
