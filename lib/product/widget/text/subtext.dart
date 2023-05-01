import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';

class SubText extends StatelessWidget {
  const SubText({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 4,
      textWidthBasis: TextWidthBasis.longestLine,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      value,
      style: context.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w100,
        color: ColorConst.white,
      ),
    );
  }
}
