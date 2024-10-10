import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';
import 'package:chat_app_flutter/core/theme/app_theme.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/message_reply_controller.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/widgets/image_message.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/widgets/nomal_message_item/widgets/message_body/widgets/text_message.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';

enum MessageBodyType { normal, reply }

class MessageBody extends StatelessWidget {
  final Message message;
  final MessageBodyType type;

  const MessageBody({
    super.key,
    required this.message,
    this.type = MessageBodyType.normal,
  });

  Widget _loadBody() {
    // nếu message đã bị thu hồi
    if (HandleMessageUtil.isRecallMessage(message)) {
      final messageRecall = message.copyWith(
        text: '${message.sender?.firstName} đã thu hồi tin nhắn',
      );

      return TextMessage(
        message: messageRecall,
        messageBodyType: MessageBodyType.reply,
      );
    }

    switch (message.type) {
      case MessageTypeEnum.TEXT:
        return TextMessage(
          message: message,
          messageBodyType: type,
        );
      case MessageTypeEnum.IMAGE:
        return ImageMessage(
          message: message,
          messageBodyType: type,
        );
      default:
        return const SizedBox();
    }
  }

  Color _setColorBgMessage(BuildContext context) {
    if (type == MessageBodyType.reply ||
        HandleMessageUtil.isRecallMessage(message)) {
      return Theme.of(context).onSurface40;
    }

    if (HandleMessageUtil.isMessageByAuth(context, message: message)) {
      return Theme.of(context).primary;
    }

    return Theme.of(context).secondarySurface;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      child: MessageReplyController(
        message: message,
        type: type,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: _setColorBgMessage(context),
          ),
          child: type == MessageBodyType.normal
              ?
              // message thường
              _loadBody()
              :
              // message phản hồi
              Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.reply,
                            color: Colors.white,
                          ),
                          Text(
                            message.sender?.fullName ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _loadBody(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
