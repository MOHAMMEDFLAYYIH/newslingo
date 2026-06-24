import 'dart:async';
import 'dart:developer';
import 'package:newslingo/core/services/article_processor.dart';
import 'package:newslingo/data/datasources/local/news_local_datasource.dart';
import 'package:newslingo/data/models/article_model.dart';

class ArticleBatchProcessor {
  final NewsLocalDataSource _localDataSource;

  ArticleBatchProcessor(this._localDataSource);

  Future<int> processAllCached() async {
    try {
      final articles = await _localDataSource.getCachedArticles();
      int processedCount = 0;

      for (final model in articles) {
        if (model.segments.isNotEmpty) continue;

        final segments = ArticleProcessor.process(
          model.content,
          model.vocabulary.map((v) => v.toEntity()).toList(),
        );

        if (segments.isEmpty) continue;

        final updated = ArticleModel(
          id: model.id,
          title: model.title,
          description: model.description,
          content: model.content,
          category: model.category,
          source: model.source,
          imageUrl: model.imageUrl,
          audioUrl: model.audioUrl,
          level: model.level,
          publishedAt: model.publishedAt,
          tags: model.tags,
          translatedTitle: model.translatedTitle,
          translatedDescription: model.translatedDescription,
          translatedContent: model.translatedContent,
          vocabulary: model.vocabulary,
          quiz: model.quiz,
          segments: segments,
        );

        await _localDataSource.updateArticle(updated);
        processedCount++;
      }

      log('[ArticleBatchProcessor] Processed $processedCount cached articles');
      return processedCount;
    } catch (e) {
      log('[ArticleBatchProcessor] Error: $e');
      return 0;
    }
  }
}
