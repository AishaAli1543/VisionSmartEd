import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'firebase_options.dart';
import 'splash_screen.dart';
import 'package:app1/WelcomeScreen.dart';
import 'package:app1/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VisionSmartEd',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/username': (context) => const UsernameEntryScreen(),
        '/welcome': (context) => const WelcomeScreen(userName: 'User'), // Dynamic username will be passed
      },
    );
  }
}

class TextToSpeech {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }
}

class SpeechRecognition {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  Future<void> initSpeech() async {
    await _speech.initialize();
    _startListening();
  }

  void _startListening() async {
    _isListening = true;
    _speech.listen(onResult: (result) {
      if (result.hasConfidenceRating && result.confidence > 0.5) {
        String recognizedCommand = result.recognizedWords;
        print('Recognized: $recognizedCommand');
        // Handle recognized commands based on context (add logic in respective screens)
      }
    });
  }

  void stopListening() {
    if (_isListening) {
      _speech.stop();
      _isListening = false;
    }
  }
}
