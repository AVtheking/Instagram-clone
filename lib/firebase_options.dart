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
    apiKey: 'AIzaSyDZ-CINWg7SQ8d8VtQt6EPRBG49_rLNR9s',
    appId: '1:905638514145:web:5a3a1667ffbc2f1c9f96a0',
    messagingSenderId: '905638514145',
    projectId: 'instagram-clone-c2003',
    authDomain: 'instagram-clone-c2003.firebaseapp.com',
    storageBucket: 'instagram-clone-c2003.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUmmvoTD1z47ZruSV1Jbtmj5QJWQ5Woig',
    appId: '1:905638514145:android:792e08c2b0e933ab9f96a0',
    messagingSenderId: '905638514145',
    projectId: 'instagram-clone-c2003',
    storageBucket: 'instagram-clone-c2003.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBe_85mHoyEjnxpV_zKocfUbej0M3J9E1E',
    appId: '1:905638514145:ios:4663d1efd62423d59f96a0',
    messagingSenderId: '905638514145',
    projectId: 'instagram-clone-c2003',
    storageBucket: 'instagram-clone-c2003.appspot.com',
    iosClientId: '905638514145-gfprbkpdd7p3kf9u6hjsop8gnqap025b.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBe_85mHoyEjnxpV_zKocfUbej0M3J9E1E',
    appId: '1:905638514145:ios:4deba3605b6a2e6c9f96a0',
    messagingSenderId: '905638514145',
    projectId: 'instagram-clone-c2003',
    storageBucket: 'instagram-clone-c2003.appspot.com',
    iosClientId: '905638514145-pf0r266rp6mhgoj5q6m1greuc4vcobji.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramClone.RunnerTests',
  );
}