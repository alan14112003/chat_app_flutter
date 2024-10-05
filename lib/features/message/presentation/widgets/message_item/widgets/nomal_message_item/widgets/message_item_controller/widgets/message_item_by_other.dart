import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/models/user_info.dart';
import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/message_body.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_item_controller/widgets/ondragging_reply_icon.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_item_util.dart';
import 'package:flutter/material.dart';

class MessageItemByOther extends StatelessWidget {
  final Message message;
  final List<Message> messages;
  final int index;
  final bool isDragging;

  MessageItemByOther({
    super.key,
    required this.message,
    required this.messages,
    required this.index,
    required this.isDragging,
  });

  final auth = UserInfo(id: '4867a4a8-0a22-4af0-a15c-9d83a48e05b4');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        // nếu kéo thì hiện reply icon
        if (isDragging) const OnDraggingReplyIcon(),

        // kiểm tra điều kiện hợp lệ để tạo ảnh
        if (HandleMessageItemUtil.checkRenderInfoSender(
          auth,
          messages,
          message,
          index,
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
            if (HandleMessageItemUtil.checkRenderInfoSender(
              auth,
              messages,
              message,
              index,
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
                if (message.reply != null && message.isRecall == null) ...[
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
