import 'dart:developer';
import 'package:app1/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:flutter_tts/flutter_tts.dart'; // TTS
import 'package:shared_preferences/shared_preferences.dart'; // Shared Preferences
// Import TextToSpeech

class UsernameEntryScreen extends StatefulWidget {
  const UsernameEntryScreen({super.key});

  @override
  _UsernameEntryScreenState createState() => _UsernameEntryScreenState();
}

class _UsernameEntryScreenState extends State<UsernameEntryScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts(); // TTS instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance
  String? _storedUsername;

  @override
  void initState() {
    super.initState();
    _checkStoredUsername();
  }

  // Check if a username is stored in SharedPreferences
  Future<void> _checkStoredUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username'); // Retrieve stored username

    log('Username found: $savedUsername');
    _storedUsername = savedUsername;

    // If username exists, navigate directly to WelcomeScreen
    if (savedUsername != null) { // Ensure savedUsername is not null before navigating
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(userName: savedUsername),
        ),
      );
    }
  }

  // Method to save username in Firestore and locally in SharedPreferences
  Future<void> _saveUsername() async {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      log('Username cannot be empty.');
      await _speak('Username cannot be empty.');
      return;
    }

    try {
      log('Attempting to save username: $username');

      // Save username to Firestore
      await _firestore.collection('users').add({'username': username});
      log('Username saved successfully: $username');
      await _speak('Username saved successfully. Welcome, $username.');

      // Save the username in SharedPreferences for future use
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username); // Save locally

      // Navigate to WelcomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(userName: username),
        ),
      );
    } catch (e) {
      log('Error saving to Firestore: $e');
      await _speak('An error occurred while saving. Please try again.');
    }
  }

  // TTS method to speak text
  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUsername, // Save username when button pressed
              child: const Text('Save Username'),
            ),
          ],
        ),
      ),
    );
  }
}
