import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:flutter/material.dart';

class SystemMessageItem extends StatelessWidget {
  final Message message;
  const SystemMessageItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message.text ?? ''),
      ],
    );
  }
}
