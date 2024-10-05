import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/data/sources/send_message_body.dart';
import 'package:dio/dio.dart';

class MessageRemoteDataSource {
  final Dio _dio;

  MessageRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  Future<List<Message>> getAllMessage(String chatId) async {
    final Response<List<dynamic>> messages =
        await _dio.get('/chats/$chatId/messages');

    // trả về danh sách sau khi map qua Message
    return messages.data!
        .map<Message>((message) => Message.fromJson(message))
        .toList();
  }

  Future<Message> getMessage(int messageId) async {
    final Response<dynamic> message = await _dio.get('/messages/$messageId');

    // trả về message sau khi được map
    return Message.fromJson(message.data);
  }

  Future<Message> sendMessage(
    String chatId,
    SendMessageBody sendMessageBody,
  ) async {
    final Response<dynamic> message = await _dio.post(
      '/chats/$chatId/messages',
      data: sendMessageBody.toJson(),
    );

    // trả về Message đã map từ response
    return Message.fromJson(message.data);
  }
}
