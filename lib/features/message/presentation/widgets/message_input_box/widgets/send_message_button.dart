import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_user_handle/message_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessageButton extends StatelessWidget {
  final TextEditingController controller;
  const SendMessageButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Message? messageReply = context.select(
      (MessageHandleCubit messageHandleCubit) =>
          messageHandleCubit.state.messageReply,
    );

    bool isChatBotContent = context.select(
      (MessageHandleCubit messageHandleCubit) =>
          messageHandleCubit.state.isChatBotContent,
    );

    String? chatId = context.select(
      (MessageHandleCubit messageHandleCubit) =>
          messageHandleCubit.state.chatId,
    );

    return IconButton(
      icon: const Icon(
        Icons.send,
        size: 30,
        color: Colors.blueAccent,
      ),
      onPressed: () {
        String content = controller.text.trim();
        if (content == '') {
          return;
        }
        context.read<MessageUserHandleBloc>().add(
              SendTextMessageEvent(
                chatId: chatId!,
                content: content,
                replyId: messageReply?.id,
                isChatBotContent: isChatBotContent,
              ),
            );
        // làm sạch input
        HandleMessageUtil.clearReplyMessage(context);

        controller.clear();
      }, // Gọi hàm gửi khi nhấn nút gửi
    );
  }
}
