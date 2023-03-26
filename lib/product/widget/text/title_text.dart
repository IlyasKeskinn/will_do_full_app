import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w500,
        color: ColorConst.white,
      ),
    );
  }
}
