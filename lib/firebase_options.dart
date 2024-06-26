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
    apiKey: 'AIzaSyAl8vY37KaqgqQWIFygMFh5ZbJuYO3xFlQ',
    appId: '1:760921739188:web:c038497a65f57b9a022ce1',
    messagingSenderId: '760921739188',
    projectId: 'tidasports-60eaa',
    authDomain: 'tidasports-60eaa.firebaseapp.com',
    databaseURL: 'https://tidasports-60eaa-default-rtdb.firebaseio.com',
    storageBucket: 'tidasports-60eaa.appspot.com',
    measurementId: 'G-VFBP9WE99R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXgXfc3g7eS7wvE6Vet_F6sGDgO45FGqA',
    appId: '1:760921739188:android:1f943e78ed222f48022ce1',
    messagingSenderId: '760921739188',
    projectId: 'tidasports-60eaa',
    databaseURL: 'https://tidasports-60eaa-default-rtdb.firebaseio.com',
    storageBucket: 'tidasports-60eaa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7kI-kWCinS_kxqSufAsLx4JIEae9Cn7A',
    appId: '1:760921739188:ios:9552beae500bb036022ce1',
    messagingSenderId: '760921739188',
    projectId: 'tidasports-60eaa',
    databaseURL: 'https://tidasports-60eaa-default-rtdb.firebaseio.com',
    storageBucket: 'tidasports-60eaa.appspot.com',
    iosBundleId: 'com.tidasports.partner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7kI-kWCinS_kxqSufAsLx4JIEae9Cn7A',
    appId: '1:760921739188:ios:14116100829f7d04022ce1',
    messagingSenderId: '760921739188',
    projectId: 'tidasports-60eaa',
    databaseURL: 'https://tidasports-60eaa-default-rtdb.firebaseio.com',
    storageBucket: 'tidasports-60eaa.appspot.com',
    iosBundleId: 'com.example.tidapartners',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAl8vY37KaqgqQWIFygMFh5ZbJuYO3xFlQ',
    appId: '1:760921739188:web:31a27d7e8bbdb3b8022ce1',
    messagingSenderId: '760921739188',
    projectId: 'tidasports-60eaa',
    authDomain: 'tidasports-60eaa.firebaseapp.com',
    databaseURL: 'https://tidasports-60eaa-default-rtdb.firebaseio.com',
    storageBucket: 'tidasports-60eaa.appspot.com',
    measurementId: 'G-06GJTNJPWG',
  );

}