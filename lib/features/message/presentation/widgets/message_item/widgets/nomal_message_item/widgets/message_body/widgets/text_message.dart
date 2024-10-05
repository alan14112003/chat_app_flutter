import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/models/user_info.dart';
import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/message_body.dart';
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
    const auth = UserInfo(id: '4867a4a8-0a22-4af0-a15c-9d83a48e05b4');
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
        color: auth.id == message.sender?.id
            ? Colors.white
            : Theme.of(context).onSurface20,
      ),
    );
  }
}
