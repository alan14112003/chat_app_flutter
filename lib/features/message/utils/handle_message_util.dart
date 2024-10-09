import 'dart:io';

import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_bottom_sheet/message_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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

  static void showMessageOptions(BuildContext context,
      {required Message message}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MessageBottomSheet(
          message: message,
        );
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

  static Future<File?> pickImage(
      [ImageSource imageSource = ImageSource.gallery]) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static Future<List<Message>> addFetchedMessageToLocal(
    Message message,
    MessageRepository messageRepository,
  ) async {
    // lấy về message đầy đủ
    final messageFull = await messageRepository.getMessage(message.id as int);

    // lấy ra messages trong shared
    final messages = messageRepository.getLocalMessages(
      messageFull.chatId as String,
    );

    // thêm vào danh sách
    messages.insert(0, messageFull);

    // lưu lại vào shared
    messageRepository.setLocalMessages(
      messageFull.chatId as String,
      messages,
    );

    return messages;
  }

  static void clearReplyMessage(BuildContext context) {
    final messageReply = context.read<MessageHandleCubit>().state.messageReply;

    if (messageReply != null) {
      context.read<MessageHandleCubit>().setMessageReply(null);
    }
  }
}
