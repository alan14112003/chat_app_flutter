import 'package:chat_app_flutter/core/common/models/message.dart';

abstract interface class MessageRepository {
  Future<List<Message>> getAllMessages(String chatId);

  Future<Message> getMessage(int messageId);

  Future<Message> sendTextMessages(
    String chatId, {
    required String content,
    int? replyId,
  });

  List<Message> getLocalMessages(String chatId);
  Future<bool> setLocalMessages(String chatId, List<Message> messages);
}
