import 'package:chat_app_flutter/features/video_call/data/sources/video_call_remote_data_source.dart';
import 'package:chat_app_flutter/features/video_call/domain/repositories/video_call_repository.dart';

class VideoCallRepositoryImpl implements VideoCallRepository {
  final VideoCallRemoteDataSource _videoCallRemoteDataSource;

  VideoCallRepositoryImpl({
    required VideoCallRemoteDataSource videoCallRemoteDataSource,
  }) : _videoCallRemoteDataSource = videoCallRemoteDataSource;

  @override
  Future<void> joinVideoCall(String chatId) async {
    await _videoCallRemoteDataSource.joinVideoCall(chatId);
  }

  @override
  Future<void> refuseVideoCall(String chatId) async {
    await _videoCallRemoteDataSource.refuseVideoCall(chatId);
  }
}
