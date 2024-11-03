import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';


class AcceptFriend {
  final FriendRepository friendRepository;

  AcceptFriend({required this.friendRepository});

  Future<void> call(String id) async {
    await friendRepository.acceptFriendById(id);
  }

}
