import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';
import 'package:newslingo/presentation/cubit/news/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository repository;

  NewsCubit(this.repository) : super(const NewsState());

  Future<void> loadArticles({String? category, String? level, String? locale}) async {
    if (state.status == NewsStatus.initial) {
      emit(state.copyWith(status: NewsStatus.loading));
    }

    try {
      var articles = await repository.getArticles(
        category: category ?? state.category,
        level: level ?? state.level,
      );
      if (locale != null && locale != 'en') {
        articles = await repository.translateArticles(articles, locale);
      }
      emit(state.copyWith(
        status: NewsStatus.loaded,
        articles: articles,
        currentPage: 1,
        category: category ?? state.category,
        level: level ?? state.level,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewsStatus.error,
        errorMessage: e.toString(),
      ));
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
