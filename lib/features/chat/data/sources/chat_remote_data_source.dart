import 'package:chat_app_flutter/core/common/models/chat.dart';
import 'package:dio/dio.dart';

class ChatRemoteDataSource {
  final Dio _dio;

  ChatRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  Future<List<Chat>> getAllChats() async {
    final Response<List<dynamic>> chats = await _dio.get(
      '/chats',
    );
    print('Received chats: ${chats.data}');
    // trả về danh sách sau khi map qua Chat
    return chats.data!.map<Chat>((chat) => Chat.fromJson(chat)).toList();
  }

  Future<Chat> getChat(String chatId) async {
    final Response<dynamic> chat = await _dio.get(
      '/chats/$chatId',
    );
    print(chat.data);

    // trả về danh sách sau khi map qua Chat
    return Chat.fromJson(chat.data as Map<String, Object?>);
  }
}
