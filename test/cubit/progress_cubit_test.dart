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

    when(mockGet).thenAnswer((_) async => UserProgress(
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

  group('ProgressCubit', () {
    test('initial state has initial status', () {
      expect(cubit.state.status, ProgressStatus.initial);
      expect(cubit.state.progress.streak, 0);
    });

    test('loadProgress updates to loading then loaded', () async {
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
      when(mockGet).thenThrow(Exception('fail'));

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

    test('streak resets to 1 when last active is old', () async {
      when(mockGet).thenAnswer((_) async => UserProgress(
        streak: 10,
        articlesRead: 0,
        wordsLearned: 0,
        quizzesPassed: 0,
        lastActiveDate: DateTime(2020),
      ));

      await cubit.loadProgress();
      await cubit.markQuizPassed();

      expect(cubit.state.progress.streak, 1);
    });

    test('streak increments when last active was yesterday', () async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      when(mockGet).thenAnswer((_) async => UserProgress(
        streak: 5,
        articlesRead: 0,
        wordsLearned: 0,
        quizzesPassed: 0,
        lastActiveDate: yesterday,
      ));

      await cubit.loadProgress();
      await cubit.markQuizPassed();

      expect(cubit.state.progress.streak, 6);
    });

    test('streak preserved when last active is today', () async {
      when(mockGet).thenAnswer((_) async => UserProgress(
        streak: 7,
        articlesRead: 0,
        wordsLearned: 0,
        quizzesPassed: 0,
        lastActiveDate: DateTime.now(),
      ));

      await cubit.loadProgress();
      await cubit.markQuizPassed();

      expect(cubit.state.progress.streak, 7);
    });
  });
}
