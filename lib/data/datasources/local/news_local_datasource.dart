import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:newslingo/data/models/article_model.dart';
import 'package:newslingo/domain/entities/article.dart';

class NewsLocalDataSource {
  static const String _articlesBox = 'articles';
  static const String _wordsBox = 'saved_words';
  static const String _progressBox = 'user_progress';
  static const String _bookmarksBox = 'bookmarked_articles';

  Future<Box> _openBox(String name) {
    if (Hive.isBoxOpen(name)) return Future.value(Hive.box<String>(name));
    try {
      return Hive.openBox<String>(name);
    } on HiveError {
      return Future.value(Hive.box<String>(name));
    }
  }

  Future<Box> _openBoolBox(String name) {
    if (Hive.isBoxOpen(name)) return Future.value(Hive.box<bool>(name));
    try {
      return Hive.openBox<bool>(name);
    } on HiveError {
      return Future.value(Hive.box<bool>(name));
    }
  }

  Future<List<ArticleModel>> getCachedArticles({
    String? category,
    int page = 1,
  }) async {
    final box = await _openBox(_articlesBox) as Box<String>;
    final keys = box.keys.toList();

    List<ArticleModel> articles = [];
    for (final key in keys) {
      final data = box.get(key);
      if (data != null) {
        final model = ArticleModel.fromJson(
          jsonDecode(data) as Map<String, dynamic>,
        );
        if (category == null || model.category == category) {
          articles.add(model);
        }
      }
    }

    articles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    return articles;
  }

  Future<void> cacheArticles(List<ArticleModel> articles) async {
    final box = await _openBox(_articlesBox) as Box<String>;
    for (final article in articles) {
      await box.put(article.id, jsonEncode(article.toJson()));
    }
  }

  Future<ArticleModel?> getCachedArticle(String id) async {
    final box = await _openBox(_articlesBox) as Box<String>;
    final data = box.get(id);
    if (data == null) return null;
    return ArticleModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  Future<void> updateArticle(ArticleModel article) async {
    final box = await _openBox(_articlesBox) as Box<String>;
    await box.put(article.id, jsonEncode(article.toJson()));
  }

  Future<void> deleteWord(String word) async {
    final box = await _openBox(_wordsBox) as Box<String>;
    await box.delete(word);
  }

  Future<void> saveWord(SavedWord word) async {
    final box = await _openBox(_wordsBox) as Box<String>;
    await box.put(
      word.word,
      jsonEncode({
        'word': word.word,
        'definition': word.definition,
        'translation': word.translation,
        'article_id': word.articleId,
        'saved_at': word.savedAt.toIso8601String(),
        'review_count': word.reviewCount,
        'next_review_date': word.nextReviewDate?.toIso8601String(),
      }),
    );
  }

  Future<List<SavedWord>> getSavedWords() async {
    final box = await _openBox(_wordsBox) as Box<String>;
    final words = <SavedWord>[];
    for (final key in box.keys) {
      final data = box.get(key);
      if (data != null) {
        final json = jsonDecode(data) as Map<String, dynamic>;
        try {
          words.add(
            SavedWord(
              word: json['word'] as String? ?? '',
              definition: json['definition'] as String? ?? '',
              translation: json['translation'] as String? ?? '',
              articleId: json['article_id'] as String? ?? '',
              savedAt: json['saved_at'] != null
                  ? DateTime.parse(json['saved_at'] as String)
                  : DateTime.now(),
              reviewCount: json['review_count'] as int? ?? 0,
              nextReviewDate: json['next_review_date'] != null
                  ? DateTime.parse(json['next_review_date'] as String)
                  : null,
            ),
          );
        } catch (_) {
          continue;
        }
      }
    }
    return words;
  }

  Future<void> updateWordReview(SavedWord word) async {
    final box = await _openBox(_wordsBox) as Box<String>;
    final existingData = box.get(word.word);
    if (existingData != null) {
      final json = jsonDecode(existingData) as Map<String, dynamic>;
      json['review_count'] = word.reviewCount;
      json['next_review_date'] = word.nextReviewDate?.toIso8601String();
      await box.put(word.word, jsonEncode(json));
    }
  }

  Future<void> saveProgress(Map<String, dynamic> progress) async {
    final box = await _openBox(_progressBox) as Box<String>;
    await box.put('progress', jsonEncode(progress));
  }

  Future<Map<String, dynamic>?> getProgress() async {
    final box = await _openBox(_progressBox) as Box<String>;
    final data = box.get('progress');
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<void> bookmarkArticle(String articleId) async {
    final box = await _openBoolBox(_bookmarksBox) as Box<bool>;
    await box.put(articleId, true);
  }

  Future<void> unbookmarkArticle(String articleId) async {
    final box = await _openBoolBox(_bookmarksBox) as Box<bool>;
    await box.delete(articleId);
  }

  Future<bool> isArticleBookmarked(String articleId) async {
    final box = await _openBoolBox(_bookmarksBox) as Box<bool>;
    return box.get(articleId, defaultValue: false) ?? false;
  }

  Future<List<String>> getBookmarkedArticleIds() async {
    final box = await _openBoolBox(_bookmarksBox) as Box<bool>;
    return box.keys.where((k) => box.get(k) == true).cast<String>().toList();
  }

  Future<List<ArticleModel>> getBookmarkedArticles() async {
    final ids = await getBookmarkedArticleIds();
    final articles = <ArticleModel>[];
    for (final id in ids) {
      final article = await getCachedArticle(id);
      if (article != null) articles.add(article);
    }
    return articles;
  }
}
