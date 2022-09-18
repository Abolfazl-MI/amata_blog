part of 'saved_article_cubit.dart';

abstract class SavedArticleState extends Equatable {
  const SavedArticleState();

  @override
  List<Object> get props => [];
}

class SavedArticleLoadingState extends SavedArticleState {}

class SavedArticleLoadedState extends SavedArticleState {
  final List<Article> savedArticles;

  SavedArticleLoadedState(this.savedArticles);
}

class SavedArticleErrorState extends SavedArticleState {
  final String errorMsg;

  SavedArticleErrorState(this.errorMsg);
}
