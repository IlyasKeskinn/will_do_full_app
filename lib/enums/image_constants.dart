// ignore_for_file: sort_constructors_first

enum ImageConstants {
  microphone('ic_microphone');

  final String value;

  const ImageConstants(this.value);

  String get toPng => 'assets/icon/$value.png';
}
