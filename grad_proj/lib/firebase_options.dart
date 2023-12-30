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
    apiKey: 'AIzaSyBKlOlsVnE0lb5HSuYyusVCkNyLRLOtgVw',
    appId: '1:988806572251:web:e179b7f837efd2f7c8c4fe',
    messagingSenderId: '988806572251',
    projectId: 'gradproj-a818c',
    authDomain: 'gradproj-a818c.firebaseapp.com',
    storageBucket: 'gradproj-a818c.appspot.com',
    measurementId: 'G-D1CL97P6E5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjwSvBLbsWkqsbmGaBzMNaL2F0hNHOeO0',
    appId: '1:988806572251:android:19fa1707e70b2e7fc8c4fe',
    messagingSenderId: '988806572251',
    projectId: 'gradproj-a818c',
    storageBucket: 'gradproj-a818c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlaxNDs21CmFmKgyvzCiBczOkyN1e12N4',
    appId: '1:988806572251:ios:a6fbeb3914b88f3ac8c4fe',
    messagingSenderId: '988806572251',
    projectId: 'gradproj-a818c',
    storageBucket: 'gradproj-a818c.appspot.com',
    iosBundleId: 'com.example.gradProj',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlaxNDs21CmFmKgyvzCiBczOkyN1e12N4',
    appId: '1:988806572251:ios:decde86abfa63994c8c4fe',
    messagingSenderId: '988806572251',
    projectId: 'gradproj-a818c',
    storageBucket: 'gradproj-a818c.appspot.com',
    iosBundleId: 'com.example.gradProj.RunnerTests',
  );
}