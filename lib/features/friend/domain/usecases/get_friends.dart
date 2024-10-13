import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:chat_app_flutter/features/friend/domain/entities/friend.dart';

class GetFriends {
  final FriendRepository friendRepository;

  GetFriends({required this.friendRepository});

  Future<List<Friend>> call() async {
    return await friendRepository.getFriends();
  }
}
