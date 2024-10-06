import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/message_body.dart';
import 'package:flutter/material.dart';

class ImageMessage extends StatelessWidget {
  final Message message;
  final MessageBodyType messageBodyType;

  const ImageMessage({
    super.key,
    required this.message,
    required this.messageBodyType,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: messageBodyType == MessageBodyType.normal ? 1 : 0.5,
        child: Image.network(
          message.image!,
        ),
      ),
    );
  }
}
