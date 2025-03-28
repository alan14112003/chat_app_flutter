import 'package:flutter/material.dart';

class LoginBtn extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final String name;

  const LoginBtn({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.name = 'Đăng nhập',
  });

  @override
  State<LoginBtn> createState() => _LoginBtnState();
}

class _LoginBtnState extends State<LoginBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: Color.fromRGBO(27, 114, 192, 1.0),
          foregroundColor: Color.fromRGBO(211, 228, 255, 1.0),
        ),
        child: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
