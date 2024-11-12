import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/utils/auth_global_utils.dart';

class ChatGlobalUtils {
  static bool isGroupChat(Chat chat) {
    return chat.isGroup == true;
  }

  static User getChatFriend(Chat chat) {
    // final auth = User(id: '4867a4a8-0a22-4af0-a15c-9d83a48e05b4');
    final auth = AuthGlobalUtils.getAuth();
    return chat.members!.firstWhere(
      (user) => user.id != auth.id,
    );
  }

  static String getNameAvatarGroupChat(Chat chat) {
    return chat.members!
        .map((member) => member.firstName![0])
        .take(3) // Lấy tối đa 3 ký tự
        .join()
        .toUpperCase();
  }
}
