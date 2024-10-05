import 'package:app1/LoginScreen.dart';
import 'package:app1/SpeechToTextService.dart';
import 'package:app1/TextToSpeechService.dart';
import 'package:app1/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'splash_screen.dart'; // Import your splash screen or home screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize services if needed (optional)
  TextToSpeechService().initialize(); // If there's an initialization method
  SpeechToTextService().initialize(); // If there's an initialization method

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
        '/': (context) => const SplashScreen(), // Your splash screen
        '/login': (context) => LoginScreen(), // Your login screen
        '/welcome': (context) => const WelcomeScreen(userName: 'User'), // Pass the user name dynamically or modify accordingly
      },
    );
  }
}
