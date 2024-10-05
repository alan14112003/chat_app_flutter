import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/message_body.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final Message message;
  final MessageBodyType messageBodyType;

  const TextMessage({
    super.key,
    required this.message,
    this.messageBodyType = MessageBodyType.normal,
  });

  @override
  Widget build(BuildContext context) {
    if (messageBodyType == MessageBodyType.reply) {
      return Text(
        message.text!,
        style: TextStyle(
          color: Colors.white,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Text(
      message.text!,
      style: TextStyle(
        color: HandleMessageUtil.isMessageByAuth(context, message: message)
            ? Colors.white
            : Theme.of(context).onSurface20,
      ),
    );
  }
}
