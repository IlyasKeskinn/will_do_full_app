import 'package:flutter/material.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.value, required this.click});
  final String value;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConst.primaryColor,
        ),
        onPressed: click,
        child: Text(value),
      ),
    );
  }
}
