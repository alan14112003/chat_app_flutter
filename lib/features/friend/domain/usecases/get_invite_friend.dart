import 'package:chat_app_flutter/core/common/models/friend.dart';
import 'package:chat_app_flutter/features/friend/domain/repositories/friend_repository.dart';


class GetInviteFriends {
  final FriendRepository friendRepository;

  GetInviteFriends({required this.friendRepository});

  Future<List<Friend>> call() async {
    return await friendRepository.getInviteFriends();
  }
}
