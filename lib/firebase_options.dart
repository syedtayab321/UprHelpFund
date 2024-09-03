
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
    apiKey: 'AIzaSyAVBnMrW6ZCQUODUNOiKYR2b6JEKhDAC80',
    appId: '1:730656630741:web:46cb93c63117b5ecb33f5c',
    messagingSenderId: '730656630741',
    projectId: 'uprfundcollection',
    authDomain: 'uprfundcollection.firebaseapp.com',
    storageBucket: 'uprfundcollection.appspot.com',
    measurementId: 'G-1PRCB8ZJPE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEeA6QcTWo_CLHnOUOnwWzWKCOhfkSERU',
    appId: '1:730656630741:android:f2fc076aabadf1bdb33f5c',
    messagingSenderId: '730656630741',
    projectId: 'uprfundcollection',
    storageBucket: 'uprfundcollection.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsvJu6FNHOwBeMi2bg5UbqwczTlKwjrLM',
    appId: '1:730656630741:ios:aed24b1367824be5b33f5c',
    messagingSenderId: '730656630741',
    projectId: 'uprfundcollection',
    storageBucket: 'uprfundcollection.appspot.com',
    iosBundleId: 'com.example.uprFundCollection',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsvJu6FNHOwBeMi2bg5UbqwczTlKwjrLM',
    appId: '1:730656630741:ios:aed24b1367824be5b33f5c',
    messagingSenderId: '730656630741',
    projectId: 'uprfundcollection',
    storageBucket: 'uprfundcollection.appspot.com',
    iosBundleId: 'com.example.uprFundCollection',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAVBnMrW6ZCQUODUNOiKYR2b6JEKhDAC80',
    appId: '1:730656630741:web:ba0c893afda63c96b33f5c',
    messagingSenderId: '730656630741',
    projectId: 'uprfundcollection',
    authDomain: 'uprfundcollection.firebaseapp.com',
    storageBucket: 'uprfundcollection.appspot.com',
    measurementId: 'G-XW23SKLSCK',
  );
}
