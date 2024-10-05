import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/message_body.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/widgets/ondragging_reply_icon.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';

class MessageItemByOther extends StatelessWidget {
  final Message message;
  final List<Message> messages;
  final int index;
  final bool isDragging;

  const MessageItemByOther({
    super.key,
    required this.message,
    required this.messages,
    required this.index,
    required this.isDragging,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        // nếu kéo thì hiện reply icon
        if (isDragging) const OnDraggingReplyIcon(),

        // kiểm tra điều kiện hợp lệ để tạo ảnh
        if (HandleMessageUtil.isRenderInfoSender(
          context,
          messages: messages,
          message: message,
          index: index,
        ))
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage(message.sender?.avatar ?? ''),
          )
        else
          const SizedBox(
            width: 24,
          ),

        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (HandleMessageUtil.isRenderInfoSender(
              context,
              messages: messages,
              message: message,
              index: index,
            ))
              // tên người gửi
              Text(
                message.sender?.fullName ?? '',
                style: TextStyle(
                  color: Theme.of(context).onSurface60,
                ),
              ),

            // nội dung tin nhắn
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            )
          ],
        ),
      ],
    );
  }
}
