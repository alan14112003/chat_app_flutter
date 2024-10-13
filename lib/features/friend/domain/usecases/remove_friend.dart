import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';

class RemoveFriend {
  final FriendRepository friendRepository;

  RemoveFriend({required this.friendRepository});

  Future<void> call(int friendId) async {
    await friendRepository.removeFriend(friendId);
  }
}
