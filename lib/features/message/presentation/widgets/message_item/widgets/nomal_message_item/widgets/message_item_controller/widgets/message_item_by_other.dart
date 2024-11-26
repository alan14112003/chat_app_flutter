import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';
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
  final bool isTranslate;
  final dynamic handleBack;

  const MessageItemByOther({
    super.key,
    required this.message,
    required this.messages,
    required this.index,
    required this.isDragging,
    required this.isTranslate,
    required this.handleBack,
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
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue, // Màu của viền
                width: 1.0, // Độ dày của viền
              ),
            ),
            child: CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(message.sender?.avatar ?? ''),
            ),
          )
        else
          const SizedBox(
            width: 24,
          ),

        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                if (!isTranslate)
                  MessageBody(message: message)
                else
                  // Sử dụng FutureBuilder cho renderBody
                  ...[
                  FutureBuilder<Widget>(
                    future: renderBody(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return snapshot.data!;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: GestureDetector(
                      onTap: () {
                        if (handleBack != null) {
                          handleBack();
                        }
                      },
                      child: Text(
                        'Bản gốc',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 134, 3, 157),
                        ),
                      ),
                    ),
                  )
                ]
              ],
            )
          ],
        ),
      ],
    );
  }

  Future<Widget> renderBody() async {
    if (message.type != MessageTypeEnum.TEXT) {
      return MessageBody(message: message);
    }
    final translateData = await HandleMessageUtil.translateMessage(message);
    if (translateData['from'] == 'vi') {
      return MessageBody(message: message);
    }
    return MessageBody(message: translateData['message']);
  }
}
