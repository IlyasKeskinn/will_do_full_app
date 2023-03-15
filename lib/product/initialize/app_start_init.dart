import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:will_do_full_app/firebase_options.dart';

class AppStartInitialize {
  AppStartInitialize._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
