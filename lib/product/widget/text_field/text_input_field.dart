import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.controller,
    required this.hintValue,
  });

  final TextEditingController controller;
  final String hintValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isNullOrEmpty) {
          return AppText.titleNotEmpty.toCapitalized();
        }
        return null;
      },
      
      maxLength: 50,
      decoration: InputDecoration(
        hintText: hintValue,
      ),
    );
  }
}
