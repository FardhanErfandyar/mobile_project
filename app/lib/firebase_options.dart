// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCLsECgHg1QpcQhrRqzqcndajLyGLL4aCM',
    appId: '1:320801857074:web:50e36797327ad6e222662b',
    messagingSenderId: '320801857074',
    projectId: 'mobileprojectfields',
    authDomain: 'mobileprojectfields.firebaseapp.com',
    storageBucket: 'mobileprojectfields.appspot.com',
    measurementId: 'G-ZZPG6GMTB2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8J6N6kzktgkwsFvI9p1szt1Uwxpd_O4E',
    appId: '1:320801857074:android:48ba4a1d4fd2c2e122662b',
    messagingSenderId: '320801857074',
    projectId: 'mobileprojectfields',
    storageBucket: 'mobileprojectfields.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWHquKXsnU0WKihz_SJPw3u_-LD1I-NZA',
    appId: '1:320801857074:ios:f4231326da41ae8e22662b',
    messagingSenderId: '320801857074',
    projectId: 'mobileprojectfields',
    storageBucket: 'mobileprojectfields.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWHquKXsnU0WKihz_SJPw3u_-LD1I-NZA',
    appId: '1:320801857074:ios:2e8092b62466778722662b',
    messagingSenderId: '320801857074',
    projectId: 'mobileprojectfields',
    storageBucket: 'mobileprojectfields.appspot.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}
