import 'package:flutter/material.dart';

import '../../../common/utils/colors.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Boş bırakılmaz!';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: bgColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
