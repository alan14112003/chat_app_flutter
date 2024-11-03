import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/features/friend/data/sources/friend_remote_data_source.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';


class FriendRepositoryImpl implements FriendRepository {
  final FriendRemoteDataSource remoteDataSource;

  FriendRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Friend>> getFriends() async {
    return await remoteDataSource.getFriends();
  }

  @override
  Future<List<Friend>> getInviteFriends() async {
    return await remoteDataSource.getInviteFriends();
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
  Future<void> addFriendById(String friendId) async{
    return await remoteDataSource.addFriendById(friendId);
  }
}
