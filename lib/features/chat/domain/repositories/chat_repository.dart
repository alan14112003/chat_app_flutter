import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/common/models/user.dart';

abstract interface class ChatRepository {
  Future<List<Chat>> getAllChats();
  Future<Chat> getChat(String chatId);
  Future<List<Friend>> getAllFriends();
  Future<String> addGroup({
    required String groupName,
    required List<User> members,
  });
}
