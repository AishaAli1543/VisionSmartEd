import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // TTS
import 'package:speech_to_text/speech_to_text.dart' as stt; // STT
import 'subject_chapters_screen.dart'; // Subject Screen
import 'ProgressScreen.dart'; // Progress Screen

class WelcomeScreen extends StatefulWidget {
  final String userName;

  const WelcomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late FlutterTts flutterTts;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText =
      "Say a command like 'Explore Subjects' or 'Track Progress'.";

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _speech = stt.SpeechToText();
    _initializeTTS();
    _readMainScreenContent(); // Read the main screen content when the screen is loaded.
  }

  Future<void> _initializeTTS() async {
    try {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
    } catch (e) {
      print("TTS initialization error: $e");
    }
  }

  Future<void> _speak(String text) async {
    try {
      await flutterTts.speak(text);
      await flutterTts.awaitSpeakCompletion(true);
    } catch (e) {
      print("Error in TTS speaking: $e");
    }
  }

  Future<void> _readMainScreenContent() async {
    // Read out the main screen's information when it is loaded.
    await _speak(
        'Welcome, ${widget.userName}. On this screen, you can give commands such as Explore Subjects, Track Progress, or navigate to Lectures or Quizzes.');
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print("Speech status: $status"),
        onError: (error) => print("Speech error: $error"),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords;
            if (_spokenText.isNotEmpty) {
              _handleVoiceCommand(_spokenText);
            }
          });
        });
        _speak("Listening for a command.");
      } else {
        _speak("Speech recognition is not available. Please try again later.");
      }
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
    _speak("Stopped listening.");
  }

  void _handleVoiceCommand(String command) {
    final normalizedCommand = command.toLowerCase().trim();
    print("Command: $normalizedCommand"); // Debugging output

    if (normalizedCommand.contains("explore subjects") ||
        normalizedCommand.contains("subjects")) {
      _speak("Navigating to Explore Subjects.");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SubjectChaptersScreen()),
      );
    } else if (normalizedCommand.contains("track progress") ||
        normalizedCommand.contains("progress")) {
      _speak("Navigating to Track Progress.");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProgressScreen()),
      );
    } else if (normalizedCommand.contains("lectures")) {
      _speak("Navigating to Lectures.");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SubjectChaptersScreen()),
      );
    } else if (normalizedCommand.contains("quizzes")) {
      _speak("Navigating to Quizzes.");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SubjectChaptersScreen()),
      );
    } else if (normalizedCommand.contains("home")) {
      Navigator.pop(context);
      _speak("Returning to Home.");
    } else if (normalizedCommand.contains("menu")) {
      _scaffoldKey.currentState?.openDrawer();
      _speak("Opening menu.");
    } else {
      _speak("Command not recognized. Please try again.");
    }

    setState(() {
      _spokenText = ""; // Clear after processing the command
    });
  }

  Future<void> _readDrawerOptions() async {
    await _speak(
        'Drawer opened. Available options are: Home, Subjects, Lectures, Quizzes, Progress.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Welcome, ${widget.userName}'),
        backgroundColor: const Color(0xFFFF9900),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
            _readDrawerOptions();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
            onPressed: _isListening ? _stopListening : _startListening,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFFF9900)),
              child: Row(
                children: [
                  const Icon(Icons.account_circle,
                      size: 40, color: Colors.black),
                  const SizedBox(width: 10),
                  Text(
                    'Hello, ${widget.userName}!',
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {
                      _startListening(); // Start listening when mic in the drawer is pressed
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _speak("Returning to Home.");
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Subjects'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubjectChaptersScreen()),
                );
                _speak("Navigating to Subjects.");
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Lectures'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubjectChaptersScreen()),
                );
                _speak("Navigating to Lectures.");
              },
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('Quizzes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubjectChaptersScreen()),
                );
                _speak("Navigating to Quizzes.");
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Progress'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProgressScreen()),
                );
                _speak("Navigating to Progress Tracking.");
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Greetings, ${widget.userName}!',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF9900)),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/welcome screen image.png', // Ensure the path is correct
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _spokenText.isNotEmpty
                  ? "You said: $_spokenText"
                  : "Awaiting your command.",
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            const Text(
              'Embrace every challenge as a stepping stone to greatness.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubjectChaptersScreen()),
                  );
                  _speak("Navigating to Explore Subjects.");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9900)),
                child: const Text('Explore Subjects'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
