import 'dart:convert';
import 'dart:developer';
import 'package:newslingo/data/models/article_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsRemoteDataSource {
  final SupabaseClient _client;

  NewsRemoteDataSource(this._client);

  Future<List<ArticleModel>> getArticles({
    String? category,
    String? level,
    int page = 1,
  }) async {
    try {
      const limit = 20;
      final from = (page - 1) * limit;
      var query = _client.from('articles').select('*');
      log('[Supabase] Query: articles.select(*) — category: $category, level: $level, range: [$from, ${from + limit - 1}]');
      if (category != null) {
        log('[Supabase] Adding filter: category = $category');
        query = query.eq('category', category);
      }
      if (level != null) {
        log('[Supabase] Adding filter: base_level = $level');
        query = query.eq('base_level', level);
      }
      log('[Supabase] Executing query...');
      final data = await query
          .order('published_at', ascending: false)
          .range(from, from + limit - 1);
      log('[Supabase] Got ${data.length} rows');
      if (data.isNotEmpty) {
        log('[Supabase] Row 0 keys: ${(data[0] as Map).keys}');
        log('[Supabase] Row 0 base_level: ${data[0]['base_level']}');
        log('[Supabase] Row 0 content_b1: ${(data[0]['content_b1'] as String?)?.substring(0, 50)}...');
      }
      return data.map((e) {
        final model = ArticleModel.fromJson(e);
        log('[ArticleModel] Mapped: id=${model.id} title=${model.title.substring(0, 30)} content_len=${model.content.length} level=${model.level}');
        return model;
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }

  Future<ArticleModel> getArticleById(String id) async {
    try {
      final data = await _client
          .from('articles')
          .select('*')
          .eq('id', id)
          .single();
      return ArticleModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch article $id: $e');
    }
  }

  /// Parse the `vocabulary` column safely — it may be List, String (JSON), or null.
  List<Map<String, dynamic>> _safeVocabList(dynamic raw) {
    if (raw is List) {
      return raw.whereType<Map<String, dynamic>>().toList();
    }
    if (raw is String) {
      try {
        final parsed = json.decode(raw);
        if (parsed is List) {
          return parsed.whereType<Map<String, dynamic>>().toList();
        }
      } catch (_) {}
    }
    return [];
  }

  Future<List<WordDefinitionModel>> getWordDefinitions(
    String articleId,
    String word,
  ) async {
    try {
      final data = await _client
          .from('articles')
          .select('vocabulary')
          .eq('id', articleId)
          .single();
      final vocab = _safeVocabList(data['vocabulary']);
      for (final v in vocab) {
        if (v['_type'] == 'quiz') continue;
        if (v['word'] == word) {
          return [
            WordDefinitionModel(
              word: v['word'] as String,
              definition: v['definition'] as String? ?? '',
              translation: v['translation'] as String? ?? '',
              synonyms:
                  (v['synonyms'] as List<dynamic>?)?.cast<String>() ?? [],
              examples:
                  (v['examples'] as List<dynamic>?)?.cast<String>() ?? [],
              partOfSpeech: v['part_of_speech'] as String? ?? '',
            ),
          ];
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch word definition for "$word" in article $articleId: $e');
    }
  }

  Future<QuizModel> getQuizForArticle(String articleId) async {
    try {
      final data = await _client
          .from('articles')
          .select('id,vocabulary')
          .eq('id', articleId)
          .single();
      final vocab = _safeVocabList(data['vocabulary']);
      Map<String, dynamic> quizEntry = const {};
      for (final v in vocab) {
        if (v['_type'] == 'quiz') {
          quizEntry = v;
          break;
        }
      }
      return QuizModel.fromJson({
        'id': data['id'],
        'article_id': articleId,
        'questions': (quizEntry['questions'] as List<dynamic>?) ?? [],
      });
    } catch (e) {
      throw Exception('Failed to fetch quiz for article $articleId: $e');
    }
  }
}
