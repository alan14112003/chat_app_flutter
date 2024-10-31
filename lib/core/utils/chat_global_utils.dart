import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';

class ChatGlobalUtils {
  static bool isGroupChat(Chat chat) {
    return chat.isGroup == true;
  }

  static User getChatFriend(Chat chat) {
    final auth = User(id: '4867a4a8-0a22-4af0-a15c-9d83a48e05b4');
    return chat.members!.firstWhere(
      (user) => user.id != auth.id,
    );
  }
}
