class CustomFirebaseException implements Exception {
  CustomFirebaseException(this.error);

  final String error;

  @override
  String toString() {
    return '$this $error';
  }
}
