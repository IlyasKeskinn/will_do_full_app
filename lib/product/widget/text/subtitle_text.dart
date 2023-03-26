import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: ColorConst.white,
      ),
    );
  }
}
