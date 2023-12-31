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
    apiKey: 'AIzaSyA-9rjLl1PfOChhcaHLQ42kxUQTfruOqfI',
    appId: '1:352172636195:web:92fd16d869514efd755996',
    messagingSenderId: '352172636195',
    projectId: 'makeup-store-2',
    authDomain: 'makeup-store-2.firebaseapp.com',
    storageBucket: 'makeup-store-2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7Mc1c7sl1M4IYbef1wWO_nSvzFWcEyNI',
    appId: '1:352172636195:android:948ca85cf02e5741755996',
    messagingSenderId: '352172636195',
    projectId: 'makeup-store-2',
    storageBucket: 'makeup-store-2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCh5UMjRdvlfBl2jkSO_lCIpD2VGzAs9G4',
    appId: '1:352172636195:ios:b40edefde9dfa8a5755996',
    messagingSenderId: '352172636195',
    projectId: 'makeup-store-2',
    storageBucket: 'makeup-store-2.appspot.com',
    iosClientId:
        '352172636195-on1o4r0e6a1a1ibf0l31sbsfh02tfd86.apps.googleusercontent.com',
    iosBundleId: 'com.example.jbeauty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCh5UMjRdvlfBl2jkSO_lCIpD2VGzAs9G4',
    appId: '1:352172636195:ios:b40edefde9dfa8a5755996',
    messagingSenderId: '352172636195',
    projectId: 'makeup-store-2',
    storageBucket: 'makeup-store-2.appspot.com',
    iosClientId:
        '352172636195-on1o4r0e6a1a1ibf0l31sbsfh02tfd86.apps.googleusercontent.com',
    iosBundleId: 'com.example.jbeauty',
  );
}
