import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/usecases/get_user_progress.dart';
import 'package:newslingo/presentation/cubit/progress/progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final GetUserProgress getUserProgress;
  final UpdateUserProgress updateUserProgress;

  ProgressCubit(this.getUserProgress, this.updateUserProgress)
    : super(ProgressState());

  Future<void> loadProgress() async {
    emit(state.copyWith(status: ProgressStatus.loading));
    try {
      final progress = await getUserProgress();
      emit(state.copyWith(status: ProgressStatus.loaded, progress: progress));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProgressStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  int _calculateStreak(int currentStreak, DateTime lastActive) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = DateTime(lastActive.year, lastActive.month, lastActive.day);
    final diff = today.difference(last).inDays;

    if (diff == 0) return currentStreak;
    if (diff == 1) return currentStreak + 1;
    return 1;
  }

  Future<void> markArticleRead() async {
    final streak = _calculateStreak(
      state.progress.streak,
      state.progress.lastActiveDate,
    );
    final updated = UserProgress(
      streak: streak,
      articlesRead: state.progress.articlesRead + 1,
      wordsLearned: state.progress.wordsLearned,
      quizzesPassed: state.progress.quizzesPassed,
      lastActiveDate: DateTime.now(),
    );
    await updateUserProgress(updated);
    emit(state.copyWith(progress: updated));
  }

  Future<void> loadAndMarkQuizPassed() async {
    await loadProgress();
    await markQuizPassed();
  }

  Future<void> markQuizPassed() async {
    final streak = _calculateStreak(
      state.progress.streak,
      state.progress.lastActiveDate,
    );
    final updated = UserProgress(
      streak: streak,
      articlesRead: state.progress.articlesRead,
      wordsLearned: state.progress.wordsLearned,
      quizzesPassed: state.progress.quizzesPassed + 1,
      lastActiveDate: DateTime.now(),
    );
    await updateUserProgress(updated);
    emit(state.copyWith(progress: updated));
  }
}
