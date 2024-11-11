import 'package:chat_app_flutter/core/common/models/user_with_friend.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/buttons/accept_button.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/buttons/add_friend_button.dart';
import 'package:flutter/material.dart';

class UserListSuggest extends StatelessWidget {
  final UserWithFriend user;

  const UserListSuggest({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.user.avatar!),
            radius: 25,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.user.fullName ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          Row(
            children: [
              if (user.friend == null)
                AddFriendButton(
                  friendId: user.user.id!,
                ),
              if (user.friend?.status == 0 &&
                  user.friend?.userFrom == user.user.id)
                AcceptButton(
                  friendId: user.friend!.userFrom!,
                ),
              if (user.friend != null &&
                  (user.friend?.status == 1 ||
                      user.friend?.userTo == user.user.id))
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text('Gỡ', style: TextStyle(color: Colors.black)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
