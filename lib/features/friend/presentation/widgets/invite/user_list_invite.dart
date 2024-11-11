import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view/friend_view_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/buttons/accept_button.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/buttons/delete_request_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListInvite extends StatelessWidget {
  final List<Map<String, String>> inviteFriends;

  const UserListInvite({super.key, required this.inviteFriends});

  @override
  Widget build(BuildContext context) {
    if (inviteFriends.isEmpty) {
      return Center(
        child: Text(
          'Danh sách lời mời trống',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: inviteFriends.length,
      itemBuilder: (context, index) {
        final inviteFriend = inviteFriends[index];
        final letter =
            inviteFriend['name']?.substring(0, 1).toUpperCase() ?? '';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: inviteFriend['avatar'] != null
                    ? NetworkImage(inviteFriend['avatar']!)
                    : null,
                radius: 25,
                child: inviteFriend['avatar'] == null ? Text(letter) : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inviteFriend['name'] ?? 'Unknown',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  AcceptButton(friendId: inviteFriend['id']!),
                  const SizedBox(width: 8),
                  DeleteRequestButton(
                    friendId: inviteFriend['id']!,
                    onDeleteSuccess: () {
                      context
                          .read<FriendViewBloc>()
                          .add(ReloadRequestFriendsEvent());
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
