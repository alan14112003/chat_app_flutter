import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/model_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HandleMessageUtil {
  static bool isRenderInfoSender(
    BuildContext context, {
    required List<Message> messages,
    required Message message,
    required int index,
  }) {
    // là tin nhắn cuối cùng
    if (index == messages.length - 1) {
      return true;
    }

    // tin nhắn trước đó là tin nhắn hệ thống
    else if (messages[index + 1].type == MessageTypeEnum.SYSTEM) {
      return true;
    }

    // người gửi tin nhắn tiếp theo khác tin nhắn hiện tại
    else if (messages[index + 1].sender?.id != message.sender?.id) {
      return true;
    }
    return false;
  }

  static bool isMessageByAuth(
    BuildContext context, {
    required Message message,
  }) {
    final auth = User(id: '4867a4a8-0a22-4af0-a15c-9d83a48e05b4');
    return message.sender?.id == auth.id;
  }

  static void showMessageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const ModelBottomSheet();
      },
    );
  }

  static void setReplyMessage(
    BuildContext context, {
    required Message message,
  }) {
    context.read<MessageHandleCubit>().setMessageReply(message);
  }

  static bool isRecallMessage(Message message) {
    return message.isRecall != null;
  }

  static bool hasReplyMessage(Message message) {
    return message.reply != null;
  }

  static bool isSameSenderMessage(
    List<Message> messages,
    Message message,
    int index,
  ) {
    return index != messages.length - 1 &&
        messages[index + 1].sender?.id == message.sender?.id;
  }
}
