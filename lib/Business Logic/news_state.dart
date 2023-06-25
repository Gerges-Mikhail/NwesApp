part of 'news_bloc.dart';

class NewsState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsErrorState extends NewsState {}

class NewsSuccessState extends NewsState {
  final List<Article> articles;
  NewsSuccessState(this.articles);
}