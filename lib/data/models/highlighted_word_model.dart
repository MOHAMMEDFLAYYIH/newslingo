class HighlightedWordModel {
  final String word;
  final String phonetic;
  final List<MeaningModel> meanings;

  const HighlightedWordModel({
    required this.word,
    required this.phonetic,
    required this.meanings,
  });

  factory HighlightedWordModel.fromJson(Map<String, dynamic> json) {
    return HighlightedWordModel(
      word: json['word'] as String? ?? '',
      phonetic: json['phonetic'] as String? ?? '',
      meanings: (json['meanings'] as List<dynamic>?)
              ?.map((e) => MeaningModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'phonetic': phonetic,
      'meanings': meanings.map((m) => m.toJson()).toList(),
    };
  }
}

class MeaningModel {
  final String partOfSpeech;
  final List<DefinitionModel> definitions;

  const MeaningModel({
    required this.partOfSpeech,
    required this.definitions,
  });

  factory MeaningModel.fromJson(Map<String, dynamic> json) {
    return MeaningModel(
      partOfSpeech: json['partOfSpeech'] as String? ?? '',
      definitions: (json['definitions'] as List<dynamic>?)
              ?.map(
                  (e) => DefinitionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partOfSpeech': partOfSpeech,
      'definitions': definitions.map((d) => d.toJson()).toList(),
    };
  }
}

class DefinitionModel {
  final String definition;
  final String example;

  const DefinitionModel({
    required this.definition,
    required this.example,
  });

  factory DefinitionModel.fromJson(Map<String, dynamic> json) {
    return DefinitionModel(
      definition: json['definition'] as String? ?? '',
      example: json['example'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'definition': definition,
      'example': example,
    };
  }
}
