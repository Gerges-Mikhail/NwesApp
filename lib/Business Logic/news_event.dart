part of 'news_bloc.dart';
@immutable
class NewsEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetArticlesEvent extends NewsEvent {
  String categoryName;
  String countryName;
  GetArticlesEvent(
      {this.categoryName = 'topheadlines', this.countryName = 'eg'});
}