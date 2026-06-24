import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';
import 'package:newslingo/presentation/cubit/news/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository repository;

  NewsCubit(this.repository) : super(const NewsState()) {
    debugPrint('[NewsCubit] Created with initial state: ${state.status}');
  }

  Future<void> loadArticles({
    String? category,
    String? level,
    String? locale,
  }) async {
    debugPrint('[NewsCubit] loadArticles called — category: $category, level: $level, locale: $locale');

    if (state.status == NewsStatus.initial) {
      debugPrint('[NewsCubit] Emitting loading...');
      emit(state.copyWith(status: NewsStatus.loading));
    }

    try {
      debugPrint('[NewsCubit] Fetching articles from repository...');
      var articles = await repository.getArticles(
        category: category ?? state.category,
        level: level ?? state.level,
      );
      debugPrint('[NewsCubit] Repository returned ${articles.length} articles');

      // Articles stay in English regardless of UI locale

      debugPrint('[NewsCubit] Emitting loaded with ${articles.length} articles');
      emit(
        state.copyWith(
          status: NewsStatus.loaded,
          articles: articles,
          currentPage: 1,
          category: category ?? state.category,
          level: level ?? state.level,
          errorMessage: null,
        ),
      );
    } catch (e, stack) {
      debugPrint('[NewsCubit] ERROR: $e');
      debugPrint('[NewsCubit] Stack: $stack');
      emit(
        state.copyWith(status: NewsStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> refresh({String? locale}) async {
    emit(state.copyWith(status: NewsStatus.loading));
    await loadArticles(locale: locale);
  }

  void filterByCategory(String? category, {String? locale}) {
    loadArticles(category: category, locale: locale);
  }

  void filterByLevel(String? level, {String? locale}) {
    loadArticles(level: level, locale: locale);
  }
}
