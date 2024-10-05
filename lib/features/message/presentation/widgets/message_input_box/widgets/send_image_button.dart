import 'package:flutter/material.dart';

class SendImageButton extends StatefulWidget {
  const SendImageButton({super.key});

  @override
  State<SendImageButton> createState() => _SendImageButtonState();
}

class _SendImageButtonState extends State<SendImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Xử lý khi nhấn vào icon ảnh
        print("Image icon tapped");
      },
      child: const Icon(
        Icons.image_outlined,
        size: 24,
      ),
    );
  }
}
