import 'dart:convert';
import 'package:hive/hive.dart';

class ArticleTranslation {
  final String title;
  final String description;
  final String? content;
  final DateTime cachedAt;

  const ArticleTranslation({
    required this.title,
    required this.description,
    this.content,
    required this.cachedAt,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'content': content,
        'cached_at': cachedAt.toIso8601String(),
      };

  factory ArticleTranslation.fromJson(Map<String, dynamic> json) =>
      ArticleTranslation(
        title: json['title'] as String,
        description: json['description'] as String,
        content: json['content'] as String?,
        cachedAt: DateTime.parse(json['cached_at'] as String),
      );
}

class ArticleTranslationCache {
  static const String _box = 'article_translations';
  static const Duration _ttl = Duration(hours: 24);

  String _key(String articleId, String locale) =>
      '${articleId}_$locale';

  Future<void> save(
    String articleId,
    String locale,
    ArticleTranslation translation,
  ) async {
    final box = await Hive.openBox<String>(_box);
    await box.put(_key(articleId, locale), jsonEncode(translation.toJson()));
  }

  Future<ArticleTranslation?> get(
    String articleId,
    String locale,
  ) async {
    final box = await Hive.openBox<String>(_box);
    final data = box.get(_key(articleId, locale));
    if (data == null) return null;
    try {
      final t = ArticleTranslation.fromJson(jsonDecode(data) as Map<String, dynamic>);
      if (DateTime.now().difference(t.cachedAt) > _ttl) return null;
      return t;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, ArticleTranslation>> getAllForLocale(
    List<String> articleIds,
    String locale,
  ) async {
    final box = await Hive.openBox<String>(_box);
    final result = <String, ArticleTranslation>{};
    for (final id in articleIds) {
      final data = box.get(_key(id, locale));
      if (data == null) continue;
      try {
        final t = ArticleTranslation.fromJson(
            jsonDecode(data) as Map<String, dynamic>);
        if (DateTime.now().difference(t.cachedAt) <= _ttl) {
          result[id] = t;
        }
      } catch (_) {}
    }
    return result;
  }

  Future<void> saveBatch(
    List<String> articleIds,
    String locale,
    List<ArticleTranslation> translations,
  ) async {
    final box = await Hive.openBox<String>(_box);
    for (int i = 0; i < articleIds.length; i++) {
      await box.put(
        _key(articleIds[i], locale),
        jsonEncode(translations[i].toJson()),
      );
    }
  }
}
