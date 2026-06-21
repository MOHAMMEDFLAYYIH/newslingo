import 'package:equatable/equatable.dart';

class Article extends Equatable {
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

  const Article({
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
  });

  Article copyWith({
    String? translatedTitle,
    String? translatedDescription,
    String? translatedContent,
  }) {
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
      translatedTitle: translatedTitle ?? this.translatedTitle,
      translatedDescription: translatedDescription ?? this.translatedDescription,
      translatedContent: translatedContent ?? this.translatedContent,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        content,
        category,
        source,
        imageUrl,
        audioUrl,
        level,
        publishedAt,
        tags,
        translatedTitle,
        translatedDescription,
        translatedContent,
      ];
}

class WordDefinition extends Equatable {
  final String word;
  final String definition;
  final String translation;
  final List<String> synonyms;
  final List<String> examples;
  final String partOfSpeech;

  const WordDefinition({
    required this.word,
    required this.definition,
    required this.translation,
    required this.synonyms,
    required this.examples,
    required this.partOfSpeech,
  });

  @override
  List<Object?> get props => [
        word,
        definition,
        translation,
        synonyms,
        examples,
        partOfSpeech,
      ];
}

class Quiz extends Equatable {
  final String id;
  final String articleId;
  final List<QuizQuestion> questions;

  const Quiz({
    required this.id,
    required this.articleId,
    required this.questions,
  });

  @override
  List<Object?> get props => [id, articleId, questions];
}

class QuizQuestion extends Equatable {
  final String question;
  final List<String> options;
  final int correctIndex;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  @override
  List<Object?> get props => [question, options, correctIndex];
}

class UserProgress extends Equatable {
  final int streak;
  final int articlesRead;
  final int wordsLearned;
  final int quizzesPassed;
  final DateTime lastActiveDate;

  const UserProgress({
    required this.streak,
    required this.articlesRead,
    required this.wordsLearned,
    required this.quizzesPassed,
    required this.lastActiveDate,
  });

  @override
  List<Object?> get props => [
        streak,
        articlesRead,
        wordsLearned,
        quizzesPassed,
        lastActiveDate,
      ];
}

class SavedWord extends Equatable {
  final String word;
  final String definition;
  final String translation;
  final String articleId;
  final DateTime savedAt;
  final int reviewCount;
  final DateTime? nextReviewDate;

  const SavedWord({
    required this.word,
    required this.definition,
    required this.translation,
    required this.articleId,
    required this.savedAt,
    required this.reviewCount,
    this.nextReviewDate,
  });

  SavedWord copyWith({
    String? word,
    String? definition,
    String? translation,
    String? articleId,
    DateTime? savedAt,
    int? reviewCount,
    DateTime? nextReviewDate,
  }) {
    return SavedWord(
      word: word ?? this.word,
      definition: definition ?? this.definition,
      translation: translation ?? this.translation,
      articleId: articleId ?? this.articleId,
      savedAt: savedAt ?? this.savedAt,
      reviewCount: reviewCount ?? this.reviewCount,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
    );
  }

  @override
  List<Object?> get props => [
        word,
        definition,
        translation,
        articleId,
        savedAt,
        reviewCount,
        nextReviewDate,
      ];
}
