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
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      source: json['source'] as String,
      imageUrl: json['image_url'] as String? ?? '',
      audioUrl: json['audio_url'] as String? ?? '',
      level: json['level'] as String? ?? 'B1',
      publishedAt: DateTime.parse(json['published_at'] as String),
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
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
    return WordDefinitionModel(
      word: json['word'] as String,
      definition: json['definition'] as String,
      translation: json['translation'] as String,
      synonyms: (json['synonyms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      examples: (json['examples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      partOfSpeech: json['part_of_speech'] as String? ?? '',
    );
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
      id: json['id'] as String,
      articleId: json['article_id'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
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
      correctIndex: json['correct_index'] as int,
    );
  }

  QuizQuestion toEntity() {
    return QuizQuestion(
      question: question,
      options: options,
      correctIndex: correctIndex,
    );
  }
}
