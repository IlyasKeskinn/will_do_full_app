// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:will_do_full_app/product/model/users.dart';
import 'package:will_do_full_app/product/utility/exception/custom_exception.dart';

import 'package:will_do_full_app/product/utility/firebase/firebase_collection.dart';
import 'package:will_do_full_app/product/utility/image/pick_image.dart';

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(const ProfileState());

  Future<void> fetchuser() async {
    final response = await FirebaseCollection.users.reference
        .where(
          'userId',
          whereIn: [FirebaseAuth.instance.currentUser!.uid],
        )
        .withConverter<Users>(
          fromFirestore: (snapshot, options) => Users().fromFirebase(snapshot),
          toFirestore: (value, options) {
            if (value == null) {
              throw CustomFirebaseException('$value not null');
            } else {
              return {};
            }
          },
        )
        .get();
    final user = response.docs.map((e) => e.data()).toList();
    state = state.copyWith(userItem: user.first);
  }

  XFile? _selectedImage;
  Uint8List? _selectedFileBytes;
  Uint8List? get selectedFileBytes => _selectedFileBytes;

  Future<void> pickImageAndUpdateUser(ImageSource imageSourceReference) async {
    _selectedImage = await PickImage(imageSource: imageSourceReference)
        .pickImageFromGallery();
    _selectedFileBytes = await _selectedImage?.readAsBytes();

    final imageReference = createImageReference();
    if (imageReference == null) throw Exception('Image reference is empty');
    if (_selectedFileBytes == null) return;
    await imageReference.putData(_selectedFileBytes!);

    final imageUrlPath = await imageReference.getDownloadURL();

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final response = await FirebaseCollection.users.reference
        .doc(uid)
        .update({'profileImage': imageUrlPath});

    await fetchuser();
  }

  Reference? createImageReference() {
    if (_selectedImage == null || (_selectedImage?.name.isEmpty ?? true)) {
      return null;
    }
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final imageName = uid;
    final storageRef = FirebaseStorage.instance.ref('ppics');
    final imageRef = storageRef.child(imageName);
    return imageRef;
  }
}

class ProfileState extends Equatable {
  const ProfileState({this.userItem});
  final Users? userItem;

  @override
  List<Object?> get props => [userItem];

  ProfileState copyWith({
    Users? userItem,
  }) {
    return ProfileState(
      userItem: userItem ?? this.userItem,
    );
  }
}
