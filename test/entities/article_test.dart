import 'package:flutter_test/flutter_test.dart';
import 'package:newslingo/domain/entities/article.dart';

void main() {
  final baseArticle = Article(
    id: 'a1',
    title: 'Title',
    description: 'Desc',
    content: 'Content',
    category: 'tech',
    source: 'Src',
    imageUrl: 'img.jpg',
    audioUrl: 'audio.mp3',
    level: 'B1',
    publishedAt: DateTime(2026),
    tags: ['tag1'],
  );

  group('Article', () {
    test('copyWith updates only specified fields', () {
      final updated = baseArticle.copyWith(title: 'New Title');
      expect(updated.id, 'a1');
      expect(updated.title, 'New Title');
      expect(updated.description, 'Desc');
    });

    test('copyWith handles all 17 fields', () {
      final updated = baseArticle.copyWith(
        id: 'a2',
        title: 'T2',
        description: 'D2',
        content: 'C2',
        category: 'sports',
        source: 'S2',
        imageUrl: 'i2.jpg',
        audioUrl: 'a2.mp3',
        level: 'C1',
        publishedAt: DateTime(2025),
        tags: ['t2'],
        translatedTitle: 'مترجم',
        translatedDescription: 'وصف',
        translatedContent: 'محتوى',
        vocabulary: [
          WordDefinition(
            word: 'w',
            definition: 'd',
            translation: 'ت',
            synonyms: [],
            examples: [],
            partOfSpeech: 'n',
          ),
        ],
        quiz: Quiz(
          id: 'q1',
          articleId: 'a2',
          questions: [],
        ),
      );

      expect(updated.id, 'a2');
      expect(updated.title, 'T2');
      expect(updated.translatedTitle, 'مترجم');
      expect(updated.vocabulary.length, 1);
      expect(updated.quiz!.id, 'q1');
    });

    test('copyWith retains values when null passed', () {
      final updated = baseArticle.copyWith();
      expect(updated.id, 'a1');
      expect(updated.title, 'Title');
    });

    test('equality works correctly', () {
      final same = Article(
        id: 'a1',
        title: 'Title',
        description: 'Desc',
        content: 'Content',
        category: 'tech',
        source: 'Src',
        imageUrl: 'img.jpg',
        audioUrl: 'audio.mp3',
        level: 'B1',
        publishedAt: DateTime(2026),
        tags: ['tag1'],
      );
      expect(baseArticle, same);

      final different = baseArticle.copyWith(id: 'a2');
      expect(baseArticle, isNot(different));
    });
  });

  group('WordDefinition', () {
    final base = WordDefinition(
      word: 'test',
      definition: 'a test',
      translation: 'اختبار',
      synonyms: ['trial'],
      examples: ['This is a test.'],
      partOfSpeech: 'noun',
    );

    test('copyWith updates specified fields', () {
      final updated = base.copyWith(definition: 'new def');
      expect(updated.word, 'test');
      expect(updated.definition, 'new def');
      expect(updated.translation, 'اختبار');
    });

    test('copyWith null keeps original', () {
      expect(base.copyWith(), base);
    });

    test('equality', () {
      final same = WordDefinition(
        word: 'test',
        definition: 'a test',
        translation: 'اختبار',
        synonyms: ['trial'],
        examples: ['This is a test.'],
        partOfSpeech: 'noun',
      );
      expect(base, same);

      final diff = base.copyWith(word: 'different');
      expect(base, isNot(diff));
    });
  });

  group('Quiz', () {
    final base = Quiz(
      id: 'q1',
      articleId: 'a1',
      questions: [
        QuizQuestion(
          question: 'Q?',
          options: ['A', 'B', 'C', 'D'],
          correctIndex: 0,
        ),
      ],
    );

    test('copyWith updates questions', () {
      final updated = base.copyWith(questions: []);
      expect(updated.id, 'q1');
      expect(updated.questions, isEmpty);
    });

    test('equality', () {
      final same = Quiz(
        id: 'q1',
        articleId: 'a1',
        questions: [
          QuizQuestion(
            question: 'Q?',
            options: ['A', 'B', 'C', 'D'],
            correctIndex: 0,
          ),
        ],
      );
      expect(base, same);
    });
  });

  group('QuizQuestion', () {
    final base = QuizQuestion(
      question: 'Q?',
      options: ['A', 'B', 'C', 'D'],
      correctIndex: 2,
    );

    test('copyWith updates correctIndex', () {
      final updated = base.copyWith(correctIndex: 0);
      expect(updated.question, 'Q?');
      expect(updated.correctIndex, 0);
    });

    test('equality', () {
      final same = QuizQuestion(
        question: 'Q?',
        options: ['A', 'B', 'C', 'D'],
        correctIndex: 2,
      );
      expect(base, same);
    });
  });

  group('UserProgress', () {
    final base = UserProgress(
      streak: 5,
      articlesRead: 10,
      wordsLearned: 20,
      quizzesPassed: 3,
      lastActiveDate: DateTime(2026, 6, 24),
    );

    test('copyWith updates streak only', () {
      final updated = base.copyWith(streak: 10);
      expect(updated.streak, 10);
      expect(updated.articlesRead, 10);
      expect(updated.lastActiveDate, DateTime(2026, 6, 24));
    });

    test('copyWith null keeps original', () {
      expect(base.copyWith(), base);
    });

    test('equality', () {
      final same = UserProgress(
        streak: 5,
        articlesRead: 10,
        wordsLearned: 20,
        quizzesPassed: 3,
        lastActiveDate: DateTime(2026, 6, 24),
      );
      expect(base, same);
    });
  });

  group('SavedWord', () {
    final base = SavedWord(
      word: 'test',
      definition: 'def',
      translation: 'ترجمة',
      articleId: 'a1',
      savedAt: DateTime(2026),
      reviewCount: 2,
      nextReviewDate: DateTime(2026, 7, 1),
    );

    test('copyWith updates reviewCount', () {
      final updated = base.copyWith(reviewCount: 5);
      expect(updated.reviewCount, 5);
      expect(updated.word, 'test');
    });

    test('copyWith preserves nextReviewDate when null passed', () {
      final updated = base.copyWith(nextReviewDate: null);
      expect(updated.nextReviewDate, DateTime(2026, 7, 1));
    });

    test('equality', () {
      final same = SavedWord(
        word: 'test',
        definition: 'def',
        translation: 'ترجمة',
        articleId: 'a1',
        savedAt: DateTime(2026),
        reviewCount: 2,
        nextReviewDate: DateTime(2026, 7, 1),
      );
      expect(base, same);
    });
  });
}
