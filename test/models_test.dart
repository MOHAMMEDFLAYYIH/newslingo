import 'package:flutter_test/flutter_test.dart';
import 'package:newslingo/data/models/article_model.dart';
import 'package:newslingo/domain/entities/article.dart';

// =============================================================================
// Models — JSON serialization round-trips
// =============================================================================

void main() {
  group('ArticleModel', () {
    final json = {
      'id': 'test_1',
      'title': 'Test Article',
      'description': 'A test description',
      'content': 'Full content of the test article.',
      'category': 'technology',
      'source': 'Test Source',
      'image_url': 'https://example.com/image.jpg',
      'audio_url': 'https://example.com/audio.mp3',
      'base_level': 'B2',
      'published_at': '2026-06-24T10:00:00.000Z',
      'tags': ['test', 'flutter'],
      'vocabulary': [
        {
          'word': 'breakthrough',
          'definition': 'A major achievement',
          'translation': 'اختراق',
          'synonyms': ['advance', 'discovery'],
          'examples': ['This is a breakthrough.'],
          'part_of_speech': 'noun',
        },
        {
          '_type': 'quiz',
          'questions': [
            {
              'question': 'What is the article about?',
              'options': ['Tech', 'Sports', 'Science', 'Art'],
              'correct_index': 0,
            },
          ],
        },
      ],
    };

    test('fromJson parses all fields', () {
      final m = ArticleModel.fromJson(json);
      expect(m.id, 'test_1');
      expect(m.title, 'Test Article');
      expect(m.content, 'Full content of the test article.');
      expect(m.category, 'technology');
      expect(m.imageUrl, 'https://example.com/image.jpg');
      expect(m.level, 'B2');
      expect(m.publishedAt, DateTime.utc(2026, 6, 24, 10));
      expect(m.tags, ['test', 'flutter']);
    });

    test('fromJson splits vocabulary and quiz from JSONB', () {
      final m = ArticleModel.fromJson(json);
      expect(m.vocabulary.length, 1);
      expect(m.vocabulary[0].word, 'breakthrough');
      expect(m.quiz, isNotNull);
      expect(m.quiz!.questions.length, 1);
      expect(m.quiz!.questions[0].correctIndex, 0);
    });

    test('fromJson handles missing vocabulary', () {
      final j = Map<String, dynamic>.from(json)..remove('vocabulary');
      final m = ArticleModel.fromJson(j);
      expect(m.vocabulary, isEmpty);
      expect(m.quiz, isNull);
    });

    test('toJson round-trip', () {
      final m = ArticleModel.fromJson(json);
      final out = m.toJson();
      expect(out['id'], 'test_1');
      expect(out['title'], 'Test Article');
      expect((out['vocabulary'] as List).length, 1);
    });

    test('toEntity / fromEntity preserves translated fields', () {
      final entity = Article(
        id: 'e1',
        title: 'T',
        description: 'D',
        content: 'C',
        category: 'science',
        source: 'S',
        imageUrl: '',
        audioUrl: '',
        level: 'A2',
        publishedAt: DateTime(2026),
        tags: ['t'],
        translatedTitle: 'مترجم',
        translatedDescription: 'وصف',
        translatedContent: 'محتوى',
        vocabulary: [
          WordDefinition(
            word: 'w',
            definition: 'd',
            translation: 'ت',
            synonyms: [],
            examples: ['e'],
            partOfSpeech: 'n',
          ),
        ],
        quiz: Quiz(
          id: 'q1',
          articleId: 'e1',
          questions: [
            QuizQuestion(
              question: 'Q?',
              options: ['A', 'B', 'C', 'D'],
              correctIndex: 1,
            ),
          ],
        ),
      );
      final model = ArticleModel.fromEntity(entity);
      final roundTrip = model.toEntity();

      expect(roundTrip.translatedTitle, 'مترجم');
      expect(roundTrip.vocabulary.length, 1);
      expect(roundTrip.quiz!.questions[0].correctIndex, 1);
    });
  });

  group('WordDefinitionModel', () {
    test('fromJson handles list examples', () {
      final m = WordDefinitionModel.fromJson({
        'word': 'test',
        'definition': 'def',
        'translation': 'ترجمة',
        'synonyms': ['a', 'b'],
        'examples': ['ex1', 'ex2'],
        'part_of_speech': 'verb',
      });
      expect(m.examples, ['ex1', 'ex2']);
    });

    test('fromJson handles string example (fallback key)', () {
      final m = WordDefinitionModel.fromJson({
        'word': 'test',
        'definition': 'def',
        'translation': 'ترجمة',
        'synonyms': [],
        'example': 'single example',
        'part_of_speech': 'noun',
      });
      expect(m.examples, ['single example']);
    });

    test('fromJson handles missing examples gracefully', () {
      final m = WordDefinitionModel.fromJson({
        'word': 'test',
        'definition': 'def',
        'translation': 'ترجمة',
        'synonyms': [],
        'part_of_speech': 'adj',
      });
      expect(m.examples, isEmpty);
    });

    test('toEntity / fromEntity round-trip', () {
      final m = WordDefinitionModel(
        word: 'test',
        definition: 'def',
        translation: 'ترجمة',
        synonyms: ['a'],
        examples: ['e1'],
        partOfSpeech: 'noun',
      );
      final e = m.toEntity();
      final m2 = WordDefinitionModel.fromEntity(e);
      expect(m2.word, 'test');
      expect(m2.synonyms, ['a']);
      expect(m2.examples, ['e1']);
    });
  });

  group('QuizQuestionModel', () {
    test('fromJson accepts correctIndex and correct_index', () {
      final q1 = QuizQuestionModel.fromJson({
        'question': 'Q?',
        'options': ['A', 'B', 'C', 'D'],
        'correctIndex': 2,
      });
      expect(q1.correctIndex, 2);

      final q2 = QuizQuestionModel.fromJson({
        'question': 'Q?',
        'options': ['A', 'B', 'C', 'D'],
        'correct_index': 1,
      });
      expect(q2.correctIndex, 1);
    });

    test('toJson round-trip', () {
      final q = QuizQuestionModel(
        question: 'Question?',
        options: ['X', 'Y', 'Z', 'W'],
        correctIndex: 3,
      );
      final json = q.toJson();
      expect(json['correct_index'], 3);
      final q2 = QuizQuestionModel.fromJson(json);
      expect(q2.correctIndex, 3);
    });

    test('toEntity round-trip', () {
      final q = QuizQuestionModel(
        question: 'Q?',
        options: ['1', '2', '3', '4'],
        correctIndex: 0,
      );
      expect(q.toEntity().correctIndex, 0);
    });
  });

  group('QuizModel', () {
    test('toJson round-trip', () {
      final quiz = QuizModel(
        id: 'q1',
        articleId: 'a1',
        questions: [
          QuizQuestionModel(
            question: 'Q?',
            options: ['A', 'B', 'C', 'D'],
            correctIndex: 1,
          ),
        ],
      );
      final json = quiz.toJson();
      expect(json['id'], 'q1');
      final quiz2 = QuizModel.fromJson(json);
      expect(quiz2.questions.length, 1);
    });
  });
}

// =============================================================================
// Entities — copyWith + equality
// =============================================================================

baseArticle() => Article(
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

baseWord() => WordDefinition(
      word: 'test',
      definition: 'a test',
      translation: 'اختبار',
      synonyms: ['trial'],
      examples: ['This is a test.'],
      partOfSpeech: 'noun',
    );

baseQuiz() => Quiz(
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

baseQuestion() => QuizQuestion(
      question: 'Q?',
      options: ['A', 'B', 'C', 'D'],
      correctIndex: 2,
    );

progress() => UserProgress(
      streak: 5,
      articlesRead: 10,
      wordsLearned: 20,
      quizzesPassed: 3,
      lastActiveDate: DateTime(2026, 6, 24),
    );

baseSaved() => SavedWord(
      word: 'test',
      definition: 'def',
      translation: 'ترجمة',
      articleId: 'a1',
      savedAt: DateTime(2026),
      reviewCount: 2,
      nextReviewDate: DateTime(2026, 7, 1),
    );

group('Article — copyWith', () {
  test('updates single field', () {
    final u = baseArticle().copyWith(title: 'New');
    expect(u.title, 'New');
    expect(u.id, 'a1');
  });

  test('updates all 17 fields', () {
    final u = baseArticle().copyWith(
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
      vocabulary: [baseWord()],
      quiz: baseQuiz(),
    );
    expect(u.id, 'a2');
    expect(u.translatedTitle, 'مترجم');
    expect(u.vocabulary.length, 1);
    expect(u.quiz!.id, 'q1');
  });

  test('null passes keep originals', () {
    expect(baseArticle().copyWith(), baseArticle());
  });

  test('equality', () {
    expect(baseArticle(), baseArticle());
    expect(baseArticle(), isNot(baseArticle().copyWith(id: 'x')));
  });
});

group('WordDefinition — copyWith', () {
  test('updates definition', () {
    expect(baseWord().copyWith(definition: 'new').definition, 'new');
  });
  test('null keeps original', () {
    expect(baseWord().copyWith(), baseWord());
  });
  test('equality', () {
    expect(baseWord(), isNot(baseWord().copyWith(word: 'x')));
  });
});

group('Quiz — copyWith', () {
  test('updates questions', () {
    expect(baseQuiz().copyWith(questions: []).questions, isEmpty);
  });
  test('equality', () {
    expect(baseQuiz(), baseQuiz());
  });
});

group('QuizQuestion — copyWith', () {
  test('updates correctIndex', () {
    expect(baseQuestion().copyWith(correctIndex: 0).correctIndex, 0);
  });
  test('equality', () {
    expect(baseQuestion(), baseQuestion());
  });
});

group('UserProgress — copyWith', () {
  test('updates streak', () {
    expect(progress().copyWith(streak: 10).streak, 10);
  });
  test('null keeps original', () {
    expect(progress().copyWith(), progress());
  });
  test('equality', () {
    expect(progress(), progress());
  });
});

group('SavedWord — copyWith', () {
  test('updates reviewCount', () {
    expect(baseSaved().copyWith(reviewCount: 5).reviewCount, 5);
  });
  test('null nextReviewDate preserves original', () {
    expect(baseSaved().copyWith(nextReviewDate: null).nextReviewDate, DateTime(2026, 7, 1));
  });
  test('equality', () {
    expect(baseSaved(), baseSaved());
  });
});

// =============================================================================
// Extensions
// =============================================================================

import 'dart:ui' show Locale;
import 'package:newslingo/core/utils/extensions.dart';

group('DateTime.relativeTime', () {
  test('now', () => expect(DateTime.now().relativeTime(), 'now'));
  test('minutes', () {
    expect(DateTime.now().subtract(const Duration(minutes: 5)).relativeTime(), '5m ago');
  });
  test('hours', () {
    expect(DateTime.now().subtract(const Duration(hours: 3)).relativeTime(), '3h ago');
  });
  test('days', () {
    expect(DateTime.now().subtract(const Duration(days: 2)).relativeTime(), '2d ago');
  });
  test('old returns date string', () {
    expect(DateTime(2026, 1, 1).relativeTime(), contains('2026'));
  });
  test('Arabic minutes', () {
    final dt = DateTime.now().subtract(const Duration(minutes: 5));
    expect(dt.relativeTime(const Locale('ar')), contains('دقيقة'));
  });
  test('Arabic now', () {
    expect(DateTime.now().relativeTime(const Locale('ar')), 'الآن');
  });
});

group('String.capitalize', () {
  test('capitalizes', () => expect('hello'.capitalize, 'Hello'));
  test('empty', () => expect(''.capitalize, ''));
  test('single char', () => expect('a'.capitalize, 'A'));
});
