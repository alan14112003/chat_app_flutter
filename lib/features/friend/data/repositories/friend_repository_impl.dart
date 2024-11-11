import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/core/common/models/user_with_friend.dart';
import 'package:chat_app_flutter/features/friend/data/sources/friend_remote_data_source.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FriendRemoteDataSource remoteDataSource;

  FriendRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Friend>> allFriends() async {
    return await remoteDataSource.allFriends();
  }

  @override
  Future<List<Friend>> requestFriends() async {
    return await remoteDataSource.requestFriends();
  }

  @override
  Future<void> addFriendById(String friendId) async {
    return await remoteDataSource.addFriendById(friendId);
  }

  @override
  Future<void> acceptFriendById(String friendId) async {
    return await remoteDataSource.acceptFriendById(friendId);
  }

  @override
  Future<void> removeFriend(String friendId) async {
    return await remoteDataSource.removeFriendById(friendId);
  }

  @override
  Future<UserWithFriend?> findFriendByEmail(String email) async {
    return await remoteDataSource.findFriendByEmail(email);
  }
}
