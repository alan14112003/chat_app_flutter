import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String? errorText;
  final Function(String)? onChanged;

  const LoginInputField({
    super.key,
    required this.hintText,
    required this.obscureText,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
  }
}
