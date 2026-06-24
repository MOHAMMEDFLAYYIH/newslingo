import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';

class GetArticles {
  final NewsRepository repository;

  GetArticles(this.repository);

  Future<List<Article>> call({String? category, String? level, int page = 1}) {
    return repository.getArticles(category: category, level: level, page: page);
  }
}
