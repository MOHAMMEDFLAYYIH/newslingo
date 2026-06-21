import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';

class ManageVocabulary {
  final NewsRepository repository;

  ManageVocabulary(this.repository);

  Future<void> saveWord(SavedWord word) {
    return repository.saveWord(word);
  }

  Future<List<SavedWord>> getSavedWords() {
    return repository.getSavedWords();
  }

  Future<void> updateWordReview(SavedWord word) {
    return repository.updateWordReview(word);
  }
}
