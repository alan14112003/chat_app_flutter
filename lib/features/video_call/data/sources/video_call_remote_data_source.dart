import 'package:dio/dio.dart';

class VideoCallRemoteDataSource {
  final Dio _dio;

  VideoCallRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<void> joinVideoCall(
    String chatId,
  ) async {
    await _dio.post(
      '/chats/$chatId/video-call/join',
    );
  }

  Future<void> refuseVideoCall(
    String chatId,
  ) async {
    await _dio.post(
      '/chats/$chatId/video-call/refuse',
    );
  }
}
