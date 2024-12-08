import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts
import 'QuizScreen.dart';

class ChapterDetailScreen extends StatefulWidget {
  final String chapterTitle;
  final String chapterContent;
  final String subject;
  final List<Map<String, dynamic>> quizQuestions;

  const ChapterDetailScreen({
    super.key,
    required this.chapterTitle,
    required this.chapterContent,
    required this.subject,
    required this.quizQuestions, required String chapterDescription,
  });

  @override
  _ChapterDetailScreenState createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  final FlutterTts _flutterTts = FlutterTts(); // TTS instance

  @override
  void initState() {
    super.initState();
    _initializeTTS(); // Initialize TTS and start reading the content
  }

  @override
  void dispose() {
    _flutterTts.stop(); // Stop TTS when the screen is disposed
    super.dispose();
  }

  Future<void> _initializeTTS() async {
    await _flutterTts.setLanguage("en-US"); // Set TTS language
    await _flutterTts.setSpeechRate(0.5); // Set speech rate
    await _flutterTts.setPitch(1.0); // Set pitch

    // Automatically read the chapter title and content
    await _flutterTts.speak("${widget.chapterTitle}. ${widget.chapterContent}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.chapterTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chapterTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.chapterContent,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(subject: widget.subject),
                    ),
                  );
                },
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
