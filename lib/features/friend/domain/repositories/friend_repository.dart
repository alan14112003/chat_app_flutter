import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/common/models/user_with_friend.dart';

abstract class FriendRepository {
  Future<List<Friend>> getFriends();
  Future<List<Friend>> getInviteFriends();
  Future<void> removeFriend(String friendId);
  Future<void> acceptFriendById(String friendId);
  Future<void> addFriendById(String friendId);
  Future<UserWithFriend?> findFriendByEmail(String email);
}
