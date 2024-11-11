import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/utils/auth_global_utils.dart';

class HandleFriendUtils {
  static User getInfoFriend(Friend friend) {
    final auth = AuthGlobalUtils.getAuth();
    if (auth.id == friend.userFrom) {
      return friend.to!;
    }
    return friend.from!;
  }
}
