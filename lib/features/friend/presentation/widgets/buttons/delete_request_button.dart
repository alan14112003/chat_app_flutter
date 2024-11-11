import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_user_handle/friend_user_handle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteRequestButton extends StatelessWidget {
  final String friendId;
  final void Function() onDeleteSuccess;

  const DeleteRequestButton({
    super.key,
    required this.friendId,
    required this.onDeleteSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendUserHandleBloc, FriendUserHandleState>(
      listener: (context, state) {
        if (state is FriendDeletedSuccessfully) {
          onDeleteSuccess();
          showSnackBar(context, 'Đã gỡ lời mời kết bạn');
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is FriendUserHandleLoading,
          child: OutlinedButton(
            onPressed: () {
              context.read<FriendUserHandleBloc>().add(
                    DeleteFriendEvent(friendId: friendId),
                  );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            child: const Text(
              'Gỡ',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
