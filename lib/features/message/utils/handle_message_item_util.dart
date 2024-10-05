import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/common/models/user_info.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/model_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HandleMessageItemUtil {
  static bool checkRenderInfoSender(
    UserInfo auth,
    List<Message> messages,
    Message message,
    int index,
  ) {
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

  static MainAxisAlignment getMainAxisAlignmentByMessage(
    Message message,
    UserInfo auth,
  ) {
    if (message.sender?.id == auth.id) {
      return MainAxisAlignment.end;
    }

    return MainAxisAlignment.start;
  }

  static void showMessageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const ModelBottomSheet();
      },
    );
  }

  static void handleReplyMessage(BuildContext context,
      {required Message message}) {
    context.read<MessageHandleCubit>().setMessageReply(message);
  }

  static bool checkSameSenderMessage(
    List<Message> messages,
    Message message,
    int index,
  ) {
    if (index != messages.length - 1 &&
        messages[index + 1].sender?.id == message.sender?.id) {
      return true;
    }
    return false;
  }
}
