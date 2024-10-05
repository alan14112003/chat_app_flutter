import 'package:flutter/material.dart';

class OnDraggingReplyIcon extends StatelessWidget {
  const OnDraggingReplyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: const Icon(
        Icons.reply, // Hoặc icon bạn muốn hiển thị
      ),
    );
  }
}
