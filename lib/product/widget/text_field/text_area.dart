import 'package:flutter/material.dart';

class InputArea extends StatelessWidget {
  const InputArea({
    required this.controller,
    this.maxLinesValue,
    this.minLinesValue,
    this.maxLengthValue
  });

  final TextEditingController controller;
  final int? maxLinesValue;
  final int? minLinesValue;
  final int? maxLengthValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: minLinesValue ?? 3,
      maxLines: maxLinesValue ?? 3,
      maxLength: maxLengthValue ?? 150,
    );
  }
}
