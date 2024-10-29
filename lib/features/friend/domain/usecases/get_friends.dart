import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';
import 'package:chat_app_flutter/features/friend/domain/entities/friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/models/user.dart';

class GetFriends {
  final FriendRepository friendRepository;

  GetFriends({required this.friendRepository});

  Future<List<User>> call() async {
    return await friendRepository.getFriends();
  }
}
