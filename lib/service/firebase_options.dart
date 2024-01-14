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
    apiKey: 'AIzaSyBVXsdLj3dtRv2qL6bSH6Z3JNY-WlJB5Sk',
    appId: '1:389838344082:web:2670106fe17e2d21043b4b',
    messagingSenderId: '389838344082',
    projectId: 'pyoneer-project',
    authDomain: 'pyoneer-project.firebaseapp.com',
    storageBucket: 'pyoneer-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuc_c3URqEJU0RrA-93BhSaTd8AxJBv1g',
    appId: '1:389838344082:android:4209c58d98827cec043b4b',
    messagingSenderId: '389838344082',
    projectId: 'pyoneer-project',
    storageBucket: 'pyoneer-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1beIFAMi3hA6ZS5WJv6uO37eSfi047N8',
    appId: '1:389838344082:ios:9bfccdf4127cba69043b4b',
    messagingSenderId: '389838344082',
    projectId: 'pyoneer-project',
    storageBucket: 'pyoneer-project.appspot.com',
    androidClientId: '389838344082-f7nbf9tjpho2m8mkgqebab95j2le7bls.apps.googleusercontent.com',
    iosClientId: '389838344082-c2cll3u9fbuuhr209gvka4o2j7r1k68r.apps.googleusercontent.com',
    iosBundleId: 'com.example.pyoneer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1beIFAMi3hA6ZS5WJv6uO37eSfi047N8',
    appId: '1:389838344082:ios:76b76d33bee9ecc1043b4b',
    messagingSenderId: '389838344082',
    projectId: 'pyoneer-project',
    storageBucket: 'pyoneer-project.appspot.com',
    androidClientId: '389838344082-f7nbf9tjpho2m8mkgqebab95j2le7bls.apps.googleusercontent.com',
    iosClientId: '389838344082-1f36h3id2d4c4vm1eg1bhav773bhfa33.apps.googleusercontent.com',
    iosBundleId: 'com.example.pyoneer.RunnerTests',
  );
}