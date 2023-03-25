import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/feature/auth/authentication_provider.dart';
import 'package:will_do_full_app/feature/home/home_view.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  final authenticationProvider =
      StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
    return AuthenticationNotifier();
  });

  @override
  void initState() {
    checkUser(FirebaseAuth.instance.currentUser);
    super.initState();
  }

  void checkUser(User? user) {
    ref.read(authenticationProvider.notifier).fetchUserDetail(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FirebaseUIActions(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              if (state.user != null) {
                checkUser(state.user);
                if (ref.watch(authenticationProvider).isRedirecHome ?? false) {
                  context.navigateToPage(const HomeView());
                }
              }
            }),
          ],
          child: Padding(
            padding: context.paddingLow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginView(
                  actionButtonLabelOverride: AppText.loginSign,
                  action: AuthAction.signIn,
                  providers: FirebaseUIAuth.providersFor(
                    FirebaseAuth.instance.app,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
