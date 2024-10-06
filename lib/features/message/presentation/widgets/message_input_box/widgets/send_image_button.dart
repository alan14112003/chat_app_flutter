import 'dart:io';

import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/utils/handle_message_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendImageButton extends StatefulWidget {
  const SendImageButton({super.key});

  @override
  State<SendImageButton> createState() => _SendImageButtonState();
}

class _SendImageButtonState extends State<SendImageButton> {
  @override
  Widget build(BuildContext context) {
    final chatId = context.select<MessageHandleCubit, String>(
      (messageHandleCubit) => messageHandleCubit.state.chatId,
    );

    final replyMessage = context.select<MessageHandleCubit, Message?>(
      (messageHandleCubit) => messageHandleCubit.state.messageReply,
    );

    return GestureDetector(
      onTap: () async {
        // Xử lý khi nhấn vào icon ảnh
        File? image = await HandleMessageUtil.pickImage();
        if (image != null && context.mounted) {
          context.read<MessageBloc>().add(
                SendImageMessageEvent(
                  chatId: chatId,
                  content: image,
                  replyId: replyMessage?.id,
                ),
              );

          HandleMessageUtil.clearReplyMessage(context);
        }
      },
      child: const Icon(
        Icons.image_outlined,
        size: 24,
      ),
    );
  }
}
