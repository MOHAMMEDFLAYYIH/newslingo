import 'package:newslingo/domain/entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getArticles({
    String? category,
    String? level,
    int page = 1,
  });
  Future<Article> getArticleById(String id);
  Future<List<WordDefinition>> getWordDefinitions(
    String articleId,
    String word,
  );
  Future<Quiz> getQuizForArticle(String articleId);
  Future<void> saveWord(SavedWord word);
  Future<void> deleteWord(String word);
  Future<List<SavedWord>> getSavedWords();
  Future<void> updateWordReview(SavedWord word);
  Future<UserProgress> getUserProgress();
  Future<void> updateUserProgress(UserProgress progress);
  Future<void> markArticleRead(String articleId);
  Future<void> bookmarkArticle(String articleId);
  Future<void> unbookmarkArticle(String articleId);
  Future<bool> isArticleBookmarked(String articleId);
  Future<List<Article>> getBookmarkedArticles();
  Future<List<Article>> translateArticles(
    List<Article> articles,
    String targetLocale,
  );
}
