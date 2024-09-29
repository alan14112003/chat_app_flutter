import 'package:chat_app_flutter/core/common/models/message.dart';
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
}
