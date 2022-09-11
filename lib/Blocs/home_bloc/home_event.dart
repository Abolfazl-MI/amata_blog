part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadAllArticleEvent extends HomeEvent {}

class LoadSavedArticlesEvent extends HomeEvent {
  final User currentUserUid;

  const LoadSavedArticlesEvent(this.currentUserUid);
}

class SaveArticleEvent extends HomeEvent {
  final Article selectedArticle;
  final AmataUser currentUser;

  const SaveArticleEvent(this.selectedArticle, this.currentUser);
}

class RemoveSavedArticleEvent extends HomeEvent {
  final Article selectedArticle;
  final User currentUser;

  const RemoveSavedArticleEvent(this.selectedArticle, this.currentUser);
}

class GetProfileInfoEvent extends HomeEvent {}
