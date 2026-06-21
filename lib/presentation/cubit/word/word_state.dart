import 'package:equatable/equatable.dart';
import 'package:newslingo/domain/entities/article.dart';

class WordState extends Equatable {
  final bool isLoading;
  final List<SavedWord> savedWords;
  final int dailyCount;
  final String? errorMessage;

  const WordState({
    this.isLoading = false,
    this.savedWords = const [],
    this.dailyCount = 0,
    this.errorMessage,
  });

  WordState copyWith({
    bool? isLoading,
    List<SavedWord>? savedWords,
    int? dailyCount,
    String? errorMessage,
  }) {
    return WordState(
      isLoading: isLoading ?? this.isLoading,
      savedWords: savedWords ?? this.savedWords,
      dailyCount: dailyCount ?? this.dailyCount,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, savedWords, dailyCount, errorMessage];
}
