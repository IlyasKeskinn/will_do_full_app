class CustomFirebaseException implements Exception {
  CustomFirebaseException(this.error);

  final String error;

  @override
  String toString() {
    return '$this $error';
  }
}

class CustomVersionException implements Exception {
  CustomVersionException(this.error);

  final String error;

  @override
  String toString() {
    return '$this $error';
  }
}
