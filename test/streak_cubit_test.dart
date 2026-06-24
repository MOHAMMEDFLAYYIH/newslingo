import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/usecases/get_user_progress.dart';
import 'package:newslingo/presentation/cubit/progress/progress_cubit.dart';
import 'package:newslingo/presentation/cubit/progress/progress_state.dart';

class MockGetUserProgress extends Mock implements GetUserProgress {}

class MockUpdateUserProgress extends Mock implements UpdateUserProgress {}

void main() {
  late MockGetUserProgress mockGet;
  late MockUpdateUserProgress mockUpdate;
  late ProgressCubit cubit;

  setUpAll(() {
    registerFallbackValue(UserProgress(
      streak: 0,
      articlesRead: 0,
      wordsLearned: 0,
      quizzesPassed: 0,
      lastActiveDate: DateTime(2000),
    ));
  });

  setUp(() {
    mockGet = MockGetUserProgress();
    mockUpdate = MockUpdateUserProgress();
    cubit = ProgressCubit(mockGet, mockUpdate);

    when(() => mockGet()).thenAnswer((_) async => UserProgress(
      streak: 0,
      articlesRead: 0,
      wordsLearned: 0,
      quizzesPassed: 0,
      lastActiveDate: DateTime(2000),
    ));

    when(() => mockUpdate(any())).thenAnswer((_) async {});
  });

  tearDown(() {
    cubit.close();
  });

  // ── Streak calculation directly from _calculateStreak rules ──

  group('_calculateStreak', () {
    late ProgressCubit c;

    setUp(() {
      // We use loadProgress to get into a loaded state, then call
      // markArticleRead / markQuizPassed which invoke _calculateStreak.
      c = cubit;
    });

    test('preserves streak when last active is today', () async {
      when(() => mockGet()).thenAnswer((_) async => UserProgress(
        streak: 7,
        articlesRead: 0,
        wordsLearned: 0,
        quizzesPassed: 0,
        lastActiveDate: DateTime.now(),
      ));

      await c.loadProgress();
      await c.markQuizPassed();

      expect(c.state.progress.streak, 7);
    });

    test('increments streak when last active was yesterday', () async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      when(() => mockGet()).thenAnswer((_) async => UserProgress(
        streak: 5,
        articlesRead: 0,
        wordsLearned: 0,
        quizzesPassed: 0,
        lastActiveDate: yesterday,
      ));

      await c.loadProgress();
      await c.markArticleRead();

      expect(c.state.progress.streak, 6);
    });

    test('resets streak to 1 when last active is more than 1 day ago', () async {
      when(() => mockGet()).thenAnswer((_) async => UserProgress(
        streak: 10,
        articlesRead: 0,
        wordsLearned: 0,
        quizzesPassed: 0,
        lastActiveDate: DateTime(2020),
      ));

      await c.loadProgress();
      await c.markQuizPassed();

      expect(c.state.progress.streak, 1);
    });

    test('handles streak 0 fresh start correctly', () async {
      when(() => mockGet()).thenAnswer((_) async => UserProgress(
        streak: 0,
        articlesRead: 0,
        wordsLearned: 0,
        quizzesPassed: 0,
        lastActiveDate: DateTime(2000),
      ));

      await c.loadProgress();
      await c.markArticleRead();

      expect(c.state.progress.streak, 1);
    });
  });

  // ── Cubit state flow ──

  group('ProgressCubit', () {
    test('initial state has initial status', () {
      expect(cubit.state.status, ProgressStatus.initial);
      expect(cubit.state.progress.streak, 0);
    });

    test('loadProgress emits loading then loaded', () async {
      final loading = cubit.stream.firstWhere(
        (s) => s.status == ProgressStatus.loading,
      );
      final loaded = cubit.stream.firstWhere(
        (s) => s.status == ProgressStatus.loaded,
      );

      await cubit.loadProgress();

      await expectLater(loading, completion(isA<ProgressState>()));
      await expectLater(loaded, completion(isA<ProgressState>()));
    });

    test('loadProgress emits error on failure', () async {
      when(() => mockGet()).thenThrow(Exception('fail'));

      await cubit.loadProgress();

      expect(cubit.state.status, ProgressStatus.error);
    });

    test('markQuizPassed increments quizzesPassed', () async {
      await cubit.loadProgress();
      final before = cubit.state.progress.quizzesPassed;

      await cubit.markQuizPassed();

      expect(cubit.state.progress.quizzesPassed, before + 1);
    });

    test('markArticleRead increments articlesRead', () async {
      await cubit.loadProgress();
      final before = cubit.state.progress.articlesRead;

      await cubit.markArticleRead();

      expect(cubit.state.progress.articlesRead, before + 1);
    });

    test('loadAndMarkQuizPassed chains load + mark', () async {
      final beforeQ = cubit.state.progress.quizzesPassed;

      await cubit.loadAndMarkQuizPassed();

      expect(cubit.state.progress.quizzesPassed, beforeQ + 1);
      expect(cubit.state.status, ProgressStatus.loaded);
    });
  });
}
