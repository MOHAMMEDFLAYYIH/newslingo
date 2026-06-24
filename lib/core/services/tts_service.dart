import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;

  TtsService() {
    _tts.setCompletionHandler(() => _isSpeaking = false);
    _tts.setErrorHandler((_) => _isSpeaking = false);
  }

  Future<void> speak(String text, {String language = 'en-US'}) async {
    if (_isSpeaking) {
      await _tts.stop();
      _isSpeaking = false;
      return;
    }
    try {
      await _tts.setLanguage(language);
      await _tts.setPitch(1.0);
      await _tts.setSpeechRate(0.5);
      _isSpeaking = true;
      await _tts.speak(text);
    } catch (_) {
      _isSpeaking = false;
    }
  }

  Future<void> stop() async {
    await _tts.stop();
    _isSpeaking = false;
  }

  bool get isSpeaking => _isSpeaking;
}
