import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;

  const LoginInputField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
  }
}
