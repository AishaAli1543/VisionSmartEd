import 'dart:developer';
import 'package:app1/SpeechToTextService.dart';
import 'package:app1/TextToSpeechService.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'LoginScreen.dart'; // Import the LoginScreen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextToSpeechService _textToSpeechService = TextToSpeechService();
  final SpeechToTextService _speechToTextService = SpeechToTextService();
  bool isVisuallyImpaired = false;

  // Method to handle sign-up with Firebase
  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      log('Passwords do not match.');
      return;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User signed up successfully: ${credential.user!.email}');
      _textToSpeechService.speak('User signed up successfully.'); // Text-to-speech feedback
      // You can navigate to the login screen or home screen after successful sign-up
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        _textToSpeechService.speak('The password provided is too weak.'); // Text-to-speech feedback
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        _textToSpeechService.speak('The account already exists for that email.'); // Text-to-speech feedback
      }
    } catch (e) {
      log('An error occurred: $e');
      _textToSpeechService.speak('An error occurred. Please try again.'); // Text-to-speech feedback
    }
  }

  // Method to start speech recognition
  void _startListening() async {
    await _speechToTextService.initialize(); // Initialize the service
    _speechToTextService.startListening((text) {
      // This callback is triggered when speech is recognized
      _emailController.text = text; // Populate email controller with recognized text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!isVisuallyImpaired) ...[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                onTap: _startListening, // Start listening when tapping on email field
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Create a password',
                ),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp, // Call the Firebase sign-up method
                child: const Text('Sign up'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text('Log in'),
              ),
            ] else ...[
              const Text('Welcome, we are adjusting for your needs.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Logic to proceed with text-to-speech or impaired features
                },
                child: const Text('Proceed with Accessibility'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
