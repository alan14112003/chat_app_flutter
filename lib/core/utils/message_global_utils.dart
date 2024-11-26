import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';

class MessageGlobalUtils {
  static String getTextRender(Message message) {
    if (message.isRecall == true) {
      return 'Đã thu hồi tin nhắn';
    }
    if (message.type == MessageTypeEnum.IMAGE) {
      return 'Hình ảnh';
    }
    return message.text ?? '';
  }
}
