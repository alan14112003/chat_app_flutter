import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_user_handle/friend_user_handle_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcceptButton extends StatelessWidget {
  final String friendId;

  const AcceptButton({
    super.key,
    required this.friendId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendUserHandleBloc, FriendUserHandleState>(
      listener: (context, state) {
        if (state is FriendAcceptedSuccessfully) {
          Navigator.push(context, ContactScreen.route());
          showSnackBar(context, 'Đã chấp nhận lời mời kết bạn');
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is FriendUserHandleLoading,
          child: ElevatedButton(
            onPressed: () {
              context.read<FriendUserHandleBloc>().add(
                    AcceptFriendEvent(friendId: friendId),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            child: const Text(
              'Xác nhận',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
