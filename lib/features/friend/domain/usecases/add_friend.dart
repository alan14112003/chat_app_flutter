import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:chat_app_flutter/features/friend/domain/entities/friend.dart';

class AddFriend {
  final FriendRepository friendRepository;

  AddFriend({required this.friendRepository});

  Future<void> call(Friend friend) async {
    await friendRepository.addFriend(friend);
  }
}
