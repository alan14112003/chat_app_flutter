import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/features/video_call/data/sources/video_call_remote_data_source.dart';
import 'package:chat_app_flutter/features/video_call/domain/repositories/video_call_repository.dart';

class VideoCallRepositoryImpl implements VideoCallRepository {
  final VideoCallRemoteDataSource _videoCallRemoteDataSource;

  VideoCallRepositoryImpl({
    required VideoCallRemoteDataSource videoCallRemoteDataSource,
  }) : _videoCallRemoteDataSource = videoCallRemoteDataSource;

  @override
  Future<int> joinVideoCall(String chatId) async {
    final data = await _videoCallRemoteDataSource.joinVideoCall(chatId);
    return data;
  }

  @override
  Future<void> refuseVideoCall(String chatId) async {
    await _videoCallRemoteDataSource.refuseVideoCall(chatId);
  }

  @override
  Future<void> closeVideoCall(String chatId) async {
    await _videoCallRemoteDataSource.closeVideoCall(chatId);
  }

  @override
  Future<User> getUserById(String userId) async {
    return await _videoCallRemoteDataSource.getUserById(userId);
  }
}
