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
    apiKey: 'AIzaSyD9ry2UN9g1qOkA8leQiDAq54-MNH_aOm0',
    appId: '1:219193522369:web:d5b6efb15ace4223b9bc40',
    messagingSenderId: '219193522369',
    projectId: 'stats-and-estates',
    authDomain: 'stats-and-estates.firebaseapp.com',
    storageBucket: 'stats-and-estates.appspot.com',
    measurementId: 'G-DF9GBR8E3G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWZWHWQaaB2EUc8umjAr5VZY4HoKEu_VQ',
    appId: '1:219193522369:android:14c9e098af5daa54b9bc40',
    messagingSenderId: '219193522369',
    projectId: 'stats-and-estates',
    storageBucket: 'stats-and-estates.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_bqJojEXeFxjX_-Elr0sC4OpSuC8cDxY',
    appId: '1:219193522369:ios:bab42d07f66ffbcdb9bc40',
    messagingSenderId: '219193522369',
    projectId: 'stats-and-estates',
    storageBucket: 'stats-and-estates.appspot.com',
    iosBundleId: 'com.example.statsAndEstates',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_bqJojEXeFxjX_-Elr0sC4OpSuC8cDxY',
    appId: '1:219193522369:ios:635b8a8f620d479ab9bc40',
    messagingSenderId: '219193522369',
    projectId: 'stats-and-estates',
    storageBucket: 'stats-and-estates.appspot.com',
    iosBundleId: 'com.example.statsAndEstates.RunnerTests',
  );
}
