import 'package:flutter/material.dart';

enum ImageConstants {
  checklist('checklist');

  final String value;

  const ImageConstants(this.value);

  String get toPath => 'assets/image/img_$value.png';
  Image get toImg => Image.asset(toPath);
}
