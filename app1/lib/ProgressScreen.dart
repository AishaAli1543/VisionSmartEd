import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool isLoading = true;
  bool _isListening = false;
  String _spokenCommand = "";

  Map<String, dynamic> subjectsProgress = {
    'Maths': {
      'quizzesTaken': 0,
      'quizzesPassed': 0,
      'quizzesFailed': 0,
      'totalScore': 0.0,
    },
    'Science': {
      'quizzesTaken': 0,
      'quizzesPassed': 0,
      'quizzesFailed': 0,
      'totalScore': 0.0,
    },
    'English': {
      'quizzesTaken': 0,
      'quizzesPassed': 0,
      'quizzesFailed': 0,
      'totalScore': 0.0,
    },
    'History': {
      'quizzesTaken': 0,
      'quizzesPassed': 0,
      'quizzesFailed': 0,
      'totalScore': 0.0,
    },
  };

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          var data = snapshot.data() as Map<String, dynamic>;
          setState(() {
            subjectsProgress = data['subjects'] != null
                ? Map<String, dynamic>.from(data['subjects'])
                : subjectsProgress;
          });
        } else {
          await flutterTts.speak(
              'No progress data found. Please complete some quizzes first.');
        }
      } catch (e) {
        print('Error loading data: $e');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveProgress() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).set({
          'subjects': subjectsProgress,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Progress saved successfully!')),
        );
      } catch (e) {
        print('Error saving data: $e');
      }
    }
  }

  void _recordQuizScore(String subject, double score, bool passed) {
    setState(() {
      if (!subjectsProgress.containsKey(subject)) {
        subjectsProgress[subject] = {
          'quizzesTaken': 0,
          'quizzesPassed': 0,
          'quizzesFailed': 0,
          'totalScore': 0.0,
        };
      }

      subjectsProgress[subject]['quizzesTaken']++;
      subjectsProgress[subject]['totalScore'] += score;

      if (passed) {
        subjectsProgress[subject]['quizzesPassed']++;
      } else {
        subjectsProgress[subject]['quizzesFailed']++;
      }
    });

    _saveProgress();
  }

  String calculateAverageScore(String subject) {
    var subjectData = subjectsProgress[subject];
    return subjectData['quizzesTaken'] > 0
        ? (subjectData['totalScore'] / subjectData['quizzesTaken'])
            .toStringAsFixed(2)
        : '0.0';
  }

  Widget _buildSubjectInfoCard(String subject) {
    var subjectData = subjectsProgress[subject];
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orangeAccent, Colors.redAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.book, size: 40, color: Colors.white.withOpacity(0.9)),
            const SizedBox(height: 10),
            Text(
              '$subject Progress',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Quizzes Taken: ${subjectData['quizzesTaken']}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Quizzes Passed: ${subjectData['quizzesPassed']}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Quizzes Failed: ${subjectData['quizzesFailed']}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Average Score: ${calculateAverageScore(subject)}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: subjectData['quizzesTaken'] > 0
                  ? subjectData['quizzesPassed'] / subjectData['quizzesTaken']
                  : 0.0,
              backgroundColor: Colors.white.withOpacity(0.3),
              color: Colors.white,
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.redAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Your Progress',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.redAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Overall Progress',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Icon(Icons.emoji_events,
                            size: 50, color: Colors.yellow.shade700),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: subjectsProgress.length,
                    itemBuilder: (context, index) {
                      String subject = subjectsProgress.keys.elementAt(index);
                      return _buildSubjectInfoCard(subject);
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveProgress,
        label: const Text('Save Progress'),
        icon: const Icon(Icons.save),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
