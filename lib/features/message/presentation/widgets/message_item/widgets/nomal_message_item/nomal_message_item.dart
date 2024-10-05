import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/models/user_info.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/message_item_controller.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_timestamp.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_item_util.dart';
import 'package:flutter/material.dart';

class NomalMessageItem extends StatelessWidget {
  final Message message;
  final List<Message> messages;
  final int index;

  NomalMessageItem({
    super.key,
    required this.message,
    required this.messages,
    required this.index,
  });

  final auth = UserInfo(id: '4867a4a8-0a22-4af0-a15c-9d83a48e05b4');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // thời gian gửi
        MessageTimestamp(message: message),

        Row(
          mainAxisAlignment:
              HandleMessageItemUtil.getMainAxisAlignmentByMessage(
            message,
            auth,
          ),
          children: [
            MessageItemController(
              messages: messages,
              message: message,
              index: index,
            ),
          ],
        ),
      ],
    );
  }
}
