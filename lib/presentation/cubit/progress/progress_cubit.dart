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
      emit(state.copyWith(
        status: ProgressStatus.loaded,
        progress: progress,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProgressStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> markArticleRead() async {
    final updated = UserProgress(
      streak: state.progress.streak,
      articlesRead: state.progress.articlesRead + 1,
      wordsLearned: state.progress.wordsLearned,
      quizzesPassed: state.progress.quizzesPassed,
      lastActiveDate: DateTime.now(),
    );
    await updateUserProgress(updated);
    emit(state.copyWith(progress: updated));
  }

  Future<void> markQuizPassed() async {
    final updated = UserProgress(
      streak: state.progress.streak,
      articlesRead: state.progress.articlesRead,
      wordsLearned: state.progress.wordsLearned,
      quizzesPassed: state.progress.quizzesPassed + 1,
      lastActiveDate: DateTime.now(),
    );
    await updateUserProgress(updated);
    emit(state.copyWith(progress: updated));
  }
}
