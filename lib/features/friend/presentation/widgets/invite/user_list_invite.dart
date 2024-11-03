
import 'package:chat_app_flutter/features/friend/presentation/bloc/event/friend_user_handle_event.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/state/friend_user_handle_state.dart';
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
        final letter = inviteFriend['name']?.substring(0, 1).toUpperCase() ?? '';

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
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              BlocBuilder<FriendUserHandleBloc, FriendUserHandleState>(
                builder: (context, addFriendState) {
                  return BlocBuilder<FriendUserHandleBloc, FriendUserHandleState>(
                    builder: (context, removeFriendState) {
                      if (addFriendState is FriendAddedSuccessfully) {
                        return const Text('Đã chấp nhận lời mời kết bạn');
                      } else if (removeFriendState is FriendRemoveSuccessfully) {
                        return const Text('Đã gỡ lời mời');
                      } else {
                        return Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                final friendId = inviteFriend['id'];
                                if (friendId != null) {
                                  context.read<FriendUserHandleBloc>().add(AcceptFriendEvent(friendId));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              child: const Text(
                                'Xác nhận',
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () {
                                final friendId = inviteFriend['id'];
                                if (friendId != null) {
                                  context.read<FriendUserHandleBloc>().add(DeleteFriendEvent(friendId));
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              child: const Text('Gỡ', style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
