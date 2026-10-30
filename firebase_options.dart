import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoHJWO7motLMqjGobFjoK5x_Buf-gqVn0',
    appId: '1:530302994817:android:d57ac892dd981c0c480080',
    messagingSenderId: '530302994817',
    projectId: 'myschoolapp-21a8b',
    storageBucket: 'myschoolapp-21a8b.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBoHJWO7motLMqjGobFjoK5x_Buf-gqVn0',
    appId: '1:530302994817:web:d57ac892dd981c0c480080',
    messagingSenderId: '530302994817',
    projectId: 'myschoolapp-21a8b',
    storageBucket: 'myschoolapp-21a8b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoHJWO7motLMqjGobFjoK5x_Buf-gqVn0',
    appId: '1:530302994817:ios:d57ac892dd981c0c480080',
    messagingSenderId: '530302994817',
    projectId: 'myschoolapp-21a8b',
    storageBucket: 'myschoolapp-21a8b.firebasestorage.app',
  );
}
