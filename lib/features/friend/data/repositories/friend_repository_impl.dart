
import 'package:chat_app_flutter/features/friend/data/sources/friend_remote_data_source.dart';
import 'package:chat_app_flutter/features/friend/domain/entities/friend.dart';

import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:chat_app_flutter/features/friend/presentation/models/user.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FriendRemoteDataSource remoteDataSource;

  FriendRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getFriends() async {
    return await remoteDataSource.getFriends();
  }

  @override
  Future<void> addFriend(Friend friend) async {

  }

  @override
  Future<void> removeFriend(int friendId) async {

  }
}
