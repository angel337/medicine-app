// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCvojz9tCBq1Dk-7uCPszqYBHn1e1uWbsU',
    appId: '1:182242533335:web:83a09ef096cd294c76b592',
    messagingSenderId: '182242533335',
    projectId: 'pill-reminder-app-352fb',
    authDomain: 'pill-reminder-app-352fb.firebaseapp.com',
    storageBucket: 'pill-reminder-app-352fb.appspot.com',
    measurementId: 'G-PDQVQ0N834',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGTS9_rcpBBBWCPQrGCDgeOcCI_292qJ8',
    appId: '1:182242533335:android:2b198bf78581f6a276b592',
    messagingSenderId: '182242533335',
    projectId: 'pill-reminder-app-352fb',
    storageBucket: 'pill-reminder-app-352fb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrft_FqmZPe5-nDqp9Fe6ULE8iLgWkqg0',
    appId: '1:182242533335:ios:797890c0febbbc4976b592',
    messagingSenderId: '182242533335',
    projectId: 'pill-reminder-app-352fb',
    storageBucket: 'pill-reminder-app-352fb.appspot.com',
    iosClientId: '182242533335-e52ekt5ohnd78j1h69d19tb89da9bs2v.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluttermedimindApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrft_FqmZPe5-nDqp9Fe6ULE8iLgWkqg0',
    appId: '1:182242533335:ios:797890c0febbbc4976b592',
    messagingSenderId: '182242533335',
    projectId: 'pill-reminder-app-352fb',
    storageBucket: 'pill-reminder-app-352fb.appspot.com',
    iosClientId: '182242533335-e52ekt5ohnd78j1h69d19tb89da9bs2v.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluttermedimindApp',
  );
}
