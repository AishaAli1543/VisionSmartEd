import 'package:app1/main.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:app1/sign_up_screen.dart';
// Ensure to import the TextToSpeech class

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechAvailable = false;
  late TextToSpeech textToSpeech; // Declare TextToSpeech instance

  @override
  void initState() {
    super.initState();
    textToSpeech = TextToSpeech();
    _initializeSpeech();

    // Navigate to the UsernameEntryScreen after a 3-second delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UsernameEntryScreen()),
      );
    });
  }

  Future<void> _initializeSpeech() async {
    _speechAvailable = await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (errorNotification) => print('Speech error: $errorNotification'),
    );

    if (_speechAvailable) {
      _startListening();
      await textToSpeech.speak("Welcome to Vision Smart Ed. Please give a command after the beep.");
    } else {
      print("Speech recognition not available or permission denied.");
    }
  }

  void _startListening() {
    if (_speechAvailable) {
      _speech.listen(
        onResult: (val) {
          print("Speech Recognized: ${val.recognizedWords}");
          _handleCommand(val.recognizedWords); // Handle recognized command
        },
      );
      setState(() => _isListening = true);
    }
  }

  void _handleCommand(String command) {
    if (command.toLowerCase().contains("continue")) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UsernameEntryScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Ensure this image path is correct
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'VisionSmartEd',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            _isListening
                ? const Text("Listening for commands...")
                : const Text("Initializing speech recognition..."),
          ],
        ),
      ),
    );
  }
}
