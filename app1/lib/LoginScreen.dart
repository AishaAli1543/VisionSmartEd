import 'dart:developer';
import 'package:app1/SpeechToTextService.dart';
import 'package:app1/TextToSpeechService.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'sign_up_screen.dart';
import 'WelcomeScreen.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextToSpeechService _textToSpeechService = TextToSpeechService();
  final SpeechToTextService _speechToTextService = SpeechToTextService();

  LoginScreen({super.key});

  // Google Sign-In Method
  Future<User?> _signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        // Running on the Web - Use signInWithPopup
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        final UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);
        return userCredential.user;
      } else {
        // Running on Mobile - Use regular signIn flow
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          return userCredential.user;
        }
      }
    } catch (e) {
      log("Error signing in with Google: $e");
      _textToSpeechService.speak("Google Sign-In failed. Please try again."); // Text-to-speech feedback
    }
    return null;
  }

  // Email/Password Sign-In Method
  Future<void> _signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Successfully signed in
      log('User signed in: ${credential.user!.email}');
      _textToSpeechService.speak('User signed in successfully.'); // Text-to-speech feedback
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WelcomeScreen(userName: credential.user?.email ?? 'User'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        _textToSpeechService.speak('No user found for that email.'); // Text-to-speech feedback
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        _textToSpeechService.speak('Wrong password provided for that user.'); // Text-to-speech feedback
      }
    } catch (e) {
      log('An error occurred: $e');
      _textToSpeechService.speak('An error occurred. Please try again.'); // Text-to-speech feedback
    }
  }

  // Error Dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset('assets/logo.png', height: 100),
              const SizedBox(height: 40),
              const Text(
                'Log in',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter password',
                  suffixIcon: const Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  _signInWithEmailAndPassword(context, email, password);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Or Register with'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset('assets/facebook.png')),
                    onPressed: () {
                      _showErrorDialog(
                          context, "Facebook Sign-In not yet implemented.");
                    },
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    icon: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset('assets/google.png')),
                    onPressed: () async {
                      User? user = await _signInWithGoogle(context);
                      if (user != null) {
                        log(
                            "Successfully signed in with Google: ${user.email}");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WelcomeScreen(userName: user.email ?? 'User'),
                          ),
                        );
                      } else {
                        log("Sign in failed or user is null.");
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
