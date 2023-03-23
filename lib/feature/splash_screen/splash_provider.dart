// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_do_full_app/enums/platform_enum.dart';
import 'package:will_do_full_app/product/model/number.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_collection.dart';
import 'package:will_do_full_app/product/utility/version_manager.dart';

class SplasProvider extends StateNotifier<SplashState> {
  SplasProvider() : super(const SplashState());

  Future<void> checkUpdate(String clientVersion) async {
    final databaseVersion = await getVersionFromDatabase();

    if (databaseVersion == null || databaseVersion.isEmpty) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }
    final versionManager = VersionManager(
      deviceVersion: clientVersion,
      databaseVersion: databaseVersion,
    );
    if (versionManager.isNeedUpdate()) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }
    state = state.copyWith(isRedirectHome: true);
  }

  Future<String?> getVersionFromDatabase() async {
    // If user comming from browser, we don't need to chechk version control
    if (kIsWeb) return null;
    final response = await FirebaseCollection.version.reference
        .withConverter<Number>(
          fromFirestore: (snapshot, options) => Number().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc(PlatformEnum.platformName)
        .get();
    return response.data()?.number;
  }
}

class SplashState extends Equatable {
  const SplashState({this.isRequiredForceUpdate, this.isRedirectHome});
  final bool? isRequiredForceUpdate;
  final bool? isRedirectHome;

  @override
  List<Object?> get props => [isRequiredForceUpdate, isRedirectHome];

  SplashState copyWith({
    bool? isRequiredForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
      isRequiredForceUpdate:
          isRequiredForceUpdate ?? this.isRequiredForceUpdate,
      isRedirectHome: isRedirectHome ?? this.isRedirectHome,
    );
  }
}
