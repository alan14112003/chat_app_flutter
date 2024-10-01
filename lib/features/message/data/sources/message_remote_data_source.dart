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

  Future<Message> sendMessage(
    String chatId, {
    required int type,
    String? text,
    String? file,
    String? image,
    int? replyId,
  }) async {
    final Response<dynamic> message = await _dio.post(
      '/chats/$chatId/messages',
      data: {
        'chatId': chatId,
        'type': type,
        'text': text,
        'file': file,
        'image': image,
        'replyId': replyId,
      },
    );

    // trả về Message đã map từ response
    return Message.fromJson(message.data);
  }
}
