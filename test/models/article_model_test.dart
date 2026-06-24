import 'package:flutter_test/flutter_test.dart';
import 'package:newslingo/data/models/article_model.dart';
import 'package:newslingo/domain/entities/article.dart';

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

    test('fromJson parses all fields correctly', () {
      final model = ArticleModel.fromJson(json);

      expect(model.id, 'test_1');
      expect(model.title, 'Test Article');
      expect(model.description, 'A test description');
      expect(model.content, 'Full content of the test article.');
      expect(model.category, 'technology');
      expect(model.source, 'Test Source');
      expect(model.imageUrl, 'https://example.com/image.jpg');
      expect(model.audioUrl, 'https://example.com/audio.mp3');
      expect(model.level, 'B2');
      expect(model.publishedAt, DateTime.utc(2026, 6, 24, 10));
      expect(model.tags, ['test', 'flutter']);
    });

    test('fromJson parses vocabulary and quiz separately', () {
      final model = ArticleModel.fromJson(json);

      expect(model.vocabulary.length, 1);
      expect(model.vocabulary[0].word, 'breakthrough');
      expect(model.quiz, isNotNull);
      expect(model.quiz!.questions.length, 1);
      expect(model.quiz!.questions[0].correctIndex, 0);
    });

    test('fromJson handles empty vocabulary', () {
      final j = Map<String, dynamic>.from(json)..remove('vocabulary');
      final model = ArticleModel.fromJson(j);
      expect(model.vocabulary, isEmpty);
      expect(model.quiz, isNull);
    });

    test('toJson produces correct map', () {
      final model = ArticleModel.fromJson(json);
      final out = model.toJson();

      expect(out['id'], 'test_1');
      expect(out['title'], 'Test Article');
      expect(out['category'], 'technology');
      expect(out['level'], 'B2');
      expect(out['vocabulary'], isA<List>());
      expect((out['vocabulary'] as List).length, 1);
    });

    test('toEntity produces correct Article', () {
      final model = ArticleModel.fromJson(json);
      final entity = model.toEntity();

      expect(entity.id, 'test_1');
      expect(entity.vocabulary.length, 1);
      expect(entity.vocabulary[0].word, 'breakthrough');
      expect(entity.quiz, isNotNull);
      expect(entity.quiz!.questions.length, 1);
    });

    test('fromEntity preserves all fields', () {
      final entity = Article(
        id: 'e1',
        title: 'Entity Title',
        description: 'Entity desc',
        content: 'Entity content',
        category: 'science',
        source: 'Source',
        imageUrl: '',
        audioUrl: '',
        level: 'A2',
        publishedAt: DateTime(2026),
        tags: ['tag'],
        translatedTitle: 'مترجم',
        translatedDescription: 'وصف مترجم',
        translatedContent: 'محتوى مترجم',
        vocabulary: [
          WordDefinition(
            word: 'test',
            definition: 'def',
            translation: 'ترجمة',
            synonyms: ['syn'],
            examples: ['ex'],
            partOfSpeech: 'noun',
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
      expect(model.translatedTitle, 'مترجم');
      expect(model.translatedDescription, 'وصف مترجم');
      expect(model.translatedContent, 'محتوى مترجم');
      expect(model.vocabulary.length, 1);
      expect(model.quiz, isNotNull);
      expect(model.quiz!.questions.length, 1);

      final roundTrip = model.toEntity();
      expect(roundTrip.translatedTitle, 'مترجم');
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

    test('fromJson handles string example', () {
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

    test('fromJson handles missing examples', () {
      final m = WordDefinitionModel.fromJson({
        'word': 'test',
        'definition': 'def',
        'translation': 'ترجمة',
        'synonyms': [],
        'part_of_speech': 'adj',
      });
      expect(m.examples, isEmpty);
    });

    test('toJson round-trip', () {
      final m = WordDefinitionModel(
        word: 'roundtrip',
        definition: 'def',
        translation: 'ترجمة',
        synonyms: ['x'],
        examples: ['e1'],
        partOfSpeech: 'adv',
      );
      final json = m.toJson();
      final m2 = WordDefinitionModel.fromJson(json);
      expect(m2.word, 'roundtrip');
      expect(m2.synonyms, ['x']);
      expect(m2.examples, ['e1']);
    });

    test('toEntity and fromEntity round-trip', () {
      final m = WordDefinitionModel(
        word: 'test',
        definition: 'def',
        translation: 'ترجمة',
        synonyms: ['a'],
        examples: ['e1'],
        partOfSpeech: 'noun',
      );
      final e = m.toEntity();
      expect(e.word, 'test');
      expect(e.examples, ['e1']);

      final m2 = WordDefinitionModel.fromEntity(e);
      expect(m2.word, 'test');
      expect(m2.synonyms, ['a']);
    });
  });

  group('QuizQuestionModel', () {
    test('fromJson handles correctIndex and correct_index', () {
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
      expect(json['question'], 'Question?');
      expect(json['correct_index'], 3);

      final q2 = QuizQuestionModel.fromJson(json);
      expect(q2.question, 'Question?');
      expect(q2.correctIndex, 3);
    });

    test('toEntity round-trip', () {
      final q = QuizQuestionModel(
        question: 'Q?',
        options: ['1', '2', '3', '4'],
        correctIndex: 0,
      );
      final e = q.toEntity();
      expect(e.correctIndex, 0);
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
      expect(json['article_id'], 'a1');
      expect((json['questions'] as List).length, 1);

      final quiz2 = QuizModel.fromJson(json);
      expect(quiz2.questions.length, 1);
      expect(quiz2.questions[0].correctIndex, 1);
    });
  });
}
