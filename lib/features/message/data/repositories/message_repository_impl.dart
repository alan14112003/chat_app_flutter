import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/constants/message_type_enum.dart';
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
  Future<List<Message>> getAllMessages(String chatId) async {
    final messages = await _messageRemoteDataSource.getAllMessage(chatId);

    // thêm vào local datasource
    await setLocalMessages(chatId, messages);

    return messages;
  }

  @override
  Future<Message> getMessage(int messageId) async {
    final message = await _messageRemoteDataSource.getMessage(messageId);
    return message;
  }

  @override
  Future<Message> sendTextMessages(
    String chatId, {
    required String content,
    int? replyId,
  }) async {
    final message = await _messageRemoteDataSource.sendMessage(
      chatId,
      SendMessageBody(
        type: MessageTypeEnum.TEXT,
        text: content,
        replyId: replyId,
      ),
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
}
