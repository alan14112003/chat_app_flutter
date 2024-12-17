abstract interface class VideoCallRepository {
  Future<void> joinVideoCall(String chatId);
  Future<void> refuseVideoCall(String chatId);
}
