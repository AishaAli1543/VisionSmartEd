import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  // Variables to hold data
  int totalLectures = 24;
  int totalQuizzes = 10;
  int quizzesPassed = 0;
  int quizzesFailed = 0;
  double totalScore = 0;
  int quizzesTaken = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  // Load the saved progress from Firestore
  _loadProgress() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        setState(() {
          quizzesPassed = snapshot['quizzesPassed'] ?? 0;
          quizzesFailed = snapshot['quizzesFailed'] ?? 0;
          totalScore = snapshot['totalScore'] ?? 0.0;
          quizzesTaken = snapshot['quizzesTaken'] ?? 0;
        });
      }
    }
  }

  // Save the progress to Firestore
  _saveProgress() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'quizzesPassed': quizzesPassed,
        'quizzesFailed': quizzesFailed,
        'totalScore': totalScore,
        'quizzesTaken': quizzesTaken,
      });
    }
  }

  // Calculate rank based on the percentage of quizzes passed
  String calculateRank() {
    if (quizzesTaken == 0) return "No rank"; // No quizzes taken
    double passRate = (quizzesPassed / quizzesTaken) * 100;

    if (passRate == 100) {
      return "1st";
    } else if (passRate >= 90) {
      return "Top 5";
    } else if (passRate >= 70) {
      return "Top 10";
    } else if (passRate >= 50) {
      return "Top 25";
    } else {
      return "Below 50th percentile";
    }
  }

  // Function to calculate average score
  double calculateAverageScore() {
    if (quizzesTaken == 0) return 0.0;
    return totalScore / quizzesTaken;
  }

  // Update quiz results after completion
  void updateQuizResults(bool passed, double score) {
    setState(() {
      quizzesTaken++;
      totalScore += score;

      if (passed) {
        quizzesPassed++;
      } else {
        quizzesFailed++;
      }
      _saveProgress(); // Save progress to Firestore
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Track Your ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Progress ',
                    style: TextStyle(color: Colors.orange),
                  ),
                  TextSpan(
                    text: '& Complete Info of ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Your Growth',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    size: 50,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Rank',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    calculateRank(), // Display calculated rank
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildInfoCard(
                    icon: Icons.video_collection,
                    title: 'Total Lectures',
                    value: totalLectures.toString(),
                    iconColor: Colors.blue,
                  ),
                  _buildInfoCard(
                    icon: Icons.quiz,
                    title: 'Total Quizzes',
                    value: totalQuizzes.toString(),
                    iconColor: Colors.purple,
                  ),
                  _buildInfoCard(
                    icon: Icons.check_circle_outline,
                    title: 'Quizzes Passed',
                    value: quizzesPassed.toString(),
                    iconColor: Colors.blue,
                  ),
                  _buildInfoCard(
                    icon: Icons.cancel,
                    title: 'Quizzes Failed',
                    value: quizzesFailed.toString(),
                    iconColor: Colors.purple,
                  ),
                  _buildInfoCard(
                    icon: Icons.score,
                    title: 'Average Score',
                    value: calculateAverageScore().toStringAsFixed(2),
                    iconColor: Colors.green,
                  ),
                  _buildInfoCard(
                    icon: Icons.bar_chart,
                    title: 'Quizzes Taken',
                    value: quizzesTaken.toString(),
                    iconColor: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the info cards
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 40,
              color: iconColor,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
