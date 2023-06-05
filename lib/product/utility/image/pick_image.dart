import 'package:image_picker/image_picker.dart';

class PickImage {
  PickImage({required this.imageSource});
  final ImageSource imageSource;
  Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    // Pick an image.
    final image = await picker.pickImage(source: imageSource);
    if (image == null) return null;
    return image;
  }
}

enum ImageSourceReference {
  camera,
  gallery;

  ImageSource get reference => ImageSource.values.byName(name);
}
