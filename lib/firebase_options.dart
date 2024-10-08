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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCZpHx8ToGB5EYoknfXoquskpewHBIidjE',
    appId: '1:769077879759:web:78b9778286e08d1c7628ba',
    messagingSenderId: '769077879759',
    projectId: 'sampleproject1-2cb77',
    authDomain: 'sampleproject1-2cb77.firebaseapp.com',
    databaseURL: 'https://sampleproject1-2cb77-default-rtdb.firebaseio.com',
    storageBucket: 'sampleproject1-2cb77.appspot.com',
    measurementId: 'G-5FK3DVQP96',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfqopCLJUj9dFKZeW-RA6psv-lB1k-2AU',
    appId: '1:769077879759:android:90425c5dbe11cb657628ba',
    messagingSenderId: '769077879759',
    projectId: 'sampleproject1-2cb77',
    databaseURL: 'https://sampleproject1-2cb77-default-rtdb.firebaseio.com',
    storageBucket: 'sampleproject1-2cb77.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkjVq4VdhEGvDIS4rQDE4pkb4jKFqcm_A',
    appId: '1:769077879759:ios:d0ef8bc540850d687628ba',
    messagingSenderId: '769077879759',
    projectId: 'sampleproject1-2cb77',
    databaseURL: 'https://sampleproject1-2cb77-default-rtdb.firebaseio.com',
    storageBucket: 'sampleproject1-2cb77.appspot.com',
    iosBundleId: 'com.example.barangayAdittionHillsApp',
  );

}