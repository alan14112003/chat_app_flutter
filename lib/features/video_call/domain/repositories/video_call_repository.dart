import 'package:chat_app_flutter/core/common/models/user.dart';

abstract interface class VideoCallRepository {
  Future<int> joinVideoCall(String chatId);
  Future<void> refuseVideoCall(String chatId);
  Future<void> closeVideoCall(String chatId);
  Future<User> getUserById(String userId);
}
