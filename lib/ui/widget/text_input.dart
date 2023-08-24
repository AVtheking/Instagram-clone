import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController textController;
  final String hint;
  final bool isPass;
  const TextInputField({
    super.key,
    required this.textController,
    required this.hint,
    this.isPass = false,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textController,
      obscureText: isPass,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
      ),
    );
  }
}
