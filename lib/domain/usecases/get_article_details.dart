import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';

class GetArticleDetails {
  final NewsRepository repository;

  GetArticleDetails(this.repository);

  Future<Article> call(String id) {
    return repository.getArticleById(id);
  }
}
