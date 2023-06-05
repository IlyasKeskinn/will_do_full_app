import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/auth/keys.dart';
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
                  footerBuilder: (context, action) {
                    return or_divider(context);
                  },
                  actionButtonLabelOverride: AppText.loginSign,
                  action: AuthAction.signIn,
                  providers: FirebaseUIAuth.providersFor(
                    FirebaseAuth.instance.app,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OAuthProviderButton(
                      variant: OAuthButtonVariant.icon,
                      action: AuthAction.signIn,
                      provider: GoogleProvider(
                        clientId: Keys.client_id,
                        redirectUri: Keys.redirecet_uri,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Padding or_divider(BuildContext context) {
  return Padding(
    padding: context.verticalPaddingLow,
    child: Row(
      children: const [
        Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
        Text('or'),
        Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    ),
  );
}
