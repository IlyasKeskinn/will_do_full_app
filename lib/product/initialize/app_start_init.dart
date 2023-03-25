import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/firebase_options.dart';
import 'package:will_do_full_app/product/initialize/app_cache.dart';

class AppStartInitialize {
  AppStartInitialize._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DeviceUtility.instance.initPackageInfo();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      GoogleProvider(clientId: 'clientId'),
      FacebookProvider(clientId: 'clientId'),
    ]);

    await AppCache.instance.Setup();
  }
}
