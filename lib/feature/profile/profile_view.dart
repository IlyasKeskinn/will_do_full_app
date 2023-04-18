import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/enums/image_constants.dart';
import 'package:will_do_full_app/feature/auth/auth_page.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.profileTitlte),
      ),
      body: ListView(
        children: [
          Padding(
            padding: context.horizontalPaddingNormal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _ImageBox(),
                context.emptySizedHeightBoxLow,
                const Text('İlyas Keskin'),
                context.emptySizedHeightBoxLow,
                const _Buttons(),
                context.emptySizedHeightBoxLow3x,
                const _SettingsColumn(),
                const _LogoutButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    Future<void> logOut() async {
      await FirebaseAuth.instance.signOut();
      await context.navigateToPage(const AuthPage());
    }

    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: ColorConst.error,
      ),
      onPressed: logOut,
      icon: const Icon(Icons.logout_outlined),
      label: Text(AppText.logout),
    );
  }
}

class _SettingsColumn extends StatelessWidget {
  const _SettingsColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SettingsTile(
          leadingIcon: const Icon(Icons.settings_outlined),
          settingsName: AppText.profileAppSettings,
        ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.person_outline),
          settingsName: AppText.profileEditAcountName,
        ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.key_outlined),
          settingsName: AppText.profileEditPassword,
        ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.camera_alt_outlined),
          settingsName: AppText.profileEditImage,
        ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.analytics_outlined),
          settingsName: AppText.profileAboutUS,
        ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.flash_on_outlined),
          settingsName: AppText.profileHelpFeedback,
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingLow,
      child: Row(
        children: [
          _ProfileTaskButton(
            buttonName: '6 ${AppText.profileTaskLeft}',
          ),
          context.emptySizedWidthBoxLow3x,
          _ProfileTaskButton(
            buttonName: '2 ${AppText.profileTaskDone}',
          ),
        ],
      ),
    );
  }
}

class _ProfileTaskButton extends StatelessWidget {
  _ProfileTaskButton({required this.buttonName});
  String buttonName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        child: Text(buttonName),
      ),
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          ImageConstants.avatar.toPath,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.leadingIcon,
    required this.settingsName,
  });
  final Widget leadingIcon;
  final String settingsName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: ColorConst.white,
      leading: leadingIcon,
      title: Text(
        settingsName,
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.chevron_right_outlined),
      ),
    );
  }
}
