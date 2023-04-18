import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:will_do_full_app/feature/auth/authentication_view.dart';
import 'package:will_do_full_app/feature/home/home_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeView();
          } else {
            return const AuthenticationView();
          }
        },
      ),
    );
  }
}
