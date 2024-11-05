import 'package:flutter/material.dart';

class ActiveEmailInput extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final String? errorText;
  final Function(String)? onChanged;
  final String initialValue; // Thêm tham số để nhận giá trị ban đầu

  const ActiveEmailInput({
    super.key,
    required this.hintText,
    required this.obscureText,
    this.errorText,
    this.onChanged,
    required this.initialValue, // Nhận giá trị ban đầu
  });

  @override
  State<ActiveEmailInput> createState() => _ActiveEmailInputState();
}

class _ActiveEmailInputState extends State<ActiveEmailInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller, // Sử dụng controller để quản lý giá trị
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
      ),
      onChanged: (value) {
        _controller.text = value; // Cập nhật giá trị trong controller
        if (widget.onChanged != null) {
          widget.onChanged!(value); // Gọi callback onChanged
        }
      },
    );
  }
}
