import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _speaking = false;
  double _speechRate = 0.5;
  double _pitch = 1.0;

  VoidCallback? onComplete;
  VoidCallback? onError;
  void Function(String text, int startOffset, int endOffset, String word)?
      onWordProgress;

  TtsService() {
    _tts.setCompletionHandler(() {
      _speaking = false;
      onComplete?.call();
    });
    _tts.setErrorHandler((msg) {
      _speaking = false;
      log('[TtsService] Error: $msg');
      onError?.call();
    });
    _tts.setProgressHandler((text, start, end, word) {
      onWordProgress?.call(text, start, end, word);
    });
  }

  Future<void> speak(
    String text, {
    String language = 'en-US',
    int startOffset = 0,
  }) async {
    try {
      await _tts.setLanguage(language);
      await _tts.setPitch(_pitch);
      await _tts.setSpeechRate(_speechRate);
      final toSpeak =
          startOffset > 0 ? text.substring(startOffset) : text;
      _speaking = true;
      await _tts.speak(toSpeak);
    } catch (e) {
      _speaking = false;
      log('[TtsService] speak failed: $e');
    }
  }

  Future<void> stop() async {
    await _tts.stop();
    _speaking = false;
  }

  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate;
    await _tts.setSpeechRate(rate);
  }

  Future<void> setPitch(double pitch) async {
    _pitch = pitch;
    await _tts.setPitch(pitch);
  }

  bool get isSpeaking => _speaking;
  double get speechRate => _speechRate;
}
