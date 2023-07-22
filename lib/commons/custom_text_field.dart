import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String text;
  final TextInputType textInputType;
  const CustomTextField({super.key, required this.textEditingController,  this.isPass = false, required this.text, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
        );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: text,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0),

      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}