import 'package:chat_app_flutter/core/common/models/chat.dart';

abstract interface class ChatRepository {
  Future<List<Chat>> getAllChats();
}
