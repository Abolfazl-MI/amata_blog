part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Article> articles;

  const HomeLoadedState(this.articles);
}

class HomeErrorState extends HomeState {
  final String error;
  const HomeErrorState(this.error);
}
