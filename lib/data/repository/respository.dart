import 'package:intro_to_bloc/data/models/Article.dart';
import 'package:intro_to_bloc/data/web%20servieces/web_provider.dart';

class NewsRepository {
  final DataProvider dataProvider = DataProvider();

  Future<List<Article>> getArticles(String categoryName, String country) async {
    return await dataProvider.getArticles(categoryName, country);
  }
}