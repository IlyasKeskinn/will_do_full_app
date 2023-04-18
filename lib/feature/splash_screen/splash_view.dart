import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/enums/icon_constants.dart';
import 'package:will_do_full_app/feature/auth/auth_page.dart';
import 'package:will_do_full_app/feature/splash_screen/splash_provider.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  final splashProvider = StateNotifierProvider<SplasProvider, SplashState>(
    (ref) {
      return SplasProvider();
    },
  );
  @override
  void initState() {
    super.initState();
    ref.read(splashProvider.notifier).checkUpdate(''.version);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      splashProvider,
      (previous, next) {
        if (next.isRequiredForceUpdate ?? false) {
          showAboutDialog(context: context);
          return;
        }
        if (next.isRedirectHome != null) {
          if (next.isRedirectHome!) {
            context.navigateToPage(const AuthPage());
          }
        }
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.logo.toImage,
            appName(context),
          ],
        ),
      ),
    );
  }
}

Padding appName(BuildContext context) {
  return Padding(
    padding: context.onlyTopPaddingMedium,
    child: Text(
      AppText.appName,
      style: context.textTheme.displaySmall?.copyWith(
        color: ColorConst.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
