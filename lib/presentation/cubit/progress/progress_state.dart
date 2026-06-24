import 'package:equatable/equatable.dart';
import 'package:newslingo/domain/entities/article.dart';

enum ProgressStatus { initial, loading, loaded, error }

class ProgressState extends Equatable {
  final ProgressStatus status;
  final UserProgress progress;
  final String? errorMessage;

  ProgressState({
    this.status = ProgressStatus.initial,
    UserProgress? progress,
    this.errorMessage,
  }) : progress =
           progress ??
           UserProgress(
             streak: 0,
             articlesRead: 0,
             wordsLearned: 0,
             quizzesPassed: 0,
             lastActiveDate: DateTime(2000),
           );

  ProgressState copyWith({
    ProgressStatus? status,
    UserProgress? progress,
    String? errorMessage,
  }) {
    return ProgressState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, progress, errorMessage];
}
