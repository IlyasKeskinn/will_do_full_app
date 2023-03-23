// ignore_for_file: sort_constructors_first

import 'package:flutter/cupertino.dart';

enum ImageConstants {
  logo('logo');

  final String value;

  const ImageConstants(this.value);

  String get toPng => 'assets/icons/ic_$value.png';
  Image get toImage => Image.asset(toPng);
}
