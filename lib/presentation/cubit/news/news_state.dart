import 'package:equatable/equatable.dart';
import 'package:newslingo/domain/entities/article.dart';

enum NewsStatus { initial, loading, loaded, error }

class NewsState extends Equatable {
  final NewsStatus status;
  final List<Article> articles;
  final String? category;
  final String? level;
  final int currentPage;
  final bool hasMore;
  final String? errorMessage;

  const NewsState({
    this.status = NewsStatus.initial,
    this.articles = const [],
    this.category,
    this.level,
    this.currentPage = 1,
    this.hasMore = true,
    this.errorMessage,
  });

  NewsState copyWith({
    NewsStatus? status,
    List<Article>? articles,
    String? category,
    String? level,
    int? currentPage,
    bool? hasMore,
    String? errorMessage,
  }) {
    return NewsState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      category: category ?? this.category,
      level: level ?? this.level,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        articles,
        category,
        level,
        currentPage,
        hasMore,
        errorMessage,
      ];
}
