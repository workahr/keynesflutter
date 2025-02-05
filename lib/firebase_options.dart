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
    apiKey: 'AIzaSyA9YxGD-QGkRx7TTX-76UWACGQSicblRIw',
    appId: '1:361921610529:web:332a72d3164cdac5aeb460',
    messagingSenderId: '361921610529',
    projectId: 'keynesflutter-222b3',
    authDomain: 'keynesflutter-222b3.firebaseapp.com',
    storageBucket: 'keynesflutter-222b3.appspot.com',
    measurementId: 'G-9PMQEJEFPL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBslcuR9PFxxKhAOv8peuv8lv6lUI0Xaoo',
    appId: '1:361921610529:android:abe499b9802b2d20aeb460',
    messagingSenderId: '361921610529',
    projectId: 'keynesflutter-222b3',
    storageBucket: 'keynesflutter-222b3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCZhgpmL_G_6oc6y0PtAWiTUuGip1_wrU',
    appId: '1:361921610529:android:540f86980f1bf7e6aeb460',
    messagingSenderId: '361921610529',
    projectId: 'keynesflutter-222b3',
    storageBucket: 'keynesflutter-222b3.appspot.com',
    iosBundleId: 'com.rafsun.keynes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCZhgpmL_G_6oc6y0PtAWiTUuGip1_wrU',
    appId: '1:361921610529:android:540f86980f1bf7e6aeb460',
    messagingSenderId: '361921610529',
    projectId: 'keynesflutter-222b3',
    storageBucket: 'keynesflutter-222b3.appspot.com',
    iosBundleId: 'com.rafsun.keynes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9YxGD-QGkRx7TTX-76UWACGQSicblRIw',
    appId: '1:361921610529:web:506a4ae6195b2be5aeb460',
    messagingSenderId: '361921610529',
    projectId: 'keynesflutter-222b3',
    authDomain: 'keynesflutter-222b3.firebaseapp.com',
    storageBucket: 'keynesflutter-222b3.appspot.com',
    measurementId: 'G-32G5NJNMR0',
  );
}
