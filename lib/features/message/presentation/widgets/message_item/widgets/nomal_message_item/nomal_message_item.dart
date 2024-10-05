import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/message_item_controller.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_timestamp.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';

class NomalMessageItem extends StatelessWidget {
  final Message message;
  final List<Message> messages;
  final int index;

  const NomalMessageItem({
    super.key,
    required this.message,
    required this.messages,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // thời gian gửi
        MessageTimestamp(message: message),

        Row(
          // nếu message của auth thì cho nó ở cuối, ngược lại ở đầu
          mainAxisAlignment:
              HandleMessageUtil.isMessageByAuth(context, message: message)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
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
