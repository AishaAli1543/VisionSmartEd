import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  final SpeechToText _speech = SpeechToText();

  // Add this method if you need to perform initialization
  Future<void> initialize() async {
    await _speech.initialize();
  }

  Future<void> startListening(Null Function(dynamic text) param0) async {
    await _speech.listen(onResult: (result) {
      // Handle the result
    });
  }

  // Add more methods as needed...
}
