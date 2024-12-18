import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:dio/dio.dart';

class VideoCallRemoteDataSource {
  final Dio _dio;

  VideoCallRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<int> joinVideoCall(
    String chatId,
  ) async {
    final res = await _dio.post(
      '/chats/$chatId/video-call/join',
    );

    return res.data['videoCallState'];
  }

  Future<void> refuseVideoCall(
    String chatId,
  ) async {
    await _dio.post(
      '/chats/$chatId/video-call/refuse',
    );
  }

  Future<void> closeVideoCall(
    String chatId,
  ) async {
    await _dio.post(
      '/chats/$chatId/video-call/close',
    );
  }

  Future<User> getUserById(
    String userId,
  ) async {
    final response = await _dio.get(
      '/users/$userId',
    );

    return User.fromJson(response.data);
  }
}
