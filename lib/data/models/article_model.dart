import 'package:newslingo/domain/entities/article.dart';

class ArticleModel {
  final String id;
  final String title;
  final String description;
  final String content;
  final String category;
  final String source;
  final String imageUrl;
  final String audioUrl;
  final String level;
  final DateTime publishedAt;
  final List<String> tags;
  final String? translatedTitle;
  final String? translatedDescription;
  final String? translatedContent;
  final List<WordDefinitionModel> vocabulary;
  final QuizModel? quiz;

  const ArticleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.source,
    required this.imageUrl,
    required this.audioUrl,
    required this.level,
    required this.publishedAt,
    required this.tags,
    this.translatedTitle,
    this.translatedDescription,
    this.translatedContent,
    this.vocabulary = const [],
    this.quiz,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final baseLevel = json['base_level'] as String? ?? 'B1';
    final levelKey = baseLevel.toLowerCase();

    String extractContent() {
      final c = json['content'] as String?
          ?? json['content_$levelKey'] as String?
          ?? json['content_b1'] as String?
          ?? '';
      if (c.trim().isEmpty || c.contains('ONLY AVAILABLE IN PAID PLANS') ||
          c.contains('only available in paid plans')) {
        return json['description'] as String? ?? json['description_$levelKey'] as String? ?? '';
      }
      return c;
    }

    List<WordDefinitionModel> vocabList = [];
    QuizModel? quiz;
    final rawVocab = json['vocabulary'] as List<dynamic>?;
    if (rawVocab != null) {
      for (final e in rawVocab) {
        final map = e as Map<String, dynamic>;
        if (map['_type'] == 'quiz') {
          quiz = QuizModel.fromJson({
            'id': json['id'],
            'article_id': json['id'],
            'questions': map['questions'] ?? [],
          });
        } else {
          vocabList.add(WordDefinitionModel.fromJson(map));
        }
      }
    }

    return ArticleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? json['description_$levelKey'] as String? ?? '',
      content: extractContent(),
      category: json['category'] as String,
      source: json['source'] as String,
      imageUrl: json['image_url'] as String? ?? '',
      audioUrl: json['audio_url'] as String? ?? '',
      level: baseLevel,
      publishedAt: DateTime.parse(json['published_at'] as String),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      translatedTitle: json['translated_title'] as String?,
      translatedDescription: json['translated_description'] as String?,
      translatedContent: json['translated_content'] as String?,
      vocabulary: vocabList,
      quiz: quiz,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'category': category,
      'source': source,
      'image_url': imageUrl,
      'audio_url': audioUrl,
      'level': level,
      'published_at': publishedAt.toIso8601String(),
      'tags': tags,
      if (translatedTitle != null) 'translated_title': translatedTitle,
      if (translatedDescription != null) 'translated_description': translatedDescription,
      if (translatedContent != null) 'translated_content': translatedContent,
      'vocabulary': vocabulary.map((v) => v.toJson()).toList(),
      if (quiz != null) 'quiz': quiz!.toJson(),
    };
  }

  Article toEntity() {
    return Article(
      id: id,
      title: title,
      description: description,
      content: content,
      category: category,
      source: source,
      imageUrl: imageUrl,
      audioUrl: audioUrl,
      level: level,
      publishedAt: publishedAt,
      tags: tags,
      translatedTitle: translatedTitle,
      translatedDescription: translatedDescription,
      translatedContent: translatedContent,
      vocabulary: vocabulary.map((v) => v.toEntity()).toList(),
      quiz: quiz?.toEntity(),
    );
  }

  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      id: article.id,
      title: article.title,
      description: article.description,
      content: article.content,
      category: article.category,
      source: article.source,
      imageUrl: article.imageUrl,
      audioUrl: article.audioUrl,
      level: article.level,
      publishedAt: article.publishedAt,
      tags: article.tags,
      translatedTitle: article.translatedTitle,
      translatedDescription: article.translatedDescription,
      translatedContent: article.translatedContent,
      vocabulary: article.vocabulary
          .map((v) => WordDefinitionModel.fromEntity(v))
          .toList(),
      quiz: article.quiz != null
          ? QuizModel(
              id: article.quiz!.id,
              articleId: article.quiz!.articleId,
              questions: article.quiz!.questions
                  .map((q) => QuizQuestionModel(
                        question: q.question,
                        options: q.options,
                        correctIndex: q.correctIndex,
                      ))
                  .toList(),
            )
          : null,
    );
  }
}

class WordDefinitionModel {
  final String word;
  final String definition;
  final String translation;
  final List<String> synonyms;
  final List<String> examples;
  final String partOfSpeech;

  const WordDefinitionModel({
    required this.word,
    required this.definition,
    required this.translation,
    required this.synonyms,
    required this.examples,
    required this.partOfSpeech,
  });

  factory WordDefinitionModel.fromJson(Map<String, dynamic> json) {
    List<String> parseExamples() {
      final e = json['examples'] ?? json['example'];
      if (e is List) return e.cast<String>();
      if (e is String) return [e];
      return [];
    }

    return WordDefinitionModel(
      word: json['word'] as String,
      definition: json['definition'] as String? ?? '',
      translation: json['translation'] as String? ?? '',
      synonyms:
          (json['synonyms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      examples: parseExamples(),
      partOfSpeech: json['part_of_speech'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'definition': definition,
      'translation': translation,
      'synonyms': synonyms,
      'examples': examples,
      'part_of_speech': partOfSpeech,
    };
  }

  WordDefinition toEntity() {
    return WordDefinition(
      word: word,
      definition: definition,
      translation: translation,
      synonyms: synonyms,
      examples: examples,
      partOfSpeech: partOfSpeech,
    );
  }

  factory WordDefinitionModel.fromEntity(WordDefinition entity) {
    return WordDefinitionModel(
      word: entity.word,
      definition: entity.definition,
      translation: entity.translation,
      synonyms: entity.synonyms,
      examples: entity.examples,
      partOfSpeech: entity.partOfSpeech,
    );
  }
}

class QuizModel {
  final String id;
  final String articleId;
  final List<QuizQuestionModel> questions;

  const QuizModel({
    required this.id,
    required this.articleId,
    required this.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as String? ?? '',
      articleId: json['article_id'] as String? ?? '',
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => QuizQuestionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'article_id': articleId,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }

  Quiz toEntity() {
    return Quiz(
      id: id,
      articleId: articleId,
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }
}

class QuizQuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;

  const QuizQuestionModel({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctIndex: (json['correct_index'] ?? json['correctIndex']) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct_index': correctIndex,
    };
  }

  QuizQuestion toEntity() {
    return QuizQuestion(
      question: question,
      options: options,
      correctIndex: correctIndex,
    );
  }
}
