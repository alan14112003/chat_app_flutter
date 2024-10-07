import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/data/sources/message_local_data_source.dart';
import 'package:chat_app_flutter/features/message/data/sources/message_remote_data_source.dart';
import 'package:chat_app_flutter/features/message/data/sources/send_message_body.dart';
import 'package:chat_app_flutter/features/message/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  // remote data source
  final MessageRemoteDataSource _messageRemoteDataSource;
  // local data source
  final MessageLocalDataSource _messageLocalDataSource;

  MessageRepositoryImpl({
    required MessageRemoteDataSource messageRemoteDataSource,
    required MessageLocalDataSource messageLocalDataSource,
  })  : _messageRemoteDataSource = messageRemoteDataSource,
        _messageLocalDataSource = messageLocalDataSource;

  @override
  Future<List<Message>> getAllMessages(
    String chatId,
    int? before,
  ) async {
    final messages = await _messageRemoteDataSource.getAllMessage(
      chatId,
      before,
    );

    if (before == null) {
      // thêm vào local datasource
      await setLocalMessages(chatId, messages);

      return messages;
    }

    // lấy ra message đã lưu
    final oldMessages = getLocalMessages(chatId);

    // thêm message mới vào
    final fullMessages = [...oldMessages, ...messages];

    // lưu lại danh sách full messages
    await setLocalMessages(chatId, fullMessages);

    return fullMessages;
  }

  @override
  Future<Message> getMessage(int messageId) async {
    final message = await _messageRemoteDataSource.getMessage(messageId);
    return message;
  }

  @override
  Future<Message> sendMessage(
    String chatId,
    SendMessageBody messageBody,
  ) async {
    final message = await _messageRemoteDataSource.sendMessage(
      chatId,
      messageBody,
    );

    return message;
  }

  @override
  List<Message> getLocalMessages(String chatId) {
    return _messageLocalDataSource.getMessages(chatId);
  }

  @override
  Future<bool> setLocalMessages(String chatId, List<Message> messages) {
    return _messageLocalDataSource.setMessages(chatId, messages);
  }

  @override
  Future<bool> deleteMessage(int messageId) {
    return _messageRemoteDataSource.deleteMessage(messageId);
  }

  @override
  Future<Message> recallMessage(int messageId) {
    return _messageRemoteDataSource.recallMessage(messageId);
  }
}
