import 'package:chat_app_flutter/core/common/widgets/bottom_navigation.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view/friend_view_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/contact/search_bar_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/invite/app_bar_invite_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/invite/user_list_invite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => InviteScreen(),
      );

  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FriendViewBloc>().add(LoadRequestFriendsEvent());
  }

  void _goBack(BuildContext context) {
    context.read<FriendViewBloc>().add(LoadAllFriendsEvent());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          padding: const EdgeInsets.only(top: 22.0, bottom: 6.0),
          child: AppBarInviteContact(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _goBack(context),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SearchBarContact(),
          Expanded(
            child: BlocConsumer<FriendViewBloc, FriendViewState>(
              listener: (context, state) {
                if (state is FriendViewError) {
                  showSnackBar(context, state.message);
                  return;
                }
              },
              builder: (context, state) {
                if (state is FriendViewLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FriendViewSuccess) {
                  final friends = state.friends
                      .map((friend) => {
                            'id': friend.userFrom ?? '',
                            'name': friend.from?.fullName ?? '',
                            'avatar': friend.from?.avatar ?? ''
                          })
                      .toList();
                  return UserListInvite(inviteFriends: friends);
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
