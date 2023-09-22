import 'package:flutter/material.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';

class OAYSCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  const OAYSCustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            // hintText: labelText,
            labelText: labelText,
            labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: hintTextColor)),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: oaysFontColor,
        ),
      ),
    );
  }
}
