import 'package:chat_app_flutter/features/friend/domain/entities/friend.dart';

abstract class FriendRepository {
  Future<List<Friend>> getFriends();
  Future<void> addFriend(Friend friend);
  Future<void> removeFriend(int friendId);
}
