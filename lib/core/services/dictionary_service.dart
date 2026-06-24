import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newslingo/data/models/highlighted_word_model.dart';

class DictionaryService {
  static const _baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en';

  static Future<HighlightedWordModel?> fetchDefinition(String word) async {
    try {
      final uri = Uri.parse('$_baseUrl/${Uri.encodeComponent(word)}');
      final res = await http.get(uri, headers: {'Accept': 'application/json'});
      if (res.statusCode != 200) return null;

      final data = jsonDecode(res.body) as List<dynamic>;
      if (data.isEmpty) return null;

      final entry = data[0] as Map<String, dynamic>;
      final phonetic = entry['phonetic'] as String? ??
          (entry['phonetics'] as List<dynamic>?)
              ?.where((p) => p['text'] != null)
              .map((p) => p['text'] as String)
              .firstOrNull ??
          '';

      final meanings = (entry['meanings'] as List<dynamic>?)
              ?.map((m) {
                final mMap = m as Map<String, dynamic>;
                return MeaningModel(
                  partOfSpeech: mMap['partOfSpeech'] as String? ?? '',
                  definitions: (mMap['definitions'] as List<dynamic>?)
                          ?.take(2)
                          .map((d) {
                            final dMap = d as Map<String, dynamic>;
                            return DefinitionModel(
                              definition: dMap['definition'] as String? ?? '',
                              example: dMap['example'] as String? ?? '',
                            );
                          })
                          .toList() ??
                      [],
                );
              })
              .toList() ??
          [];

      return HighlightedWordModel(
        word: entry['word'] as String? ?? word,
        phonetic: phonetic,
        meanings: meanings,
      );
    } catch (_) {
      return null;
    }
  }
}
