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
    apiKey: 'AIzaSyD94YTUsZK-AXVR5mvcRL6tD_2QIxhgp6c',
    appId: '1:432394759604:web:6752d8437b6490654356e1',
    messagingSenderId: '432394759604',
    projectId: 'eventus-66041',
    authDomain: 'eventus-66041.firebaseapp.com',
    storageBucket: 'eventus-66041.appspot.com',
    measurementId: 'G-1TJCSJMEQ7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYLMdydqDgMVosF2ydbI1CgLc7Ku0HGQs',
    appId: '1:432394759604:android:c11d4048d7ac19e14356e1',
    messagingSenderId: '432394759604',
    projectId: 'eventus-66041',
    storageBucket: 'eventus-66041.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDH0g1CHL90sMt-twjSsS_6hyN0O4spK1E',
    appId: '1:432394759604:ios:fb79dbc537fb52464356e1',
    messagingSenderId: '432394759604',
    projectId: 'eventus-66041',
    storageBucket: 'eventus-66041.appspot.com',
    iosBundleId: 'com.example.mypart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDH0g1CHL90sMt-twjSsS_6hyN0O4spK1E',
    appId: '1:432394759604:ios:ee56acd2af9d5fc94356e1',
    messagingSenderId: '432394759604',
    projectId: 'eventus-66041',
    storageBucket: 'eventus-66041.appspot.com',
    iosBundleId: 'com.example.mypart.RunnerTests',
  );
}
