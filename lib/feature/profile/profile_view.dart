import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/enums/image_constants.dart';
import 'package:will_do_full_app/feature/auth/auth_page.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';
import 'package:will_do_full_app/product/model/users.dart';
import 'package:will_do_full_app/product/provider/profile_provider.dart';
import 'package:will_do_full_app/product/utility/image/pick_image.dart';
import 'package:will_do_full_app/product/widget/buttons/primary_button.dart';
import 'package:will_do_full_app/product/widget/text/subtitle_text.dart';

final _profileProvider =
    StateNotifierProvider<ProfileProvider, ProfileState>((ref) {
  return ProfileProvider();
});
bool _isLoading = false;

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    ref.read(_profileProvider.notifier).fetchuser();
  }

  @override
  Widget build(BuildContext context) {
    final userItem = ref.watch(_profileProvider).userItem;
    if (userItem == null) {
      // userItem henüz null ise, yükleme göstergesi gösterin
      return const Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppText.profileTitlte),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Opacity(
                opacity: _isLoading ? 0.2 : 1,
                child: IgnorePointer(
                  ignoring: _isLoading,
                  child: Padding(
                    padding: context.horizontalPaddingNormal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ImageBox(user: userItem),
                        context.emptySizedHeightBoxLow,
                        Text(userItem.name.toCapitalized()),
                        context.emptySizedHeightBoxLow,
                        const _Buttons(),
                        context.emptySizedHeightBoxLow3x,
                        const _SettingsColumn(),
                        const _LogoutButton(),
                      ],
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      );
    }
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
          event: () {},
        ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.person_outline),
          settingsName: AppText.profileEditAcountName,
          event: () {
            showModalBottomSheet(
              barrierColor: ColorConst.darkgrey.withOpacity(0.9),
              backgroundColor: ColorConst.backgrounColor,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const _ChangeAccountName(),
                );
              },
            );
          },
        ),
        // context.emptySizedHeightBoxLow3x,
        // _SettingsTile(
        //   leadingIcon: const Icon(Icons.key_outlined),
        //   settingsName: AppText.profileEditPassword,
        //   event: () {},
        // ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.camera_alt_outlined),
          settingsName: AppText.profileEditImage,
          event: () {
            showModalBottomSheet(
              barrierColor: ColorConst.darkgrey.withOpacity(0.9),
              backgroundColor: ColorConst.backgrounColor,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const _ChangeAccountImage();
              },
            );
          },
        ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.analytics_outlined),
          settingsName: AppText.profileAboutUS,
          event: () {},
        ),
        context.emptySizedHeightBoxLow3x,
        _SettingsTile(
          leadingIcon: const Icon(Icons.flash_on_outlined),
          settingsName: AppText.profileHelpFeedback,
          event: () {},
        ),
      ],
    );
  }
}

class _ChangeAccountImage extends ConsumerStatefulWidget {
  const _ChangeAccountImage();

  @override
  ConsumerState<_ChangeAccountImage> createState() =>
      _ChangeAccountImageState();
}

class _ChangeAccountImageState extends ConsumerState<_ChangeAccountImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SubtitleText(value: AppText.profileEditImage.toCapitalized()),
          context.emptySizedHeightBoxLow,
          Divider(
            color: ColorConst.white,
            thickness: 2,
            indent: 40,
            endIndent: 40,
          ),
          context.emptySizedHeightBoxLow,
          TextButton(
            onPressed: () async {
              await ref.watch(_profileProvider.notifier).pickImageAndUpdateUser(
                    ImageSourceReference.camera.reference,
                  );
            },
            child: Text(AppText.tackPicture.toCapitalized()),
          ),
          context.emptySizedHeightBoxLow,
          TextButton(
            onPressed: () async {
              await ref.watch(_profileProvider.notifier).pickImageAndUpdateUser(
                    ImageSourceReference.gallery.reference,
                  );
            },
            child: Text(AppText.imageFromGallery.toCapitalized()),
          ),
        ],
      ),
    );
  }
}

class _ChangeAccountName extends ConsumerStatefulWidget {
  const _ChangeAccountName();

  @override
  ConsumerState<_ChangeAccountName> createState() => _ChangeAccountNameState();
}

class _ChangeAccountNameState extends ConsumerState<_ChangeAccountName> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(_profileProvider.notifier).fetchuser();
  }

  @override
  Widget build(BuildContext context) {
    nameTitleController.text =
        ref.watch(_profileProvider).userItem!.name.toCapitalized();
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubtitleText(value: AppText.profileEditAcountName.toCapitalized()),
            context.emptySizedHeightBoxLow,
            Divider(
              color: ColorConst.white,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            context.emptySizedHeightBoxLow,
            TextFormField(
              validator: (value) {
                if (value.isNullOrEmpty) {
                  return AppText.titleNotEmpty.toCapitalized();
                }
                return null;
              },
              controller: nameTitleController,
              onTap: () {
                nameTitleController.selection = TextSelection.collapsed(
                  offset: nameTitleController.text.length,
                );
              },
            ),
            context.emptySizedHeightBoxNormal,
            PrimaryButton(
              value: AppText.save,
              click: () async {
                await ref
                    .watch(_profileProvider.notifier)
                    .updateAccountName(nameTitleController.text);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
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
  const _ImageBox({required this.user});
  final Users user;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile-photo',
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: user.profileImage.isNullOrEmpty
              ? Image.asset(
                  ImageConstants.avatar.toPath,
                  width: 100,
                  height: 100,
                )
              : Image.network(
                  //fix
                  user.profileImage ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.leadingIcon,
    required this.settingsName,
    required this.event,
  });
  final Widget leadingIcon;
  final String settingsName;
  final VoidCallback event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: ColorConst.white,
      leading: leadingIcon,
      title: Text(
        settingsName,
      ),
      trailing: IconButton(
        onPressed: event,
        icon: const Icon(Icons.chevron_right_outlined),
      ),
    );
  }
}
