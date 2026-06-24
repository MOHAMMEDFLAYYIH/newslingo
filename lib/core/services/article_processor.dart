import 'dart:convert';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/entities/text_segment.dart';

class ArticleProcessor {
  ArticleProcessor._();

  static final Set<String> _stopWords = {
    'a', 'an', 'the', 'and', 'or', 'but', 'if', 'when', 'as', 'at',
    'by', 'for', 'in', 'of', 'on', 'to', 'with', 'into', 'upon',
    'is', 'are', 'was', 'were', 'be', 'been', 'being', 'am',
    'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would',
    'shall', 'should', 'may', 'might', 'can', 'could', 'must',
    'it', 'its', 'this', 'that', 'these', 'those',
    'from', 'about', 'like', 'just', 'not', 'no', 'nor',
    'so', 'very', 'too', 'also', 'up', 'down', 'out', 'off',
    'over', 'under', 'again', 'further', 'then', 'once',
    'every', 'all', 'both', 'each', 'few',
    'more', 'most', 'other', 'some', 'such', 'only', 'own',
    'same', 'than', 'what', 'which', 'who',
    'whom', 'whose', 'why', 'how', 'where',
    'after', 'before', 'between', 'through', 'during',
    'because', 'since', 'until', 'although', 'though',
    'yet', 'any', 'anything', 'anyone', 'everything',
    'everyone', 'nothing', 'nobody', 'something', 'someone',
    'one', 'two', 'three', 'first', 'last', 'next', 'new',
    'old', 'well', 'back', 'still', 'even', 'much', 'many',
    'another', 'per', 'ago', 'ever', 'never', 'now',
    'here', 'there', 'always', 'often', 'sometimes', 'usually',
    'already', 'around', 'away', 'hereby',
    'herein', 'hereupon', 'herewith', 'indeed',
  };

  static final Set<String> _easyWords = {
    'get', 'got', 'make', 'made', 'take', 'took', 'give', 'gave',
    'come', 'came', 'see', 'saw', 'seen', 'know', 'knew', 'known',
    'think', 'thought', 'want', 'need', 'use', 'used', 'using',
    'find', 'found', 'tell', 'told', 'ask', 'asked', 'seem',
    'feel', 'felt', 'try', 'tried', 'leave', 'left', 'call',
    'called', 'keep', 'kept', 'let', 'start', 'started', 'show',
    'shown', 'showed', 'hear', 'heard', 'play', 'played', 'run',
    'ran', 'move', 'moved', 'live', 'lived', 'believe', 'held',
    'hold', 'bring', 'brought', 'happen', 'happened', 'write',
    'wrote', 'written', 'provide', 'sit', 'sat', 'stand', 'stood',
    'lose', 'lost', 'pay', 'paid', 'meet', 'met', 'include',
    'set', 'change', 'went', 'gone', 'go', 'goes', 'says',
    'said', 'say', 'done', 'doing', 'makes', 'takes', 'comes',
    'knows', 'thinks', 'wants', 'needs', 'uses', 'finds', 'tells',
    'asks', 'seems', 'feels', 'tries', 'leaves', 'calls', 'keeps',
    'lets', 'starts', 'shows', 'hears', 'plays', 'runs', 'moves',
    'lives', 'believes', 'holds', 'brings', 'happens', 'writes',
    'provides', 'sits', 'stands', 'loses', 'pays', 'meets', 'includes',
    'sets', 'changes', 'means', 'meant', 'mean',
  };

  static final RegExp _htmlTagPattern = RegExp(r'</?[^>]+>');

  static String _stripHtml(String text) {
    return text.replaceAll(_htmlTagPattern, '');
  }

  static List<TextSegment> process(String content, List<WordDefinition> vocabulary) {
    final clean = _stripHtml(content);
    final vocabWords = vocabulary.map((v) => v.word.toLowerCase()).toSet();
    return _splitIntoSentences(clean, vocabWords);
  }

  static List<TextSegment> processWithLevel(
    String content,
    String level,
  ) {
    final clean = _stripHtml(content);
    final vocabWords = <String>{};
    final paragraphs =
        clean.split('\n').where((p) => p.trim().isNotEmpty).toList();
    for (final p in paragraphs) {
      final words = p.split(RegExp(r'\s+'));
      for (final w in words) {
        final cleaned = w.replaceAll(RegExp(r"[^\w'-]"), '').toLowerCase();
        if (cleaned.length > 3 &&
            !_stopWords.contains(cleaned) &&
            !_easyWords.contains(cleaned)) {
          vocabWords.add(cleaned);
        }
      }
    }
    return _splitIntoSentences(clean, vocabWords);
  }

  static List<TextSegment> _splitIntoSentences(
    String content,
    Set<String> vocabWords,
  ) {
    final sentences = <String>[];
    final paragraphs =
        content.split('\n').where((p) => p.trim().isNotEmpty).toList();
    for (final p in paragraphs) {
      final parts = p.split(RegExp(r'(?<=[.!?])\s+'));
      for (final part in parts) {
        final trimmed = part.trim();
        if (trimmed.isNotEmpty) {
          sentences.add(trimmed);
        }
      }
    }

    final segments = <TextSegment>[];
    for (int i = 0; i < sentences.length; i++) {
      final cleanText = sentences[i];
      final words = _wordTokens(cleanText);
      final highlighted = words
          .where((w) => vocabWords.contains(w.toLowerCase()))
          .map((w) => w.toLowerCase())
          .toList();
      segments.add(TextSegment(
        id: i + 1,
        cleanText: cleanText,
        highlightedWords: highlighted,
      ));
    }
    return segments;
  }

  static List<String> _wordTokens(String sentence) {
    return sentence
        .split(RegExp(r'\s+'))
        .map((w) => w.replaceAll(RegExp(r"^[^\w']+|[^\w']+$"), ''))
        .where((w) => w.isNotEmpty)
        .toList();
  }

  static String segmentsToJson(List<TextSegment> segments) {
    return jsonEncode(segments.map((s) => s.toJson()).toList());
  }

  static List<TextSegment> segmentsFromJson(String json) {
    final list = jsonDecode(json) as List<dynamic>;
    return list
        .map((e) => TextSegment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<TextSegment> processFromApiResponse(
    Map<String, dynamic> apiResponse,
  ) {
    final segmentsJson = apiResponse['segments'] as List<dynamic>?;
    if (segmentsJson == null) return [];
    return segmentsJson
        .map((e) => TextSegment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> processToApiPayload(
    String content,
    String level,
    String title,
  ) {
    final cleaned = _stripHtml(content);
    return {
      'article_title': title,
      'cefr_level': level,
      'raw_text': cleaned,
    };
  }

  static Map<String, dynamic> buildFromSegments(
    String title,
    String level,
    List<TextSegment> segments,
  ) {
    return {
      'article_title': title,
      'cefr_level': level,
      'segments': segments.map((s) => s.toJson()).toList(),
    };
  }
}
