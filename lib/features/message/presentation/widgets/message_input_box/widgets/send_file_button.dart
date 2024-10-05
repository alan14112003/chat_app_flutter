import 'package:flutter/material.dart';

class SendFileButton extends StatefulWidget {
  const SendFileButton({super.key});

  @override
  State<SendFileButton> createState() => _SendFileButtonState();
}

class _SendFileButtonState extends State<SendFileButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Xử lý khi nhấn vào icon file
        print("File icon tapped");
      },
      child: const Icon(
        Icons.file_present_outlined,
        size: 24,
      ),
    );
  }
}
