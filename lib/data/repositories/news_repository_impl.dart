import 'package:newslingo/core/services/deepl_service.dart';
import 'package:newslingo/data/datasources/local/article_translation_cache.dart';
import 'package:newslingo/data/datasources/local/news_local_datasource.dart';
import 'package:newslingo/data/datasources/remote/auth_remote_datasource.dart';
import 'package:newslingo/data/datasources/remote/news_remote_datasource.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final AuthRemoteDataSource authRemoteDataSource;
  final DeepLService deepLService;
  final ArticleTranslationCache translationCache;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.authRemoteDataSource,
    required this.deepLService,
    required this.translationCache,
  });

  @override
  Future<List<Article>> getArticles({
    String? category,
    String? level,
    int page = 1,
  }) async {
    try {
      final remote = await remoteDataSource.getArticles(
        category: category,
        level: level,
        page: page,
      );
      await localDataSource.cacheArticles(remote);
      return remote.map((e) => e.toEntity()).toList();
    } catch (_) {
      final cached = await localDataSource.getCachedArticles(
        category: category,
        page: page,
      );
      return cached.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Future<Article> getArticleById(String id) async {
    try {
      final remote = await remoteDataSource.getArticleById(id);
      return remote.toEntity();
    } catch (_) {
      final cached = await localDataSource.getCachedArticle(id);
      if (cached != null) return cached.toEntity();
      rethrow;
    }
  }

  @override
  Future<List<WordDefinition>> getWordDefinitions(
    String articleId,
    String word,
  ) async {
    final remote = await remoteDataSource.getWordDefinitions(articleId, word);
    return remote.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Quiz> getQuizForArticle(String articleId) async {
    final remote = await remoteDataSource.getQuizForArticle(articleId);
    return remote.toEntity();
  }

  @override
  Future<void> saveWord(SavedWord word) async {
    await localDataSource.saveWord(word);
    try {
      await authRemoteDataSource.saveWord({
        'word': word.word,
        'definition': word.definition,
        'translation': word.translation,
        'article_id': word.articleId,
        'review_count': word.reviewCount,
      });
    } catch (_) {}
  }

  @override
  Future<List<SavedWord>> getSavedWords() async {
    return localDataSource.getSavedWords();
  }

  @override
  Future<void> updateWordReview(SavedWord word) async {
    await localDataSource.updateWordReview(word);
  }

  @override
  Future<UserProgress> getUserProgress() async {
    final data = await localDataSource.getProgress();
    if (data == null) {
      return UserProgress(
        streak: 0,
        articlesRead: 0,
        wordsLearned: 0,
        quizzesPassed: 0,
        lastActiveDate: DateTime(2000),
      );
    }
    return UserProgress(
      streak: data['streak'] as int? ?? 0,
      articlesRead: data['articles_read'] as int? ?? 0,
      wordsLearned: data['words_learned'] as int? ?? 0,
      quizzesPassed: data['quizzes_passed'] as int? ?? 0,
      lastActiveDate: data['last_active_date'] != null
          ? DateTime.parse(data['last_active_date'] as String)
          : DateTime(2000),
    );
  }

  @override
  Future<void> updateUserProgress(UserProgress progress) async {
    await localDataSource.saveProgress({
      'streak': progress.streak,
      'articles_read': progress.articlesRead,
      'words_learned': progress.wordsLearned,
      'quizzes_passed': progress.quizzesPassed,
      'last_active_date': progress.lastActiveDate.toIso8601String(),
    });
    try {
      await authRemoteDataSource.updateProgress({
        'streak': progress.streak,
        'articles_read': progress.articlesRead,
        'words_learned': progress.wordsLearned,
        'quizzes_passed': progress.quizzesPassed,
        'last_active_date': progress.lastActiveDate.toIso8601String(),
      });
    } catch (_) {}
  }

  @override
  Future<void> markArticleRead(String articleId) async {
    final progress = await getUserProgress();
    final updated = UserProgress(
      streak: progress.streak,
      articlesRead: progress.articlesRead + 1,
      wordsLearned: progress.wordsLearned,
      quizzesPassed: progress.quizzesPassed,
      lastActiveDate: DateTime.now(),
    );
    await updateUserProgress(updated);
  }

  @override
  Future<void> bookmarkArticle(String articleId) async {
    await localDataSource.bookmarkArticle(articleId);
    try {
      await authRemoteDataSource.bookmarkArticle(articleId);
    } catch (_) {}
  }

  @override
  Future<void> unbookmarkArticle(String articleId) async {
    await localDataSource.unbookmarkArticle(articleId);
    try {
      await authRemoteDataSource.unbookmarkArticle(articleId);
    } catch (_) {}
  }

  @override
  Future<bool> isArticleBookmarked(String articleId) async {
    return localDataSource.isArticleBookmarked(articleId);
  }

  @override
  Future<List<Article>> getBookmarkedArticles() async {
    final models = await localDataSource.getBookmarkedArticles();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Article>> translateArticles(
    List<Article> articles,
    String targetLocale,
  ) async {
    if (targetLocale == 'en' || articles.isEmpty) return articles;
    final targetCode = DeepLService.targetCode(targetLocale);

    final ids = articles.map((a) => a.id).toList();
    final cached =
        await translationCache.getAllForLocale(ids, targetLocale);

    final result = <Article>[];
    final toTranslateIds = <String>[];
    final toTranslateTexts = <String>[];

    for (final a in articles) {
      final c = cached[a.id];
      if (c != null) {
        result.add(a.copyWith(
          translatedTitle: c.title,
          translatedDescription: c.description,
          translatedContent: c.content,
        ));
      } else {
        toTranslateIds.add(a.id);
        toTranslateTexts.add(a.title);
        toTranslateTexts.add(a.description);
      }
    }

    if (toTranslateIds.isNotEmpty) {
      try {
        final translated = await deepLService.translateBatch(
          toTranslateTexts,
          targetLang: targetCode,
        );
        final translations = <ArticleTranslation>[];
        for (int i = 0; i < toTranslateIds.length; i++) {
          final title = translated[i * 2];
          final desc = translated[i * 2 + 1];
          translations.add(ArticleTranslation(
            title: title,
            description: desc,
            cachedAt: DateTime.now(),
          ));
          result.add(articles.firstWhere((a) => a.id == toTranslateIds[i]).copyWith(
            translatedTitle: title,
            translatedDescription: desc,
          ));
        }
        await translationCache.saveBatch(
          toTranslateIds,
          targetLocale,
          translations,
        );
      } catch (_) {
        for (final a in articles) {
          if (!result.any((r) => r.id == a.id)) {
            result.add(a);
          }
        }
      }
    }

    result.sort((a, b) => ids.indexOf(a.id).compareTo(ids.indexOf(b.id)));
    return result;
  }
}
