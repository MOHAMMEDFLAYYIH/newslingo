import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DeepLService {
  DeepLService();

  String? get _apiKey => dotenv.env['DEEPL_API_KEY'];
  bool get isAvailable => _apiKey != null && _apiKey!.isNotEmpty;

  static const _localeToDeepL = {
    'ar': 'AR',
    'en': 'EN',
    'es': 'ES',
    'fr': 'FR',
    'pt': 'PT-PT',
    'ru': 'RU',
    'hi': 'HI',
    'zh': 'ZH',
  };

  static String targetCode(String localeCode) =>
      _localeToDeepL[localeCode] ?? 'AR';

  Future<String> translate(String text, {String targetLang = 'AR'}) async {
    final key = _apiKey;
    if (key == null || key.isEmpty || text.isEmpty) return text;
    if (targetLang == 'EN') return text;

    final uri = Uri.parse('https://api-free.deepl.com/v2/translate');
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'DeepL-Auth-Key $key',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'text': text,
        'target_lang': targetLang,
        'source_lang': 'EN',
      },
    );

    if (response.statusCode != 200) return text;

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final translations = data['translations'] as List;
    if (translations.isEmpty) return text;
    return (translations[0] as Map<String, dynamic>)['text'] as String;
  }

  Future<List<String>> translateBatch(List<String> texts,
      {String targetLang = 'AR'}) async {
    if (texts.isEmpty) return texts;
    if (targetLang == 'EN') return texts;
    final key = _apiKey;
    if (key == null || key.isEmpty) return texts;

    final uri = Uri.parse('https://api-free.deepl.com/v2/translate');
    final bodyBuffer = StringBuffer();
    for (final t in texts) {
      bodyBuffer.write('text=${Uri.encodeComponent(t)}&');
    }
    bodyBuffer.write('target_lang=$targetLang&source_lang=EN');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'DeepL-Auth-Key $key',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: bodyBuffer.toString(),
    );

    if (response.statusCode != 200) return texts;

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final translations = data['translations'] as List;
    return translations
        .map((t) => (t as Map<String, dynamic>)['text'] as String)
        .toList();
  }
}
