import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_user_handle/message_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageDeleteDialog extends StatelessWidget {
  final Message message;

  const MessageDeleteDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Bạn muốn gỡ tin nhắn này ở phía ai?'),
      children: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            context.read<MessageUserHandleBloc>().add(
                  DeleteMessageEvent(
                    message: message,
                  ),
                );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Chỉ mình tôi'),
              Icon(Icons.delete),
            ],
          ),
        ),
        if (HandleMessageUtil.isMessageByAuth(
          context,
          message: message,
        ))
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              // Xử lý sự kiện Forward
              context.read<MessageUserHandleBloc>().add(
                    RecallMessageEvent(
                      messageId: message.id!,
                    ),
                  );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Đối với mọi người'),
                Icon(Icons.delete),
              ],
            ),
          ),
      ],
    );
  }
}
