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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8P5RiHEZn7HY6co73iZwB7xo94VrBJVU',
    appId: '1:335544571045:android:cc3308192b89c8770e694c',
    messagingSenderId: '335544571045',
    projectId: 'warranty-tracker-a6492',
    storageBucket: 'warranty-tracker-a6492.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGrVBTY0phaqM9Ld4oq2Pq1HAr7DNPSUc',
    appId: '1:335544571045:ios:7130e5593927804d0e694c',
    messagingSenderId: '335544571045',
    projectId: 'warranty-tracker-a6492',
    storageBucket: 'warranty-tracker-a6492.appspot.com',
    androidClientId: '335544571045-btg9lfgm4vpsid4lhmq4sebpjjbvcmop.apps.googleusercontent.com',
    iosClientId: '335544571045-qij4c9hhgqd73gfa7g3ftic0so394kj7.apps.googleusercontent.com',
    iosBundleId: 'com.warranty-keeper.underDevelopment.app',
  );
}
