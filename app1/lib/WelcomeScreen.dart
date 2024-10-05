import 'package:app1/ProgressScreen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'subject_chapters_screen.dart'; // Import SubjectChaptersScreen from its correct path
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  final String userName;

  const WelcomeScreen({super.key, required this.userName});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {}); // Refresh to show video when initialized
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Greetings ${widget.userName}'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false, // Prevent default back button behavior
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
      ),
      drawer: _buildCustomDrawer(), // Updated drawer function call
      body: SingleChildScrollView( // Added SingleChildScrollView to prevent overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Greetings ${widget.userName}, Welcome Back',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 20),
              const Text(
                'Embrace every challenge as a stepping stone to your greatness',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'For students with impairments, learning is not just about textbooks and tests. '
                'It’s a journey of discovery, where each challenge conquered is a triumph. Every '
                'lesson learned, whether big or small, is a step closer to unlocking their full potential. '
                'With determination and support, they can achieve greatness and inspire others along the way.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to SubjectChaptersScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubjectChaptersScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Explore Subjects',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated Drawer Widget to match the design
  Widget _buildCustomDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Custom Drawer Header for User Information
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.orange,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Text(
                    widget.userName[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30.0,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                // Wrap this text in an Expanded widget to prevent overflow
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis, // Prevent text overflow
                      ),
                      Text(
                        '@${widget.userName.toLowerCase()}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis, // Prevent text overflow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.school,
            text: 'Subject Selections',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubjectChaptersScreen(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.book,
            text: 'Lectures',
            onTap: () {
              Navigator.pop(context); // Placeholder for Lectures screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubjectChaptersScreen(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.quiz,
            text: 'Start Quizzes',
            onTap: () {
              Navigator.pop(context); // Placeholder for Start Quizzes
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubjectChaptersScreen(), // Go to subject selection
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.track_changes,
            text: 'Progress Tracking',
            onTap: () {
              Navigator.pop(context); // Placeholder for Progress Tracking
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProgressScreen(),
                ),
              );
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () async {
              try {
                await _auth.signOut(); // Sign out the user
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).pushReplacementNamed('/login'); // Redirect to login screen
              } catch (e) {
                // Show error if sign-out fails
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: $e')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Helper function to build Drawer Items
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
