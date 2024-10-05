// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC2-1jOAaZc3hJgupt_jdfVWg4DCcydoFE',
    appId: '1:45819150913:web:78c1e61253272a32a43cc0',
    messagingSenderId: '45819150913',
    projectId: 'smartvisioned',
    authDomain: 'smartvisioned.firebaseapp.com',
    storageBucket: 'smartvisioned.appspot.com',
    measurementId: 'G-T972M8NRBS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsvEhsITYemtusUV20dHezCMCPMyvdxBw',
    appId: '1:45819150913:android:e45592c30fe370b7a43cc0',
    messagingSenderId: '45819150913',
    projectId: 'smartvisioned',
    storageBucket: 'smartvisioned.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQ4oUBZLff0QUnLPBlXL8-2DVnZzgIz8Q',
    appId: '1:45819150913:ios:9904094af68cbfb8a43cc0',
    messagingSenderId: '45819150913',
    projectId: 'smartvisioned',
    storageBucket: 'smartvisioned.appspot.com',
    androidClientId: '45819150913-hr2652dev3259jbpoifkr4ihkd9he6jj.apps.googleusercontent.com',
    iosClientId: '45819150913-n9o5d4cl7ajgqaamo2lfn9hkvknthi05.apps.googleusercontent.com',
    iosBundleId: 'com.example.app1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgvhB55PZ0ms3KNyXXRfAoDjvb4VrlzV4',
    appId: '1:176281702429:ios:e8e6258af61ecbfaf1b6f4',
    messagingSenderId: '176281702429',
    projectId: 'app1-f0f3f',
    storageBucket: 'app1-f0f3f.appspot.com',
    iosBundleId: 'com.example.app1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBUwu2r4nZDvsebDTQh65dhtEZSmnVUi_0',
    appId: '1:176281702429:web:9f3d75a2a380c900f1b6f4',
    messagingSenderId: '176281702429',
    projectId: 'app1-f0f3f',
    authDomain: 'app1-f0f3f.firebaseapp.com',
    storageBucket: 'app1-f0f3f.appspot.com',
    measurementId: 'G-S0XK0TC8MT',
  );
}