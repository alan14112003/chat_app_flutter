import 'package:chat_app_flutter/features/friend/domain/entities/friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/models/user.dart';

abstract class FriendRepository {
  Future<List<User>> getFriends();
  Future<void> addFriend(Friend friend);
  Future<void> removeFriend(int friendId);
}
