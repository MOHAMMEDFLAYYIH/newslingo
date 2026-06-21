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
    const limit = 20;
    final from = (page - 1) * limit;
    var query = _client.from('articles').select('*');
    if (category != null) query = query.eq('category', category);
    if (level != null) query = query.eq('level', level);
    final data = await query
        .order('published_at', ascending: false)
        .range(from, from + limit - 1);
    return data.map((e) => ArticleModel.fromJson(e)).toList();
  }

  Future<ArticleModel> getArticleById(String id) async {
    final data = await _client
        .from('articles')
        .select('*')
        .eq('id', id)
        .single();
    return ArticleModel.fromJson(data);
  }

  Future<List<WordDefinitionModel>> getWordDefinitions(
    String articleId,
    String word,
  ) async {
    final data = await _client
        .from('articles')
        .select('vocabulary')
        .eq('id', articleId)
        .single();
    final vocab = data['vocabulary'] as List<dynamic>? ?? [];
    final entry = vocab.firstWhere(
      (v) => (v as Map<String, dynamic>)['word'] == word,
      orElse: () => null,
    );
    if (entry == null) return [];
    final def = entry as Map<String, dynamic>;
    return [
      WordDefinitionModel(
        word: def['word'] as String,
        definition: def['definition'] as String? ?? '',
        translation: def['translation'] as String? ?? '',
        synonyms: (def['synonyms'] as List<dynamic>?)?.cast<String>() ?? [],
        examples: (def['examples'] as List<dynamic>?)?.cast<String>() ?? [],
        partOfSpeech: def['part_of_speech'] as String? ?? '',
      ),
    ];
  }

  Future<QuizModel> getQuizForArticle(String articleId) async {
    final data = await _client
        .from('articles')
        .select('quiz')
        .eq('id', articleId)
        .single();
    return QuizModel.fromJson(data['quiz'] as Map<String, dynamic>);
  }
}
