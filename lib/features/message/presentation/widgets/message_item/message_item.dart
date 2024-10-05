import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/nomal_message_item.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/system_message_item.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final List<Message> messages;
  final int index;

  const MessageItem({
    super.key,
    required this.message,
    required this.messages,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: HandleMessageUtil.isSameSenderMessage(
          messages,
          message,
          index,
        )
            ? 6
            : 12,
      ),
      child: (message.type == MessageTypeEnum.SYSTEM)
          ?
          // message hệ thống
          SystemMessageItem(
              message: message,
            )
          :
          // message thường
          NomalMessageItem(
              messages: messages,
              message: message,
              index: index,
            ),
    );
  }
}
