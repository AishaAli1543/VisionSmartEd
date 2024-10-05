import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  final FlutterTts _flutterTts = FlutterTts();

  // Add this method if you need to perform initialization
  Future<void> initialize() async {
    // Any setup code, such as setting language, etc.
    await _flutterTts.setLanguage("en-US");
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  // Add more methods as needed...
}
