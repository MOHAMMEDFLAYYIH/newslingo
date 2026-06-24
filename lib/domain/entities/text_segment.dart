import 'package:equatable/equatable.dart';
import 'package:newslingo/data/models/highlighted_word_model.dart';

class TextSegment extends Equatable {
  final int id;
  final String cleanText;
  final List<String> highlightedWords;
  final List<HighlightedWordModel> highlightedWordsData;

  const TextSegment({
    required this.id,
    required this.cleanText,
    required this.highlightedWords,
    this.highlightedWordsData = const [],
  });

  TextSegment copyWith({
    int? id,
    String? cleanText,
    List<String>? highlightedWords,
    List<HighlightedWordModel>? highlightedWordsData,
  }) {
    return TextSegment(
      id: id ?? this.id,
      cleanText: cleanText ?? this.cleanText,
      highlightedWords: highlightedWords ?? this.highlightedWords,
      highlightedWordsData: highlightedWordsData ?? this.highlightedWordsData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clean_text': cleanText,
      'highlighted_words': highlightedWords,
      if (highlightedWordsData.isNotEmpty)
        'highlighted_words_data':
            highlightedWordsData.map((h) => h.toJson()).toList(),
    };
  }

  factory TextSegment.fromJson(Map<String, dynamic> json) {
    return TextSegment(
      id: json['id'] as int,
      cleanText: json['clean_text'] as String,
      highlightedWords:
          (json['highlighted_words'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      highlightedWordsData:
          (json['highlighted_words_data'] as List<dynamic>?)
              ?.map((e) =>
                  HighlightedWordModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props =>
      [id, cleanText, highlightedWords, highlightedWordsData];
}
