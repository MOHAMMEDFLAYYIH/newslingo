import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';

class GetWordDefinitions {
  final NewsRepository repository;

  GetWordDefinitions(this.repository);

  Future<List<WordDefinition>> call(String articleId, String word) {
    return repository.getWordDefinitions(articleId, word);
  }
}
