import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/message_body.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/widgets/ondragging_reply_icon.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';

class MessageItemByAuth extends StatelessWidget {
  final Message message;
  final bool isDragging;

  const MessageItemByAuth({
    super.key,
    required this.message,
    required this.isDragging,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (HandleMessageUtil.hasReplyMessage(message) &&
                !HandleMessageUtil.isRecallMessage(message)) ...[
              Transform.translate(
                offset: Offset(0, 24),
                child: MessageBody(
                  message: message.reply!,
                  type: MessageBodyType.reply,
                ),
              ),
            ],
            MessageBody(message: message),
          ],
        ),
        if (isDragging) const OnDraggingReplyIcon(),
      ],
    );
  }
}
